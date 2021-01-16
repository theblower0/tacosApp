import 'package:flutter/material.dart';
import 'package:tacos_app/screens/admin/admin_options/image_form.dart';
import 'package:tacos_app/screens/admin/admin_options/upload_image.dart';

class AddDish extends StatefulWidget {
  AddDish({Key key}) : super(key: key);

  @override
  _AddDishState createState() => _AddDishState();
}

class _AddDishState extends State<AddDish> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [Expanded(child: UploadImage()), Expanded(child: ImageForm())],
    ));
  }
}
