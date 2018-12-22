import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser fireBaseUser;

void main() => runApp(MyApp());

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
  @override
  Widget build(BuildContext context) {
    return fireBaseUser==null?Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black,
      body: Container(decoration: new BoxDecoration(image: new DecorationImage(image:new AssetImage("assets/jpgs/drew.jpg"),fit: BoxFit.cover,alignment: Alignment.center,)),

        child:
        new Center(
          child:new Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround ,
            children: <Widget>[
              new Text("Diary",style:const TextStyle(fontFamily: "Handlee",color: Colors.white,fontSize: 100.0,)),
              new Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
           new Text("Sign in with",style: new TextStyle(fontSize:30,color: Colors.white,fontFamily: "bloom"),),
           new InkWell(
             splashColor: Colors.white24,
             child: new Image.asset("assets/pngs/google.png",height: MediaQuery.of(context).size.width/5,width:  MediaQuery.of(context).size.width/5,),onTap:(){
               setState(() {
                 _handleSignIn();
               });
           },)
              ],)
            ],
          )
        ),
        )



      // This trailing comma makes auto-formatting nicer for build methods.
    ):Scaffold(
      floatingActionButton: new FloatingActionButton(backgroundColor:Colors.indigoAccent,onPressed: null,child: new Icon(Icons.add,),),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.black,
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar: BottomAppBar(notchMargin: 2.0,),
    );
  }

   _handleSignIn() async {
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = await auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print("signed in " + user.displayName);
    fireBaseUser = user;
  }
}
