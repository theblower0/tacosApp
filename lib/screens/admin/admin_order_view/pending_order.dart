import 'package:flutter/material.dart';
import 'package:tacos_app/screens/admin/admin_order_view/detail_pending_order.dart';
import 'package:tacos_app/screens/admin/admin_order_view/order_list.dart';

class PendingOrder extends StatefulWidget {
  PendingOrder({Key key}) : super(key: key);

  @override
  _PendingOrderState createState() => _PendingOrderState();
}

class _PendingOrderState extends State<PendingOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Expanded(child: OrderList()),
        Expanded(child: DetailPendingOrder())
      ],
    ));
  }
}
