import 'dart:io';

import 'package:flutter/material.dart';
import 'package:diary/main.dart';

class ProfilePage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("Profile"),elevation:5.0 ),
      body:  Container(
                child:Center(child:Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text("Welcome",style: TextStyle(fontSize: 20.0),),
                    Text(fireBaseUser.displayName,style: TextStyle(fontSize: 20.0),),
                    InkWell(child: Icon(Icons.exit_to_app,size: 20.0,),onTap: (){
                      fireBaseUser.delete();
                      auth.signOut().whenComplete((){
                        exit(0);
                      });
                    },)

                  ],
                ),)
            ),

    );
  }

}