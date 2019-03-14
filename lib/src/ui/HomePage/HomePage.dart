import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/company_bloc.dart';
import 'package:flutter_app/src/models/company_info_model.dart';
import 'package:flutter_app/src/ui/HomePage/ActionsGridView.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    companyBloc.fetchCompanyInfo();
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
            child: Column(
              children: <Widget>[
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
                                  image: new NetworkImage(
                                      snapshot?.data?.iconUrl))),
                        )),
                Expanded(child: ActionGrid()),
              ],
            )));
  }
}
