import 'package:flutter/material.dart';
import 'package:tacos_app/screens/admin/admin_options/delete_product.dart';
import 'package:tacos_app/screens/admin/admin_options/list_delete.dart';

class DeleteDish extends StatefulWidget {
  DeleteDish({Key key}) : super(key: key);

  @override
  _DeleteDishState createState() => _DeleteDishState();
}

class _DeleteDishState extends State<DeleteDish> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Expanded(child: ListDelete()),
        Expanded(child: DeleteProduct())
      ],
    ));
  }
}
