import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tacos_app/models/update_product.dart';

class DeleteProduct extends StatefulWidget {
  DeleteProduct({Key key}) : super(key: key);

  @override
  _DeleteProductState createState() => _DeleteProductState();
}

class _DeleteProductState extends State<DeleteProduct> {
  @override
  Widget build(BuildContext context) {
    final updateProduct = Provider.of<UpdateProduct>(context);
    return Container(
      child: Container(
        child: Center(
            child: Column(
          children: [
            Text('Elimina producto'),
            Text('Nombre: ${updateProduct.nombreProducto}')
          ],
        )),
      ),
    );
  }
}
