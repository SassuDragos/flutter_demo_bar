import 'package:flutter_app/src/models/action_model.dart';
import 'package:flutter_app/src/repositories/data_repository.dart';
import 'package:rxdart/rxdart.dart';

class ActionBloc {
  final _dataRepository = DataRepository();
  final _actionsFetcher = PublishSubject<List<Action>>();

  Observable<List<Action>> get allActions => _actionsFetcher.stream;

  fetchAllActions() async {
    List<Action> actionList = await _dataRepository.fetchAllActions();
    _actionsFetcher.sink.add(actionList);
  }

  dispose() {
    _actionsFetcher.close();
  }
}

final actionBloc = ActionBloc();