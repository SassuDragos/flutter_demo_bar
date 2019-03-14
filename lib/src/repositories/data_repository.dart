import 'package:flutter_app/src/models/action_model.dart';
import 'package:flutter_app/src/repositories/actions_api_provider.dart';

class DataRepository {
  final actionsApiProvider = ActionsApiProvider();

  Future<List<Action>> fetchAllActions() => actionsApiProvider.fetchActionList();
}