import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary/constants/AppConstants.dart';
import 'package:diary/model/Para.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:diary/main.dart';
class ImageUtils
{
  static uploadImage(String pageDate,ImageSource src) async {
    File imageFile = await ImagePicker.pickImage(source: src);
    StorageReference ref =
    FirebaseStorage.instance.ref().child(TYPE_IMAGE).child(Timestamp.now().toDate().toString());
    StorageUploadTask uploadTask = ref.putFile(imageFile);

     await (await uploadTask.onComplete).ref.getDownloadURL().then((value){
       print('got url');
       fireStore
           .collection('DIARY_DATA')
           .document(pageDate).collection(PARA_DATA).add({
         PARA_TYPE: TYPE_IMAGE,
         PARA_DATA: value,
         PARA_FONT: 'Handlee',
         PARA_TIMESTAMP: Timestamp.now(),
         PARA_WRITER: fireBaseUser.email,
         PARA_CREATOR_URL: fireBaseUser.photoUrl
       });
     });
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