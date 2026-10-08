package com.mvpgreenhouse.ng_poland_conf_app

import android.content.Intent
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "ngpoland/network_settings")
      .setMethodCallHandler { call, result ->
        if (call.method == "open") {
          startActivity(Intent(Settings.ACTION_WIRELESS_SETTINGS))
          result.success(null)
        } else {
          result.notImplemented()
        }
      }
  }
}
