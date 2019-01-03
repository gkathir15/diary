package com.gkathir.diary

import android.os.Bundle
//import com.facebook.Stetho

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

import com.facebook.stetho.InspectorModulesProvider
import com.facebook.stetho.Stetho
import com.facebook.stetho.inspector.protocol.ChromeDevtoolsDomain

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    Stetho.initializeWithDefaults(this);
  }
}
