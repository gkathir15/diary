import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:diary/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:diary/util/AppUtilMethods.dart';

class SignInPage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.black,
          body: Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/jpgs/signIn.jpg"),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                )),
            child: new Center(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Text("Diary",
                        style: const TextStyle(
                          fontFamily: "Handlee",
                          color: Colors.white,
                          fontSize: 100.0,
                        )),
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        new Text(
                          "Sign in with",
                          style: new TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontFamily: "bloom"),
                        ),
                        new InkWell(
                          splashColor: Colors.white24,
                          child: new Image.asset(
                            "assets/pngs/google.png",
                            height: MediaQuery.of(context).size.width / 5,
                            width: MediaQuery.of(context).size.width / 5,
                          ),
                          onTap: () {
                            _handleSignIn();
                          },
                        )
                      ],
                    )
                  ],
                )),
          )

        // This trailing comma makes auto-formatting nicer for build methods.
      );
  }

  _handleSignIn() async {
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = await auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    ).whenComplete((){
      setSignedIn(true);
    });
    print("signed in " + user.displayName);
    fireBaseUser = user;
  }

}