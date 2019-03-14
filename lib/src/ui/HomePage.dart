import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platform = const MethodChannel('app.channel.shared.tableId');
  String tableId = "";

  @override
  void initState() {
    super.initState();
    getTableId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text("Table ID: \n"+tableId),
            )
          ],
        ),
      ),
    );
  }

  getTableId() async {
    var sharedData = await platform.invokeMethod("getTableId");
    if (sharedData != null) {
      setState(() {
        tableId = sharedData;
      });
    }
  }
}
