import 'package:flutter_app/src/models/action_model.dart';
import 'package:http/http.dart' show Client;

class ActionsApiProvider {
  Client client = Client();
//
//  Future<Action> fetchActionList() async {
//    final response = await client.get("https://flutter-bar.api.mocked.io/actions");
//    if (response.statusCode == 200) {
//      print("");
////      return Action.fromJson(json.decode(response.body));
//    }
//  }
}