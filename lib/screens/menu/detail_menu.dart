import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tacos_app/models/menu_checkout.dart';
import 'package:tacos_app/services/api.dart';

class DetailMenu extends StatefulWidget {
  DetailMenu({Key key}) : super(key: key);

  @override
  _DetailMenuState createState() => _DetailMenuState();
}

var cantidad;
var name;
var idProducto;
var precio;
var nombreCliente;
//var _id;
var subtotal;

class _DetailMenuState extends State<DetailMenu> {
  @override
  Widget build(BuildContext context) {
    final menuCheck = Provider.of<MenuCheck>(context);
    MediaQueryData queryData = MediaQuery.of(context);
    //var image = index['image'].toString().replaceAll(r'\n|\s', '+');

    // var precio = index['precio'].toString();

    Uint8List bytes = base64Decode(menuCheck.image);
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          menuCheck.nombreProducto,
          style: Theme.of(context).textTheme.headline2,
        ),
        SizedBox(
          height: 20,
        ),
        Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(120 / 2),
                image: DecorationImage(
                    image: bytes.isEmpty
                        ? AssetImage('assets/images/default_image.png')
                        : MemoryImage(bytes),
                    fit: BoxFit.cover))),
        //padding: EdgeInsets.symmetric(horizontal: 90, vertical: 10),
        Container(
          width: queryData.size.width,
          height: queryData.size.height / 6,
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Precio: ',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 20),
              ),
              Text(
                '\$ ' + menuCheck.precio,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 20),
              ),
            ],
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () {
                menuCheck.ordenes--;
                menuCheck.ordenes < 0
                    ? menuCheck.ordenes = 0
                    : menuCheck.ordenes = menuCheck.ordenes;
              },
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Icon(
                Icons.remove,
                color: Colors.white,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                menuCheck.ordenes.toString(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  menuCheck.ordenes++;
                });
              },
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        RaisedButton(
          onPressed: () {
            name = menuCheck.nombreProducto;
            idProducto = menuCheck.idProduct;
            cantidad = menuCheck.ordenes;
            precio = menuCheck.precio;

            _showDialog();
          },
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            'Ordenar',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }

  _saveCart(nombreCliente) async {
    int _subtotal = int.parse(precio) * cantidad;
    subtotal = _subtotal.toString();
    print(subtotal.toString());
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.get('token');
    var sendCart;

    var nombre = {'nombre_cliente': nombreCliente, 'api_token': token};
    var response = await Network().createOrder(nombre);

    var idOrder;
    if (response.res) {
      //tiene que mandar el nombre para buscarlo
      idOrder = await Network().getID();
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Total: $subtotal')));
    } else {
      print('no se registró la orden');
    }

    var bodyID = json.decode(idOrder.body);
    var id = bodyID['id'];
    sendCart = {
      'orders_id': id,
      'id_producto': idProducto,
      'nombre_producto': name,
      'precio': precio,
      'subtotal': subtotal,
      'api_token': token,
      'cantidad': cantidad
    };
    var resDetail;
    if (idOrder != null) {
      resDetail = await Network().addDetailOrder(sendCart);
    } else {
      print('no se puso añadir los detalles de la orden');
    }
    var bodyResponse = json.decode(resDetail.body);
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Hecho')));
  }

  final myController = TextEditingController();
  _showDialog() async {
    await showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                controller: myController,
                autofocus: true,
                decoration: new InputDecoration(
                  labelText: 'Nombre',
                  labelStyle: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 25),
                ),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              color: Colors.grey,
              child: Text(
                'Cancelar',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 25, color: Colors.white),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              color: Colors.red,
              child: Text(
                'Aceptar',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 25, color: Colors.white),
              ),
              onPressed: () {
                setState(() {
                  nombreCliente = myController.text;
                  _saveCart(nombreCliente);
                });
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
