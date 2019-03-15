package com.example.flutter_app

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

import android.content.Intent
import android.nfc.NfcAdapter
import io.flutter.plugin.common.MethodChannel

import android.util.Log

class MainActivity : FlutterActivity() {

  private var tableId: String? = null

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    handleIntent(intent)

    MethodChannel(flutterView, "app.channel.shared.tableId").setMethodCallHandler { call, result ->
      if (call.method.contentEquals("getTableId")) {
        result.success(tableId)
        //tableId = null
      }
    }
  }

  override fun onNewIntent(intent: Intent?) {
    super.onNewIntent(intent)
    Log.d("TEST", "TEST1")
    handleIntent(intent)
  }

  internal fun handleIntent(intent: Intent?) {
    val intent = intent
    val action = intent?.action
    val data = intent?.data
    if (NfcAdapter.ACTION_NDEF_DISCOVERED == action && data != null) {
      handleNDEFDiscoveredIntent(intent)
    }
  }

  internal fun handleNDEFDiscoveredIntent(intent: Intent) {
    Log.d("TEST", "TEST2")
    val data = intent.data
    val pathSegments = data?.pathSegments
    if (pathSegments?.getOrNull(0) == "table") {
      tableId = pathSegments[1].toString()
      Log.d("TEST", "TEST3")

      MethodChannel(flutterView, "app.channel.shared.tableId").invokeMethod("notifyNewTableId", tableId)

    }
  }
}
