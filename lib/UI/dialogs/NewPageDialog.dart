import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diary/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:diary/constants/AppConstants.dart';

class NewPagDialog extends StatelessWidget {
  final String title;
  SharedPreferences sharedPreferences;
  String selectedUrl;

  NewPagDialog({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SimpleDialog(
      contentPadding: EdgeInsets.all(2.0),
      shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      title: Text(title),
      children: <Widget>[
        Container(
          child: new ListView(

            scrollDirection: Axis.vertical,
            children: <Widget>[
              new Center(
                child: CircleAvatar(
                  backgroundImage:
                      CachedNetworkImageProvider(fireBaseUser.photoUrl),
                ),
              ),
              Text(
                "Select a Background",
                style: new TextStyle(color: Colors.white),
              ),
              new ListView.builder(
                scrollDirection: Axis.horizontal,
                itemExtent: 5.0,
                itemCount: sharedPreferences != null
                    ? sharedPreferences.getInt(SPLASH_DATA_SIZE)
                    : 0,
                itemBuilder: (BuildContext context, int index) {
                  sharedPreferences =
                      SharedPreferences.getInstance() as SharedPreferences;
                  return new InkWell(
                    child: new ClipRRect(
                      child: CachedNetworkImage(
                          imageUrl: sharedPreferences
                              .get(SPLASH_Pic + index.toString())),
                    ),
                  );
                },
              ),
              new Text("or select from Gallery"),
              new InkWell(
                child: new Icon(Icons.image),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, selectedUrl);
                },
                child: Text("Done"),
              )
            ],
          ),
        )
      ],
    );
  }
}
