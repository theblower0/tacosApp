import 'package:flutter/material.dart';
import 'package:tacos_app/screens/admin/admin_order_view/order_completed.dart';
import 'package:tacos_app/screens/admin/admin_order_view/pending_order.dart';

class OrderView extends StatefulWidget {
  OrderView({Key key}) : super(key: key);

  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(227, 26, 33, 1),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20))),
            title: Text('Pedidos',
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: Colors.white)),
            bottom: TabBar(
              labelStyle: Theme.of(context).textTheme.headline4,
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 8.0, color: Colors.white),
                  insets: EdgeInsets.symmetric(horizontal: 40.0)),
              tabs: [
                Tab(text: 'Pendientes'),
                Tab(text: 'Realizados'),
              ],
            ),
          ),
          body: TabBarView(children: [PendingOrder(), OrderCompleted()]),
        ));
  }
}
