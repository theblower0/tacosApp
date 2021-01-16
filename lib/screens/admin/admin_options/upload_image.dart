import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tacos_app/models/data_image.dart';
import 'package:tacos_app/models/product.dart';

class UploadImage extends StatefulWidget {
  UploadImage({Key key}) : super(key: key);

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File _image;
  final picker = ImagePicker();
  var data;
  ProductModel productModel;
  Future choiceImage(DataImage dataImage) async {
    var pickedImage = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 200,
      maxWidth: 200,
    );
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);

        sendInfo(dataImage);
      });
    }
  }

  sendInfo(DataImage dataImage) {
    if (_image == null) return;
    String base64Image = base64Encode(_image.readAsBytesSync());
    String fileName = _image.path.split('/').last;

    dataImage.image = base64Image;
    dataImage.nameImage = fileName;
    print(dataImage.nameImage);
  }

  @override
  Widget build(BuildContext context) {
    final dataImage = Provider.of<DataImage>(context);
    MediaQueryData queryData = MediaQuery.of(context);
    return Container(
      height: queryData.size.height,
      width: double.infinity,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(top: 30),
      child: Center(
        child: Column(
          children: [
            Container(
              child: _image == null
                  ? CircleAvatar(
                      child: Container(
                        alignment: Alignment(1.3, 1.0),
                        child: MaterialButton(
                          elevation: 10,
                          onPressed: () {
                            choiceImage(dataImage);
                          },
                          color: Color.fromRGBO(23, 44, 73, 1),
                          textColor: Colors.white,
                          child: Icon(
                            Icons.camera_alt,
                            size: 24,
                          ),
                          padding: EdgeInsets.all(18),
                          shape: CircleBorder(),
                        ),
                      ),
                      backgroundColor: Colors.white,
                      backgroundImage:
                          AssetImage('assets/images/default_image.png'),
                      radius: 100.0,
                    )
                  : CircleAvatar(
                      backgroundImage: new FileImage(_image),
                      radius: 100.0,
                      child: Container(
                        alignment: Alignment(1.3, 1.0),
                        child: MaterialButton(
                          elevation: 10,
                          onPressed: () {
                            choiceImage(dataImage);
                          },
                          color: Color.fromRGBO(23, 44, 73, 1),
                          textColor: Colors.white,
                          child: Icon(
                            Icons.camera_alt,
                            size: 24,
                          ),
                          padding: EdgeInsets.all(18),
                          shape: CircleBorder(),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
