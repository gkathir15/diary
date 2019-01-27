import 'dart:io';

import 'package:diary/constants/AppConstants.dart';
import 'package:diary/model/Para.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
class ImageUtils
{
  uploadImage(String imageId,ImageSource src) async {
    File imageFile = await ImagePicker.pickImage(source: src);
    StorageReference ref =
    FirebaseStorage.instance.ref().child(TYPE_IMAGE).child(imageId);
    StorageUploadTask uploadTask = ref.putFile(imageFile);
    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }
  
  showUploadDialog(Paras para,BuildContext context)
  {
    ImageSource imageSource;
  var dialog =   SimpleDialog(title: Text("Upload Image",style: TextStyle(color: Colors.amberAccent
    ),),titlePadding: EdgeInsets.all(2.0),children: <Widget>[
      new Row(
        children: <Widget>[
          InkWell(child: new Icon(Icons.camera,color: Colors.white,),onTap: (){
            imageSource = ImageSource.camera;
            uploadImage(para.lPARA_TIMESTAMP.toDate().toString(),imageSource);
          },),
          InkWell(child: new Icon(Icons.image,color: Colors.white,), onTap: (){
  imageSource = ImageSource.camera;
  uploadImage(para.lPARA_TIMESTAMP.toDate().toString(),imageSource);
  },),
        ],
      )
    ],);

      showDialog(context: context,barrierDismissible: true,builder: (context)=>dialog);
  }
}