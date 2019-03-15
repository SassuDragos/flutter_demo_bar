import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/actions_bloc.dart';
import 'package:flutter_app/src/models/action_model.dart';
import 'package:flutter_app/src/utils.dart';

class ActionsGridWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ActionsGridWidgetState();
  }
}

class ActionsGridWidgetState extends State<ActionsGridWidget> {
  @override
  void initState() {
    super.initState();
    actionBloc.fetchAllActions();
  }

  @override
  void dispose() {
    actionBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    actionBloc.fetchAllActions();
    return StreamBuilder(
      stream: actionBloc.allActions,
      builder: (context, AsyncSnapshot<List<Action>> actionList) {
        if (actionList.hasData) {
          return buildGrid(actionList);
        } else if (actionList.hasError) {
          return Text(actionList.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildGrid(AsyncSnapshot<List<Action>> actionList) {
    return GridView.builder(
        itemCount: actionList.data.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: new Card(
                  elevation: 2.0,
                  child: new Padding(
                      padding: EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 16, bottom: 8.0),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Image.asset(
                              getIconForActionType(
                              actionList.data[index].actionType)),
                          Container(
                              height: 40.0,
                              child: Center(
                                  child: Text(
                                actionList.data[index].name,
                                style: TextStyle(
                                    fontSize: 12,
                                    letterSpacing: 0.3,
                                    color:
                                        utils.getColorFromStringHex("#c5c5c5")),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              ))),
                        ],
                      )),
                )),
          );
        });
  }

  String getIconForActionType(ActionTypes type) {
    return 'assets/images/lake.jpg';

    //    switch (type) {
//      case ActionTypes.offer_1:
//      case ActionTypes.offer_2:
//        return Icons.check;
//      case ActionTypes.offer_3:
//        return Icons.check;
//      case ActionTypes.check:
//        return Icons.check;
//      case ActionTypes.one_more:
//        return Icons.check;
//      case ActionTypes.surprise:
//        return Icons.check;
    }
  }
}
