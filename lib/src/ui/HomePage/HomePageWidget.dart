import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/company_bloc.dart';
import 'package:flutter_app/src/blocs/tables_bloc.dart';
import 'package:flutter_app/src/models/company_info_model.dart';
import 'package:flutter_app/src/repositories/data_repository.dart';
import 'package:flutter_app/src/ui/HomePage/ActionsGridWidget.dart';
import 'package:flutter_app/src/ui/HomePage/NFCScanningWidget.dart';
import 'package:path/path.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:progress_indicators/progress_indicators.dart';


class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  String tableId;

  @override
  void dispose() {
    companyBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: StreamBuilder(
          stream: companyBloc.companyInfoStream,
          builder:
              (BuildContext context, AsyncSnapshot<CompanyInfo> snapshot) =>
                  Text(snapshot?.data?.name ?? "Just a home screen"),
        )),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: StreamBuilder(
            stream: tablesBloc.tableIdStream,
            builder:
                (BuildContext context, AsyncSnapshot<String> tableIdSnapshot) =>
                    _getActiveWidgets(tableIdSnapshot.data != null),
          ),
        ));
  }

  Widget _getActiveWidgets(bool hasScannedTable) {
    if (hasScannedTable) {
      return Column(
        children: <Widget>[
          //NFCScanningWidget(tableIdStream: tablesBloc.tableIdStream),
          StreamBuilder(
            stream: companyBloc.companyInfoStream,
            builder: (context, stream) {
              if (stream.hasData) {
                return new Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(stream?.data?.iconUrl))),
                );
              } else if (stream.hasError) {
                return Text("${stream.error}");
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          Expanded(child: ActionsGridWidget()),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Scan an NFC tag in your favorite bar and you'll be surprised",
            textAlign: TextAlign.center,
          ),
          Padding(padding: EdgeInsets.all(10.0)),
          HeartbeatProgressIndicator(
            child: Icon(Icons.nfc),
          ),
        ],
      );
    }
  }
}
