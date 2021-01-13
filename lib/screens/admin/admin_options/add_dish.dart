import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:tacos_app/screens/admin/admin_options/image_form.dart';
import 'package:tacos_app/screens/admin/admin_options/upload_image.dart';

class AddDish extends StatefulWidget {
  AddDish({Key key}) : super(key: key);

  @override
  _AddDishState createState() => _AddDishState();
}

class _AddDishState extends State<AddDish> {
  final widgets = [
    Expanded(
      child: UploadImage(),
    ),
    Expanded(
      child: ImageForm(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if ((constraints.maxWidth < 600)) {
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
          return SingleChildScrollView(
              child: Column(children: <Widget>[
            Container(
              height: 300,
              child: UploadImage(),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.red),
              height: 6,
              width: MediaQuery.of(context).size.width * 0.8,
            ),
            Container(
              height: 700,
              child: ImageForm(),
            ),
          ]));
        } else {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeRight,
          ]);
          return Row(children: widgets);
        }
      }),
    );
  }
}
