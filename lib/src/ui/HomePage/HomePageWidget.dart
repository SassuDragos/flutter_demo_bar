import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/company_bloc.dart';
import 'package:flutter_app/src/blocs/tables_bloc.dart';
import 'package:flutter_app/src/models/company_info_model.dart';
import 'package:flutter_app/src/ui/HomePage/ActionsGridWidget.dart';
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
        body: Padding(
      padding:
          EdgeInsets.only(left: 25.0, top: 62.0, right: 25.0, bottom: 25.0),
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
          StreamBuilder<CompanyInfo>(
            stream: companyBloc.companyInfoStream,
            builder: (context, stream) {
              if (stream.hasData) {
                return Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 0, bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                            child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${stream.data.welcomeText} \n',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black)),
                              TextSpan(
                                  text: '${stream?.data?.name}',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: stream?.data?.color)),
                            ],
                          ),
                        )),
                        Padding(
                          padding: EdgeInsets.all(24.0),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          elevation: 5.0,
                          child: new Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: new BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new NetworkImage(
                                        stream?.data?.iconUrl))),
                          ),
                        )
                      ],
                    ));
              } else if (stream.hasError) {
                return Text("${stream.error}");
              } else {
                return new Container(width: 0, height: 118);
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
