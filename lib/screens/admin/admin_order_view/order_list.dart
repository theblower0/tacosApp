import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tacos_app/models/orders_data.dart';
import 'package:tacos_app/models/orders_detail.dart';
import 'package:tacos_app/models/orders_provider.dart';
import 'package:tacos_app/screens/admin/admin_order_view/location_remote_data_source.dart';
import 'package:tacos_app/services/api.dart';

class OrderList extends StatefulWidget {
  OrderList({Key key}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  List<OrdersData> _orders;
  bool _loading;

  @override
  void initState() {
    print('en el initState');
    super.initState();

    LocationRemoteDataSource.getLocations().then((orders) {
      setState(() {
        context.read<OrdersProvider>().setLocations(orders);
        _orders = context.read<OrdersProvider>().orders;
        _loading = false;
        print('en el show');
        print(_orders.length);
        print(_loading.toString());
      });
    });
  }

  var nombreCliente;
  var emailCliente;
  var _id;
  var token;
  List<Detail> detail;
  Detail _detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: null == _orders ? 0 : _orders.length,
            itemBuilder: (context, index) {
              OrdersData orders = _orders[index];
              detail = orders.detail;

              return Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        orders.nombreCliente,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            children: [
                              Text(
                                'Fecha: ${orders.createdAt}',
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        print('Seleccionaste' + orders.id.toString());
                        context.read<OrdersProvider>().setIndex(index);
                      },
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.start,
                      children: [
                        FlatButton(
                          color: Colors.red,
                          onPressed: () {
                            _id = orders.id;
                            _detail = detail[index];
                            _saveOrder();
                          },
                          child: Text('Entregar',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  _saveOrder() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.get('token');
    var dataProduct = {
      'id': _detail.id,
      'id_producto': _detail.idProducto,
      'nombre_producto': _detail.nombreProducto,
      'cantidad': _detail.cantidad,
      'precio': _detail.precio,
      'subtotal': _detail.subtotal,
      'api_token': token
    };
    var deleteOrder = {'id': _id, 'api_token': token};
    final response = await Network().addOrderBackup(dataProduct);
    final res = await Network().deleteOrder(deleteOrder);

    if (response.res) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text(response.message)));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('No se pudo')));
    }
  }
}
