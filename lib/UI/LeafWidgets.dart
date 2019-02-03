import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:diary/constants/AppConstants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:diary/main.dart';
import 'package:path/path.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeAgo;
import 'package:diary/util/ImageUtils.dart';
import 'MQueries.dart';

class LeafData extends StatelessWidget {
  final String data, fontFamily,  writerImgUrl, writerName, paraType;
  final Color fontColor;
  final Timestamp timeStamp;
  static BuildContext lContext;

  const LeafData(
      {Key key,
      this.data,
      this.fontFamily,
      this.fontColor,
      this.writerImgUrl,
      this.writerName,
      this.paraType,
      this.timeStamp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    lContext = context;
    switch (paraType) {
      case TYPE_TEXT:
       return  returnText(context);
        break;
      case TYPE_IMAGE:
        return returnImage();
        break;
      case TYPE_AUDIO:
        return returnAudio();
        break;
      case TYPE_VIDEO:
        return returnVideo();
        break;
      case TYPE_LINK:
        return returnLink();
        break;

    }
  }

  Widget returnText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.0,top: 3.0,right: 2.0,bottom: 6.0),
      child:  Column(
          children: <Widget>[
            new Text(
              data,
              softWrap: true,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 4.0,
                  inherit: true,
                  color: Colors.white,
                  fontFamily: 'Handlee'),
            ),
            new Row(
              children: <Widget>[
                new CircleAvatar(
                  child: new CachedNetworkImage(
                      imageUrl: AppConstants.defaultIfNull(
                          writerImgUrl, fireBaseUser.photoUrl)),
                  radius: 0.1,

                ),
                new Text(AppConstants.defaultIfNull(
                    writerName, fireBaseUser.displayName),style: TextStyle(fontFamily: 'Handlee',color: Colors.white,fontSize: 0.3),),
                new Text(timeAgo.format(timeStamp.toDate()),style: TextStyle(fontFamily: 'Handlee',color: Colors.white,fontSize: 0.3),),
              ],
            )
          ],
        ),

    );
  }

  Widget returnImage() {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0,top: 3.0,right: 2.0,bottom: 6.0),
      child: FittedBox(
        child: CachedNetworkImage(placeholder: SizedBox(
          width: 200.0,
          height: 100.0,
          child: Shimmer.fromColors(
            baseColor: Colors.red,
            highlightColor: Colors.yellow,
            child: Container(
              color: Colors.orangeAccent,
              ),
            ),
          ),
          imageUrl: data,
          fadeInCurve: Curves.easeOut,
        ),),
    );
    //TODO
  }

  Widget returnAudio() {
    return FittedBox();
    //TODO
  }

  Widget returnVideo() {
    return FittedBox();
    //TODO
  }

  Widget returnLink() {
    return FittedBox();
    //TODO
  }


}
Widget returnEditText(Function onSubmit,TextEditingController txtEditController,BuildContext context)
{
  return

    Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: TextField(controller:txtEditController,textCapitalization: TextCapitalization.sentences,
          textAlign: TextAlign.justify,textInputAction: TextInputAction.send,
          onSubmitted: onSubmit,
          //onEditingComplete:onSubmit,

          autocorrect: true,keyboardAppearance: Brightness.dark,
          maxLengthEnforced: false,enableInteractiveSelection: true,enabled: true,
         // focusNode: focusNode,
          maxLines: 3,decoration: const InputDecoration(),style: TextStyle(fontFamily:'bloom',inherit: true,fontSize: MediaQuery.of(context).devicePixelRatio*10),
        )
    );
//    TextField(controller:txtEditController,textCapitalization: TextCapitalization.sentences,
//      textAlign: TextAlign.justify,textInputAction: TextInputAction.done,
//      onSubmitted: onSubmit,autocorrect: true,keyboardAppearance: Brightness.dark,
//      maxLengthEnforced: false,enableInteractiveSelection: true,enabled: true,
//      maxLines: 3,decoration: const InputDecoration(),
//    );
 // );
}
