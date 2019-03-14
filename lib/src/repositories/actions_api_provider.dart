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
}
