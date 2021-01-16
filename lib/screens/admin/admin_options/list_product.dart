import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tacos_app/models/update_product.dart';

class ListProduct extends StatefulWidget {
  ListProduct({Key key}) : super(key: key);

  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  List products = [];

  bool isLoading = false;
  static String _url = "https://taquemaster.000webhostapp.com";
  @override
  void initState() {
    print('en el initState');
    super.initState();
    this.viewProduct();
  }

  viewProduct() async {
    try {
      final response = await http.get('$_url/menu/viewProducts');
      if (response.statusCode == 200) {
        var product = jsonDecode(response.body);

        setState(() {
          products = product;
        });
        //return poductModelFromJson(producModel);
      } else {
        setState(() {
          products = [];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return getCard(products[index]);
        });
  }

  Widget getCard(index) {
    final updateProduct = Provider.of<UpdateProduct>(context);

    var image = index['image'].toString().replaceAll(r'\n|\s', '+');
    var name = index['nombre_producto'].toString();
    var idProducto = index['id_producto'].toString();
    var precio = index['precio'].toString();

    // Image image = Image.memory(
    //     base64Decode(index['image'].toString().replaceAll(r'\n|\s', '+')));
    Uint8List bytes = base64Decode(image);
    return Card(
      child: ListTile(
        trailing: Icon(Icons.arrow_right),
        leading: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60 / 2),
                image: DecorationImage(
                    image: MemoryImage(bytes), fit: BoxFit.cover))),
        title: Text(
          name,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: [
                Text(
                  'ID: ' + idProducto + '\nPrecio: ' + precio,
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          updateProduct.idProduct = index['id_producto'];
          updateProduct.nombreProducto = index['nombre_producto'];
          updateProduct.precio = index['precio'].toString();
          updateProduct.image = index['image'];
          updateProduct.nameImage = index['name_image'];
          // Scaffold.of(context).showSnackBar(SnackBar(
          //     content: Text(index['id_producto'] +
          //         index['nombre_producto'] +
          //         index['precio'].toString())));
        },
      ),
    );
  }
}
