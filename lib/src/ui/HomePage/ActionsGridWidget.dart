import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/actions_bloc.dart';
import 'package:flutter_app/src/blocs/tables_bloc.dart';
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
                          Icon(getIconForActionType(
                              actionList.data[index].actionType)),
                          Container(
                              height: 40.0,
                              child: Center(
                                  child: Text(
                                textFromActionType(
                                    actionList.data[index].actionType),
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
            onTap: () {
              tablesBloc.sentTableRequest(
                  textFromActionType(actionList.data[index].actionType));
            },
          );
        });
  }

  String textFromActionType(ActionTypes action) {
    switch (action) {
      case ActionTypes.offer_1:
        return "Tuborg offer 3+1";
      case ActionTypes.check:
        return "Check please";
      case ActionTypes.one_more:
        return "One more round";
      case ActionTypes.surprise:
        return "Surprise me!";
    }
  }

  IconData getIconForActionType(ActionTypes type) {
    switch (type) {
      case ActionTypes.offer_1:
        return Icons.local_offer;
      case ActionTypes.check:
        return Icons.payment;
      case ActionTypes.one_more:
        return Icons.more;
      case ActionTypes.surprise:
        return Icons.card_giftcard;
    }
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
