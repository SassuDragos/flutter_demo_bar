import 'dart:convert';

import 'package:flutter_app/src/models/action_model.dart';
import 'package:http/http.dart' show Client;

class ActionsApiProvider {
  Client client = Client();

  Future<List<Action>> fetchActionList() async {
    final response =
        await client.get("https://flutter-bar.api.mocked.io/actions");
    if (response.statusCode == 200) {
      List<Action> actionList = (jsonDecode(response.body) as List)
          .map((i) => Action.fromJson(i))
          .toList();

      return actionList;
    } else {
      throw Exception('Failed to load action list.');
    }
  }

  // ignore: missing_return
  Future<bool> sendAction(String tableId, String name) async {
    final response = await client.post("https://fcm.googleapis.com/fcm/send",
        headers: {"Content-Type": "application/json", "Authorization": "key=AIzaSyDjmUcvCWHanjWq09EW514Z5NqHqYDREI8"},
        body: "{ \"to\": \"/topics/general\", \"notification\": { \"body\": \""+tableId+"%"+name+"\" } }"
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      //final body = response.body;
      return false;
    }
  }

}
