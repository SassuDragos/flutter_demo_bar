import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/company_bloc.dart';
import 'package:flutter_app/src/blocs/tables_bloc.dart';
import 'package:flutter_app/src/models/company_info_model.dart';
import 'package:flutter_app/src/ui/HomePage/ActionsGridWidget.dart';
import 'package:flutter_app/src/ui/HomePage/NFCScanningWidget.dart';
import 'package:rxdart/rxdart.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  Observable<String> tableId;

  @override
  void initState() {
    super.initState();
    //TODO: Comment this to have the NFC
    tableId = tablesBloc.tableIdStream;
    tablesBloc.scanTableId();
  }

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
          child: _getActiveWidgets(tableId != null),
        ));
  }

  Widget _getActiveWidgets(bool hasScannedTable) {
    if (hasScannedTable) {
      return Column(
        children: <Widget>[
          //TODO: Comment this to have the NFC
          NFCScanningWidget(tableIdStream: tableId),
          StreamBuilder(
              stream: companyBloc.companyInfoStream,
              builder: (BuildContext context,
                      AsyncSnapshot<CompanyInfo> snapshot) =>
                  new Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(snapshot?.data?.iconUrl))),
                  )),
          Expanded(child: ActionsGridWidget()),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Text("Scan an NFC tag in your favorite bar and you'll be surprised"),
          RaisedButton(
            onPressed: () {
              tablesBloc.scanTableId();
            },
            child: const Text('Scan'),
          ),
        ],
      );
    }
  }
}
