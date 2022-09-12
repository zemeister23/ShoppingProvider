package com.hamkorbank.mobile

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    MapKitFactory.setLocale("YOUR_LOCALE") 
    MapKitFactory.setApiKey("390c7ddb-0ad4-483b-bd03-32a4b888a1d0") 
    super.configureFlutterEngine(flutterEngine)
  }
}