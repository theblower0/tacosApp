import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tacos_app/models/orders_data.dart';
import 'package:tacos_app/models/orders_detail.dart';
import 'package:tacos_app/models/orders_provider.dart';

class DetailPendingOrder extends StatefulWidget {
  DetailPendingOrder({Key key}) : super(key: key);

  @override
  _DetailPendingOrderState createState() => _DetailPendingOrderState();
}

class _DetailPendingOrderState extends State<DetailPendingOrder> {
  @override
  Widget build(BuildContext context) {
    int _index = context.watch<OrdersProvider>().index;
    OrdersData _orders;
    List<Detail> _detail;
    try {
      _orders = context.watch<OrdersProvider>().getLocation(_index);
      if (_orders != null) {
        _detail = _orders.detail;
      } else {
        _detail = [];
      }
    } catch (e) {
      _detail = [];
      print('Error de los detalels de orden: $e');
    }

    return Scaffold(
        body: _detail != null
            ? ListView.builder(
                itemCount: _detail.length,
                itemBuilder: (context, index) {
                  //print('index: ' + index.toString());
                  Detail detail = _detail[index];
                  return Card(
                    child: ListTile(
                      title: Text(
                        detail.nombreProducto,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            children: [
                              Text(
                                'Ordenes: ${detail.cantidad}' +
                                    '\nFecha: ${detail.createdAt}',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : Container(
                child: Text('Nada que mostrar'),
              ));
  }

  // _showAlert() {
  //   showDialog(
  //     context: context,
  //     builder: (_) => new AlertDialog(
  //       title: Text('¿Eliminar producto?'),
  //       content: Text('Esás a punto de eliminar un producto'),
  //       actions: [
  //         TextButton(
  //             child: Text('Aceptar',
  //                 style: Theme.of(context).textTheme.bodyText1.copyWith(
  //                       color: Colors.red,
  //                     )),
  //             onPressed: () {
  //               // _deleteProduct();
  //               Navigator.of(context).pop();
  //             }),
  //         TextButton(
  //             child: Text('Cancelar',
  //                 style: Theme.of(context).textTheme.bodyText1.copyWith(
  //                       color: Colors.black,
  //                     )),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             }),
  //       ],
  //     ),
  //   );
  // }

  // _deleteProduct() async {
  //   var dataProduct = {
  //     'id_producto': idProducto,
  //     'nombre_producto': nombre,
  //     'precio': precio,
  //     'image': image,
  //     'name_image': nameImage,
  //     'api_token': 'cX0ywLQ3l3MCyVdGSrcOp9o0TK4Lq12u'
  //   };
  //   final response = await Network().deleteProduct(dataProduct);
  //   if (response.res) {
  //     setState(() {
  //       nombre = ' ';
  //       precio = ' ';
  //       idProducto = ' ';
  //     });
  //     Scaffold.of(context)
  //         .showSnackBar(SnackBar(content: Text(response.message)));
  //   } else {
  //     Scaffold.of(context)
  //         .showSnackBar(SnackBar(content: Text(response.message)));
  //   }
  // }
}
