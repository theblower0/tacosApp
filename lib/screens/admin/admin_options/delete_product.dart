import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tacos_app/models/delete_product_pro.dart';
import 'package:tacos_app/services/api.dart';

class DeleteProduct extends StatefulWidget {
  DeleteProduct({Key key}) : super(key: key);

  @override
  _DeleteProductState createState() => _DeleteProductState();
}

var idProducto;
var nombre;
var precio;
var image;
var nameImage;
var isPressed = false;
var token;

class _DeleteProductState extends State<DeleteProduct> {
  @override
  Widget build(BuildContext context) {
    final deleteProduct = Provider.of<DeleteProductProvider>(context);
    MediaQueryData queryData = MediaQuery.of(context);
    idProducto = deleteProduct.idProduct;
    nombre = deleteProduct.nombreProducto;
    precio = deleteProduct.precio;
    image = deleteProduct.image;
    nameImage = deleteProduct.nameImage;
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          'Elimina producto',
          style: Theme.of(context).textTheme.headline2,
        ),
        SizedBox(
          height: 20,
        ),
        //padding: EdgeInsets.symmetric(horizontal: 90, vertical: 10),
        Container(
          width: queryData.size.width,
          height: queryData.size.height * 0.30,
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue[900], width: 10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID: $idProducto',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 20),
              ),
              Text(
                'Nombre: $nombre',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 20),
              ),
              Text(
                'Precio: $precio',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 20),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          onPressed: () {
            isPressed = true;
            _showAlert();
          },
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Text(
            'Eliminar',
            style: Theme.of(context).textTheme.button.copyWith(fontSize: 20),
          ),
        ),
      ],
    );
  }

  _showAlert() {
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: Text('¿Eliminar producto?'),
        content: Text('Estás a punto de eliminar un producto'),
        actions: [
          TextButton(
              child: Text('Aceptar',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.red,
                      )),
              onPressed: () {
                _deleteProduct();
                Navigator.of(context).pop();
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('Producto eliminado')));
              }),
          TextButton(
              child: Text('Cancelar',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.black,
                      )),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }

  _deleteProduct() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.get('token');
    var dataProduct = {
      'id_producto': idProducto,
      'nombre_producto': nombre,
      'precio': precio,
      'image': image,
      'name_image': nameImage,
      'api_token': token
    };
    final response = await Network().deleteProduct(dataProduct);
    if (response.res) {
      setState(() {
        nombre = ' ';
        precio = ' ';
        idProducto = ' ';
      });
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text(response.message)));
    } else {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text(response.message)));
    }
  }
}
