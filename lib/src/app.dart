
import 'package:flutter/material.dart';
import 'package:flutter_app/src/ui/HomePage/HomePageWidget.dart';

class FlutterBarApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterBar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePageWidget(title: 'Home Page'),
    );
  }
}

