import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/actions_bloc.dart';
import 'package:flutter_app/src/models/action_model.dart';

class ActionGrid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ActionGridState();
  }
}

class ActionGridState extends State<ActionGrid> {
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
            child: new Card(
              elevation: 5.0,
              child: new Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new Column(
                    children: <Widget>[
                      SizedBox(
                          height: 40.0,
                          child: Text(
                            actionList.data[index].name,
                            textAlign: TextAlign.center,
                          )),
                      new Expanded(
                          child: Image.network(
                            actionList.data[index].iconUrl,
                            fit: BoxFit.scaleDown,
                          )),
                    ],
                  )),
            ),
          );
        });
  }
}
