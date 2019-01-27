import 'package:flutter/material.dart';
import 'package:path/path.dart';

class MQueries{

  static Size getSize(BuildContext context)
  {
    return MediaQuery.of(context).size;
  }

  static double getPixelRatio(BuildContext context)
  {
    return MediaQuery.of(context).devicePixelRatio;
  }

  static double getTextScaleFactor(BuildContext context)
  {
    return MediaQuery.of(context).textScaleFactor;
  }
}