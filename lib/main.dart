import 'package:date_format/date_format.dart';
import 'package:date_format/date_format.dart';
import 'package:diary/UI/LeafPage.dart';
import 'package:diary/UI/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
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
import 'package:date_format/date_format.dart';
import 'dart:core';
import 'package:connectivity/connectivity.dart';
import 'UI/dialogs/NewPageDialog.dart';
import 'dart:ui';
import 'UI/transCards/card_data.dart';
import 'util/AppUtilMethods.dart';
import 'constants/AppConstants.dart';
import 'UI/SignInPage.dart';

GoogleSignIn googleSignIn = GoogleSignIn();
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseUser fireBaseUser;
Firestore fireStore;
SharedPreferences sharedPreferences;


void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
  fireStore = Firestore.instance;
  fireStore.settings(
      persistenceEnabled: true, timestampsInSnapshotsEnabled: true);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      '/':(context)=>MyHomePage(),
      'GOOGLE_LOGIN':(context)=>SignInPage(),

    },
      initialRoute: '/',
      checkerboardOffscreenLayers: true,
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        splashColor: Colors.white,
        bottomAppBarColor: Colors.black,
        backgroundColor: Colors.black,
        accentColor: Colors.transparent,
        primaryColorDark: Colors.transparent,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  double scrollPercent = 0.0;
  List<DiaryDataModel> demCards;
 static  BuildContext fContext;
  @override
  Widget build(BuildContext context) {
    fContext = context;
    return isFingerPrintAuthDone()?
         Scaffold(
            backgroundColor: Colors.black,
            bottomNavigationBar: FABBottomAppBar(
              backgroundColor: Colors.amber,
              centerItemText: 'New',
              color: Colors.white,
              selectedColor: Colors.blueAccent,
              notchedShape: CircularNotchedRectangle(),
              onTabSelected: _selectedTab,
              items: [
                FABBottomAppBarItem(
                    iconData: Icons.date_range, text: 'Calendar'),
                FABBottomAppBarItem(
                    iconData: Icons.notifications, text: 'Notifications'),
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
            floatingActionButton:
            new FloatingActionButton(
                shape: CircleBorder(
                    side: BorderSide.lerp(BorderSide(color: Colors.black),
                        BorderSide(color: Colors.black), 2.0)),
                foregroundColor: Colors.white,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                elevation: 2.0,
                onPressed: () {
                 createOrNavigateToPage(todayDateAsDDMMYY(), fContext);
                }),
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
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData)
                      return Text("Loading",
                          style: new TextStyle(color: Colors.white));
                    return AnimCards(
                      cards:
                          DiaryDataModel.fromSnapShot(snapshot.data.documents),
                      animOnScroll: (double scrollPercent) {
                        setState(() => this.scrollPercent = scrollPercent);
                      },
                      scrollPercent: scrollPercent,
                    );
                  }),
            ),
          ):
        Scaffold(body: Center(child: Stack(children: <Widget>[
          Image.asset("assets/jpgs/unauth.jpg")
        ],
        ),),);
  }

  Function  OnTap = (String _DateString)
  {
    Navigator.of(fContext).push(new MaterialPageRoute(
        builder: (BuildContext context) => LeafPage(pageDate: _DateString)));
  };

  String _lastSelected = 'TAB: 0';

  void _selectedTab(int index) {
    switch (index) {
      case 2:
        Navigator.of(fContext).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                LeafPage(pageDate: todayDateAsDDMMYY())));
        break;
      case 3:
        Navigator.of(fContext).push(MaterialPageRoute(
            builder: (BuildContext context) => ProfilePage()));
    }
  }

  void _selectedFab(int index) {
    setState(() {
      _lastSelected = 'FAB: $index';
      print('_MyHomePageState._selectedFab$index');
    });
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
    //print(sharedPreferences.getBool(IS_SPLASH_DATA_STORED));
    if (sharedPreferences.getBool(IS_SPLASH_DATA_STORED) == null ||
        !sharedPreferences.getBool(IS_SPLASH_DATA_STORED)) {
      var response = await http.get(thumbsJsonUrl).catchError(() {
        sharedPreferences.setBool(IS_SPLASH_DATA_STORED, false);
        return;
      });
      Map responseMap = json.decode(response.body);
      data = SplashData.fromJson(responseMap).data;
      for (int i = 0; i < data.length; i++) {
        sharedPreferences.setString(SPLASH_Pic + i.toString(), data[i]);
      }
      sharedPreferences.setInt(SPLASH_DATA_SIZE, data.length);
      sharedPreferences.setBool(IS_SPLASH_DATA_STORED, true);
    }
  }

  String todayDateAsDDMMYY() {
    String formattedDate;
    DateTime dateTime = DateTime.now();
    formattedDate = formatDate(dateTime, [dd, '.', mm, '.', yyyy]);
    return formattedDate;
  }

  createOrNavigateToPage(String dateString, BuildContext context) async {
    fireStore.collection(Collection_DIARY_DATA).document(dateString).get().then((onValue) {
      if (onValue.exists) {
        print("nav");
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => LeafPage(pageDate: dateString)));
      }
      else {
        print("Create nav");
        fireStore
            .collection(Collection_DIARY_DATA)
            .document(todayDateAsDDMMYY())
            .setData({
          DATE_ID: todayDateAsDDMMYY(),
          CARD_CREATED_AT: Timestamp.now(),
          CARD_CREATED_BY: fireBaseUser.email,
          CREATED_DAY: AppConstants.getDay(DateTime
              .now()
              .weekday),
          IS_READ_BY_CREATOR: true,
          IS_READ_BY_RECIEVER: false,
          BG_URL: sharedPreferences.get(SPLASH_Pic + DateTime
              .now()
              .day
              .toString()),
          PARA_COUNT:0
        }, merge: true).whenComplete(() {
          print("fab on created page");
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) =>
                  LeafPage(pageDate: dateString)));
        });
      }
    });

   }



  bool getNetWorkStatus() {
    var connectivityResult = (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return true;
    }
  }

  ShowDialogIFCardNotPresent(BuildContext context) {
//   if(getNetWorkStatus())
//     {
    // showDialog(context: context,child: NewPagDialog(title: todayDateAsDDMMYY()));
    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) {
            return new NewPagDialog(title: todayDateAsDDMMYY());
          },
          fullscreenDialog: true,
        ));
//     }
  }

  Widget buildFab() {
    final icons = [Icons.sms, Icons.mail, Icons.phone];
    return AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
          child: FabWithIcons(
            iconColor: Colors.black,
            fabBg: Colors.white,
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
    if(fireBaseUser==null)
    _handleSilentSignIn();
    getSplashBgDate();
    super.initState();
  }
}
