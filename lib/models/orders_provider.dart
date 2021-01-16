import 'package:flutter/cupertino.dart';
import 'package:tacos_app/models/orders_data.dart';

class OrdersProvider with ChangeNotifier {
  var _orders = List<OrdersData>();

  var _index = 0;

  get index {
    return _index;
  }

  get orders {
    return _orders;
  }

  void setIndex(int index) {
    _index = index;
    notifyListeners();
  }

  OrdersData getLocation(int idex) {
    return orders[index];
  }

  void setLocations(List<OrdersData> orders) {
    _orders = orders;
    notifyListeners();
  }

  int locationsLength() {
    return _orders.length;
  }
}
