import 'package:flutter/material.dart';
import 'package:diary/main.dart';
import 'package:diary/constants/AppConstants.dart';
import 'package:diary/UI/transCards/cardFlipper.dart';
import 'package:diary/UI/transCards/DateCard.dart';
import 'package:diary/UI/transCards/AnimCardBottomBar.dart';

class LeafPage extends StatefulWidget {
  @override
  State createState() {
    LeafState();
  }
}

class LeafState extends State<LeafPage> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      endDrawer: Icon(Icons.arrow_back_ios),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
