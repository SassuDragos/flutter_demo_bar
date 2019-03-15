import 'package:flutter/services.dart';

class OrdersBloc {
  static const platform = MethodChannel('app.channel.shared.tableId');

  Future<String> getTableId() async {
    var tableId = await platform.invokeMethod("getTableId");
    return (tableId as String);
  }
}


final ordersBloc = OrdersBloc();
