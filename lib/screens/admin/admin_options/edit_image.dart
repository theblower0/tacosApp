import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tacos_app/models/update_product.dart';

class EditImage extends StatefulWidget {
  EditImage({Key key}) : super(key: key);

  @override
  _EditImageState createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {
  File _image;
  final picker = ImagePicker();
  var data;

  Future choiceImage(UpdateProduct updateProduct) async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        sendInfo(updateProduct);
      });
    }
  }

  sendInfo(UpdateProduct updateProduct) {
    if (_image == null) return;
    String base64Image = base64Encode(_image.readAsBytesSync());
    String fileName = _image.path.split('/').last;

    updateProduct.image = base64Image;
    updateProduct.nameImage = fileName;
    print(updateProduct.nameImage);
  }

  @override
  Widget build(BuildContext context) {
    //final dataImageUp = Provider.of<DataImageUp>(context);
    final updateProduct = Provider.of<UpdateProduct>(context);
    Uint8List bytes = base64Decode(updateProduct.image);

    print('es el image: ' + updateProduct.image);

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
                            choiceImage(updateProduct);
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
                      backgroundImage: updateProduct.image == ''
                          ? AssetImage('assets/images/default_image.png')
                          : MemoryImage(bytes),
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
                            choiceImage(updateProduct);
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
