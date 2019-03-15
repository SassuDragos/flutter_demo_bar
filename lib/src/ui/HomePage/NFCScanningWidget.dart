import 'package:flutter/material.dart';

class NFCScanningWidget extends StatefulWidget {
  NFCScanningWidget({Key key, this.tableId}) : super(key: key);
  final Future<String> tableId;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NFCScanningWidgetState();
  }
}

class NFCScanningWidgetState extends State<NFCScanningWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: widget.tableId,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Center(
            child: Text("Table ID: ${widget.tableId}"),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
