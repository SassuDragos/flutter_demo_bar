import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

import 'package:rxdart/subjects.dart';

class TablesBloc {
  static const platform = MethodChannel('app.channel.shared.tableId');
  final _tableIdFetcher = ReplaySubject<String>(maxSize: 1);

  Observable<String> get tableIdStream => _tableIdFetcher.stream;

  Future<Observable<String>> scanTableId() async {
    var tableId = await platform.invokeMethod("getTableId") as String;
//    var tableId = await getFakeTableId();
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
}

final tablesBloc = TablesBloc();
