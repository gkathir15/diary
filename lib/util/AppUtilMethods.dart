import 'package:diary/main.dart';
import 'package:local_auth/auth_strings.dart';
import "package:diary/constants/AppConstants.dart";
import 'package:local_auth/local_auth.dart';


 bool isUseSigned()
 {
  return sharedPreferences.getBool(IS_SIGNED_IN);
 }

 void setSignedIn(bool state)
 {
  sharedPreferences.setBool(IS_SIGNED_IN, state);
 }

 bool isFingerPrintEnabled()
 {
  new LocalAuthentication().getAvailableBiometrics().then((onValue){
   return onValue.contains(BiometricType.fingerprint);
  });
 }


 bool isFingerPrintAuthDone()
 {
   if(isFingerPrintEnabled()) {
     new LocalAuthentication().authenticateWithBiometrics(
       localizedReason: "Authenticate with Fingerprint to Continue"
       ,
       useErrorDialogs: true,
       androidAuthStrings: const AndroidAuthMessages(
         fingerprintHint: "Place finger",
         fingerprintNotRecognized: "Unrecognized",
         fingerprintSuccess: "Sucess",
         cancelButton: "Cancel",
         signInTitle: "Sign in to $appTitle",),).then((onValue) {
       return onValue;
     });
   }else
     {
       return true;
     }
 }