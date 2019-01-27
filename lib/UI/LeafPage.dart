import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary/UI/CustomBottomBar/fab_with_icons.dart';
import 'package:diary/UI/CustomBottomBar/layout.dart';
import 'package:flutter/material.dart';
import 'package:diary/main.dart';
import 'package:diary/constants/AppConstants.dart';
import 'package:diary/UI/transCards/cardFlipper.dart';
import 'package:diary/UI/transCards/DateCard.dart';
import 'package:diary/UI/transCards/AnimCardBottomBar.dart';
import 'LeafWidgets.dart';
import 'package:diary/model/Para.dart';
import 'package:shimmer/shimmer.dart';
class LeafPage extends StatefulWidget {
  final String pageDate;

  const LeafPage({Key key, this.pageDate}) : super(key: key);

  @override
  LeafState createState() => LeafState();
}

class LeafState extends State<LeafPage> {
  int fabSelectedNo = 0;
  ScrollController scrollController;
  final icons = [Icons.sms, Icons.image, Icons.videocam];
  bool isShowEditText = false;
  List<Paras> paraDataList = new List();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      endDrawer: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
        size: 2.0,
      ),
//      bottomSheet: BottomSheet(onClosing: null, builder:(BuildContext context){
//        return returnEditText(submitData(), textEditingController);
//      }),
      floatingActionButton: fAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.pageDate,style: TextStyle(color: Colors.white),),
        centerTitle: true,
        leading: InkWell(onTap:(){Navigator.of(context).pop();},child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        elevation: 5.0,
        backgroundColor: Colors.transparent,
      ),
      body: new Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        padding: EdgeInsets.only(left: 2.0, right: 2.0, top: 0.0, bottom: 10),
        child:
            StreamBuilder(
              builder: (context,AsyncSnapshot<QuerySnapshot>  snapshot) {
                if (snapshot.hasData||paraDataList.length!=0) {
                  paraDataList.addAll(Paras.getParaList(snapshot.data.documents));
                  return ListView.builder(
                    shrinkWrap: true,
                    controller: scrollController,
                    itemCount: paraDataList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context,int index)
                    {
                      return LeafData(data:paraDataList[index].lPARA_DATA,
                        fontColor: Colors.white,
                        fontFamily: paraDataList[index].lPARA_FONT,
                        writerImgUrl:paraDataList[index].lPARA_CREATOR_URL,
                        writerName:paraDataList[index].lPARA_WRITER ,
                        paraType: paraDataList[index].lPARA_TYPE,
                      timeStamp: paraDataList[index].lPARA_TIMESTAMP,);
                    },
                  );
                } else {
                  return Container(child:
                  //const CircularProgressIndicator(),);
                      new Image.asset("assets/pngs/emptyCat.png",width: double.infinity,height: double.infinity,),);
                }
              },
              stream: fireStore
                  .collection('DIARY_DATA')
                  .document(widget.pageDate).collection(PARA_DATA).snapshots(),
            ),
      )
    );

  }



  @override
  void initState() {
    super.initState();
  }

  fAB() {
    return FloatingActionButton(
      isExtended: true,
      onPressed: onFabTap,
      backgroundColor: Colors.white,
      child: Icon(
        Icons.mode_edit,
        color: Colors.amber,
      ),
      highlightElevation: 3.0,
      elevation: 6.0,
    );
  }

  Widget _buildFab() {
    final icons = [Icons.sms, Icons.image, Icons.videocam];
    return AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
          child: FabWithIcons(
            icons: icons,
            onIconTapped: _selectedFab,
          ),
        );
      },
      child: FloatingActionButton(
        onPressed: () {
          print("Fab");
        },
        tooltip: 'add',
        child: Icon(
          Icons.mode_edit,
          color: Colors.deepPurple,
        ),
        elevation: 2.0,
      ),
    );
  }

  onFabTap() {
    print("fab tap");

    showBottomSheetEditText(context);


  }

//  void _listener(){
//    if(focusNode.hasFocus){
//      // keyboard appeared
//    }else{
//      // keyboard dismissed
//      Navigator.pop(context);
//    }
//  }
  TextEditingController textEditingController;
  String fontFamily = "bloom";
  //FocusNode focusNode = new FocusNode();



  submitData()
  {

    print("submitData");
    String story;
    if(textEditingController.text!=null&&textEditingController.text.length!=0) {
      story = textEditingController.text;

      print(story.toString());


      List<dynamic> PARA = [];

      fireStore
          .collection('DIARY_DATA')
          .document(widget.pageDate).collection(PARA_DATA).add({
        PARA_TYPE: TYPE_TEXT,
        PARA_DATA: story,
        PARA_FONT: fontFamily,
        PARA_TIMESTAMP: Timestamp.now(),
        PARA_WRITER: fireBaseUser.email,
        PARA_CREATOR_URL: fireBaseUser.photoUrl
      });

     // fireStore.collection(widget.pageDate).document(PARA_COUNT).updateData(data)
//      });
//      PARA.add(
//          {
//        PARA_TYPE: TYPE_TEXT,
//        PARA_DATA: story,
//        PARA_FONT: fontFamily,
//        PARA_TIMESTAMP: Timestamp.now(),
//        PARA_WRITER: fireBaseUser.email,
//        PARA_CREATOR_URL: fireBaseUser.photoUrl
//      });
//      Paras paras = new Paras(PARA: PARA);
//
//      final TransactionHandler transactionHandler = (Transaction transaction) async {
//        await transaction.update(fireStore
//            .collection('DIARY_DATA').document(PARA_DATA), paras.toMap());
//      };
//      print(paras.toMap().toString());
//      Firestore.instance.runTransaction(transactionHandler);
      textEditingController.clear();
      Navigator.of(context).pop();

    }

  }


  showBottomSheetEditText(BuildContext context)
  {
    textEditingController = TextEditingController();
    //focusNode.addListener(_listener);
    showModalBottomSheet(context: context,builder: (BuildContext cxt){
      return Container(
        color: Colors.black38,
        child:returnEditText(submitData(), textEditingController,context),);
    });

  }



  void _selectedFab(int index) {
    print("fab"+index.toString());
//    setState(() {
//      fabSelectedNo = 'FAB: $index';
//    });
  }
}
