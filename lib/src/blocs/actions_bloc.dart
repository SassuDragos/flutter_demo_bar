import 'dart:async';

import 'package:flutter_app/src/blocs/tables_bloc.dart';
import 'package:flutter_app/src/models/action_model.dart';
import 'package:flutter_app/src/repositories/data_repository.dart';
import 'package:rxdart/rxdart.dart';

class ActionBloc {
  final _dataRepository = DataRepository();
  final _actionsFetcher = PublishSubject<List<Action>>();

  Observable<List<Action>> get allActions => _actionsFetcher.stream;
  StreamSubscription<String> _tableSubscription =
  new Observable<String>(tablesBloc.tableIdStream)
      .listen((tableId) => actionBloc.handleTableId(tableId));

  void handleTableId(String newTableId) {
    if (newTableId != null) {
      actionBloc.fetchAllActions();
    }
  }

  fetchAllActions() async {
    List<Action> actionList = await _dataRepository.getAllActions();
    _actionsFetcher.sink.add(actionList);
  }

  dispose() {
    _tableSubscription.cancel();
    _actionsFetcher.close();
  }
}

final actionBloc = ActionBloc();