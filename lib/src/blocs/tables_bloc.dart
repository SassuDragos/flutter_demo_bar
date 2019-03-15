import 'package:flutter/services.dart';
import 'package:flutter_app/src/repositories/data_repository.dart';
import 'package:rxdart/rxdart.dart';

import 'package:rxdart/subjects.dart';

class TablesBloc {
  final _dataRepository = DataRepository();
  static const platform = MethodChannel('app.channel.shared.tableId');
  final _tableIdFetcher = ReplaySubject<String>(maxSize: 1);

  TablesBloc() {
    _tableIdFetcher.sink.add(null);
    platform.setMethodCallHandler((MethodCall call) {
      if(call.method == "notifyNewTableId") {
        String tableId = call.arguments[0];
        if (!_tableIdFetcher.values.contains(tableId)) {
          _tableIdFetcher.sink.add(tableId);
        }
        return null;
      }
    });
  }

  Observable<String> get tableIdStream => _tableIdFetcher.stream;

  Future<Observable<String>> scanTableId() async {
    var tableId = await platform.invokeMethod("getTableId") as String;
    if (!_tableIdFetcher.values.contains(tableId)) {
      _tableIdFetcher.sink.add(tableId);
    }
    return _tableIdFetcher.stream;
  }

  Future<String> getFakeTableId() {
    return Future.value("12");
  }

  dispose() {
    _tableIdFetcher.close();
  }

  sentTableRequest(String actionName) {
    var tableId = _tableIdFetcher.values.last;
    _dataRepository.sendAction(tableId, actionName);
  }
}

final tablesBloc = TablesBloc();
