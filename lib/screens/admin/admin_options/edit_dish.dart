import 'package:flutter/material.dart';
import 'package:tacos_app/screens/admin/admin_options/edit_form.dart';
import 'package:tacos_app/screens/admin/admin_options/edit_image.dart';
import 'package:tacos_app/screens/admin/admin_options/list_product.dart';

class EditDish extends StatefulWidget {
  EditDish({Key key}) : super(key: key);

  @override
  _EditDishState createState() => _EditDishState();
}

final widgets = [
  Expanded(
    child: ListProduct(),
  ),
  Expanded(
    child: EditImage(),
  ),
  Expanded(
    child: EditForm(),
    flex: 2,
  ),
];

class _EditDishState extends State<EditDish> {
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
