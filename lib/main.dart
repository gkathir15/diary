import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'constants/FirebaseConsts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());

GoogleSignIn googleSignIn = GoogleSignIn();
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseUser fireBaseUser;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      checkerboardOffscreenLayers: true,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, splashColor: Colors.amber),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //FirebaseUser userData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Diary"),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
        ),
        body: fireBaseUser == null
            ? Center(
                child: new RaisedButton(
                onPressed: () {
                  _handleSignIn();
                },
                color: Colors.white,
                child: new Icon(
                  Icons.assignment_ind,
                  color: Colors.white,
                ),
              ))
            : new Center(
                child: new Text(
                  fireBaseUser != null ? fireBaseUser.email : "nulls",
                  style: new TextStyle(color: Colors.white),
                ),
              )

        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  void _handleSignIn() async {
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = await auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print("signed in " + user.displayName);
    fireBaseUser = user;
    setState(() {});
  }
}
