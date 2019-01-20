import 'package:flutter/material.dart';
import 'package:diary/constants/AppConstants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:diary/main.dart';
import 'package:path/path.dart';

class LeafData extends StatelessWidget {
  final String data, fontFamily,  writerImgUrl, writerName, paraType;
  final Color fontColor;

  const LeafData(
      {Key key,
      this.data,
      this.fontFamily,
      this.fontColor,
      this.writerImgUrl,
      this.writerName,
      this.paraType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (paraType) {
      case TYPE_TEXT:
        returnText();
        break;
      case TYPE_IMAGE:
        returnImage();
        break;
      case TYPE_AUDIO:
        returnAudio();
        break;
      case TYPE_VIDEO:
        returnVideo();
        break;
      case TYPE_LINK:
        returnLink();
        break;
    }
  }

  Widget returnText() {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Column(
        children: <Widget>[
          new Text(
            data,
            softWrap: true,
            textAlign: TextAlign.left,
            style: TextStyle(
                inherit: true,
                color: Colors.white,
                fontFamily: AppConstants.defaultIfNull(fontFamily, 'bloom')),
          ),
          new Row(
            children: <Widget>[
              new CircleAvatar(
                child: new CachedNetworkImage(
                    imageUrl: AppConstants.defaultIfNull(
                        writerImgUrl, fireBaseUser.photoUrl)),
              ),
              new Text(AppConstants.defaultIfNull(
                  writerName, fireBaseUser.displayName))
            ],
          )
        ],
      ),
    );
  }

  Widget returnImage() {
    return FittedBox();
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
