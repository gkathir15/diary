import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeline/model/timeline_model.dart';
import 'UI/transCards/cardFlipper.dart';
import 'UI/transCards/card_data.dart';
import 'UI/CustomBottomBar/fab_bottom_app_bar.dart';
import 'UI/CustomBottomBar/fab_with_icons.dart';
import 'UI/CustomBottomBar/layout.dart';
import 'constants/AppConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model/SplashData.dart';

GoogleSignIn googleSignIn = GoogleSignIn();
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseUser fireBaseUser;
Firestore fireStore;
SharedPreferences sharedPreferences;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      checkerboardOffscreenLayers: true,
      title: 'Diary',
      theme: ThemeData(primarySwatch: Colors.blue, splashColor: Colors.white,
      bottomAppBarColor: Colors.black,
      backgroundColor: Colors.black,
      accentColor: Colors.transparent),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double scrollPercent = 0.0;
  List<CardViewModel> demCards = demoCards;
  @override
  Widget build(BuildContext context) {
    return fireBaseUser == null
        ? Scaffold(
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
                          setState(() {
                            _handleSignIn();
                          });
                        },
                      )
                    ],
                  )
                ],
              )),
            )

            // This trailing comma makes auto-formatting nicer for build methods.
            )
        : Scaffold(
          backgroundColor: Colors.black,
            bottomNavigationBar: FABBottomAppBar(
              backgroundColor: Colors.amber,
              centerItemText: 'New',
              color: Colors.white,
              selectedColor: Colors.blueAccent,
              notchedShape: CircularNotchedRectangle(),
              onTabSelected: _selectedTab,
              items: [
                FABBottomAppBarItem(iconData: Icons.date_range, text: 'Calendar'),
                FABBottomAppBarItem(iconData: Icons.notifications, text: 'Notifications'),
                FABBottomAppBarItem(iconData: Icons.settings, text: 'Settings'),
                FABBottomAppBarItem(iconData: Icons.info, text: 'Profile'),
              ],
            ),
//    bottomNavigationBar: BottomNavigationBar(
//      items: [
//        BottomNavigationBarItem(icon: Icon(Icons.date_range),title:Text("Calendar")),
//        BottomNavigationBarItem(icon: Icon(Icons.settings),title:Text("Settings")),
//        BottomNavigationBarItem(icon: Icon(Icons.info),title:Text("Profile"))
//     ],
//      fixedColor: Colors.black,
//      type: BottomNavigationBarType.fixed,
//
//    ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: new FloatingActionButton(
              shape:  CircleBorder(side: BorderSide.lerp(BorderSide(color: Colors.black), BorderSide(color: Colors.black), 2.0)),
              foregroundColor: Colors.white,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                elevation: 2.0,
                onPressed: () {}),
            body: Container(
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/jpgs/mainBg.jpg"),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  )),
              child: StreamBuilder(
                  stream:
                      Firestore.instance.collection('DIARY_DATA').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Text("Loading",
                          style: new TextStyle(color: Colors.white));
                    return AnimCards(
                      cards: demCards,
                      animOnScroll: (double scrollPercent) {
                        setState(() => this.scrollPercent = scrollPercent);
                      },
                      scrollPercent: scrollPercent,
                    );
                  }),
            ),
          );
  }

  String _lastSelected = 'TAB: 0';

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = 'TAB: $index';
    });
  }

  void _selectedFab(int index) {
    setState(() {
      _lastSelected = 'FAB: $index';
    });
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

  _handleSilentSignIn() async {
    GoogleSignInAccount googleSignInAccount =
        await googleSignIn.signInSilently(suppressErrors: true);
    GoogleSignInAuthentication googleAuth =
        await googleSignInAccount.authentication;
    fireBaseUser = await auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    setState(() {});
  }

  getSplashBgDate() async {
    sharedPreferences = await SharedPreferences.getInstance();
    List<String> data;
    if (!sharedPreferences.getBool(IS_SPLASH_DATA_STORED)) {
      var response = await http.get(thumbsJsonUrl).catchError(() {
        sharedPreferences.setBool(IS_SPLASH_DATA_STORED, false);
        return;
      });
      Map responseMap = json.decode(response.body);
      data = SplashData.fromJson(responseMap).data;
      for (int i = 0; i <= data.length; i++) {
        sharedPreferences.setString(SPLASH_Pic + i.toString(), data[i]);
      }
      sharedPreferences.setString(SPLASH_DATA_SIZE, data.length.toString());
      sharedPreferences.setBool(IS_SPLASH_DATA_STORED, true);
    }
  }

  List<TimelineModel> getTimeLineSnapshot(
      AsyncSnapshot<QuerySnapshot> qSnapshot) {
    print(qSnapshot.data.documents.length);
    List<TimelineModel> _list = new List();
    if (qSnapshot.data.documents != null) {
      for (int i = 0; i < qSnapshot.data.documents.length; i++) {
        _list.add(new TimelineModel(
            id: qSnapshot.data.documents[i]['DATE'],
            title: qSnapshot.data.documents[i]['DATE']));
      }
    }
    print("list len" + _list.length.toString());
    return _list;
  }

  Widget _buildFab() {
    final icons = [Icons.sms, Icons.mail, Icons.phone];
    return AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
          child: FabWithIcons(
            icons: icons,
            onIconTapped: _selectedFab,
          ),
        );
      },
      child: FloatingActionButton(
        onPressed: () {
          print("Fab");
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );
  }

  @override
  void initState() {
    _handleSilentSignIn();
    super.initState();
  }
}
