import 'package:diary/UI/CustomBottomBar/fab_with_icons.dart';
import 'package:flutter/material.dart';
import 'package:diary/main.dart';

class LeafPage extends StatefulWidget {

  final String pageDate;

  const LeafPage({Key key, this.pageDate}) : super(key: key);

  @override
  LeafState createState() => LeafState();


}

class LeafState extends State<LeafPage> {


  int fabSelectedNo =0;
  ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Icon(Icons.arrow_back_ios,color: Colors.white,),
      floatingActionButton:FabWithIcons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor:Colors.black,
      appBar: AppBar(toolbarOpacity:0.0 ,backgroundColor: Colors.transparent,),
      body: new Container(
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,
        color: Colors.black,
        padding: EdgeInsets.only(left: 2.0,right: 2.0,top: 0.0,bottom: 10),
        child: StreamBuilder(builder: (context, snapshot){

        if(snapshot.hasData)
          {
            return AnimatedList(controller:scrollController,itemBuilder: (BuildContext context, int index, Animation<double> animation)
              {
                return FittedBox();
              },initialItemCount: 0,scrollDirection: Axis.vertical,);
          }else
            {
              return const CircularProgressIndicator();
            }


        },stream: fireStore.collection('DIARY_DATA').document(widget.pageDate).snapshots(),),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
  }



  fAB()
  {
    //return FloatingActionButton(isExtended:true,onPressed:_buildFab,backgroundColor: Colors.white,child:Icon(Icons.mode_edit,color: Colors.amber,),highlightElevation: 3.0,elevation: 6.0,);
  }

//  Widget _buildFab() {
//    final icons = [Icons.sms, Icons.image, Icons.videocam];
//    return AnchoredOverlay(
//      showOverlay: true,
//      overlayBuilder: (context, offset) {
//        return CenterAbout(
//          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
//          child: FabWithIcons(
//            icons: icons,
//            onIconTapped:_selectedFab ,
//          ),
//        );
//      },
//      child: FloatingActionButton(
//        onPressed: () {
//          print("Fab");
//        },
//        tooltip: 'add',
//        child: Icon(Icons.mode_edit,color: Colors.deepOrangeAccent,),
//        elevation: 2.0,
//      ),
//    );
//  }

  void _selectedFab(int index) {
//    setState(() {
//      fabSelectedNo = 'FAB: $index';
//    });
  }
}
