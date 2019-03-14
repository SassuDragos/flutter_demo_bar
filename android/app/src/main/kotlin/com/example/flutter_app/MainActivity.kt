package com.example.flutter_app

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

import android.content.Intent
import android.nfc.NfcAdapter
import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

  private var tableId: String? = null

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    val intent = intent
    val action = intent.action
    val data = intent.data

    if (NfcAdapter.ACTION_NDEF_DISCOVERED == action && data != null) {
      handleNDEFDiscoveredIntent(intent)
    }

    MethodChannel(flutterView, "app.channel.shared.tableId").setMethodCallHandler { call, result ->
      if (call.method.contentEquals("getTableId")) {
        result.success(tableId)
        tableId = null
      }
    }
  }

  internal fun handleNDEFDiscoveredIntent(intent: Intent) {
    val data = intent.data
    val pathSegments = data?.pathSegments
    if (pathSegments?.getOrNull(0) == "table") {
      tableId = pathSegments[1].toString()
    }
  }
}
