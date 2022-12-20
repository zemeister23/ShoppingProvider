package com.hamkorbank.mobile

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {
  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    MapKitFactory.setLocale("ru_RU") 
    MapKitFactory.setApiKey("390c7ddb-0ad4-483b-bd03-32a4b888a1d0") 
    super.configureFlutterEngine(flutterEngine)
  }
}