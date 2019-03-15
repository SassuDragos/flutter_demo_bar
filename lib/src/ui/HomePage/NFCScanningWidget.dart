import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class NFCScanningWidget extends StatefulWidget {
  NFCScanningWidget({Key key, this.tableIdStream}) : super(key: key);
  final Observable<String> tableIdStream;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NFCScanningWidgetState();
  }
}

class NFCScanningWidgetState extends State<NFCScanningWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: widget.tableIdStream,
      builder: (context, stream) {
        if (stream.hasData) {
          return Center(
            child: Text("Table ID: ${stream.data}"),
          );
        } else if (stream.hasError) {
          return Text("${stream.error}");
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
