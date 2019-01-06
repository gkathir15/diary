import 'package:flutter/material.dart';
import 'package:diary/main.dart';

class ProfilePage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("Profile"),elevation:5.0 ),
      body: Container(
          child:Center(child: Column(
            children: <Widget>[
              Text("Welcome"),
              Text(fireBaseUser.displayName),
            ],
          ),)
      ),
    );
  }

}