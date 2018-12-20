import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseConsts {
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser fireBaseUser;
}
