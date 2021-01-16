import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderCompleted extends StatefulWidget {
  OrderCompleted({Key key}) : super(key: key);

  @override
  _OrderCompletedState createState() => _OrderCompletedState();
}

class _OrderCompletedState extends State<OrderCompleted> {
  List details = [];

  bool isLoading = false;
  static String _url =
      "https://taquemaster.000webhostapp.com/orderBackup/viewOrdersBackup";
  @override
  void initState() {
    print('en el initState');
    super.initState();
    this.viewDetails();
  }

  viewDetails() async {
    try {
      final response = await http.get(_url);
      if (response.statusCode == 200) {
        var detail = jsonDecode(response.body);

        setState(() {
          details = detail;
        });
        //return poductModelFromJson(producModel);
      } else {
        setState(() {
          details = [];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: details.length,
        itemBuilder: (context, index) {
          return getCard(details[index]);
        });
  }

  Widget getCard(index) {
    var cantidad = index['cantidad'].toString();
    var nombreProducto = index['nombre_producto'].toString();
    var idProducto = index['id_producto'].toString();
    var precio = index['precio'].toString();
    var subtotal = index['subtotal'].toString();
    return Card(
      child: ListTile(
        leading: Icon(Icons.done, color: Colors.green, size: 40),
        title: Text(
          'Nombre: $nombreProducto',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: [
                Text(
                  'ID: $idProducto' +
                      '\nPrecio: $precio' +
                      '\nCantidad: $cantidad' +
                      '\nSubtotal: $subtotal',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
