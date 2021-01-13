import 'package:flutter/material.dart';
import 'package:tacos_app/screens/admin/admin_options/edit_image.dart';
import 'package:tacos_app/screens/admin/admin_options/list_product.dart';

class DeleteDish extends StatefulWidget {
  DeleteDish({Key key}) : super(key: key);

  @override
  _DeleteDishState createState() => _DeleteDishState();
}

final widgets = [
  Expanded(
    child: ListProduct(),
  ),
  Expanded(
    child: EditImage(),
  )
];

class _DeleteDishState extends State<DeleteDish> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if ((constraints.maxWidth < 600)) {
          return Column(children: widgets);
        } else {
          return Row(children: widgets);
        }
      }),
    );
  }
}
