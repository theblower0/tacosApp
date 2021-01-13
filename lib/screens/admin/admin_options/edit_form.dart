import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:tacos_app/models/data_image.dart';
import 'package:tacos_app/models/image_upate.dart';
import 'package:tacos_app/models/update_product.dart';

import 'package:tacos_app/services/api.dart';
import 'package:tacos_app/shared/constants.dart';

class EditForm extends StatefulWidget {
  EditForm({Key key}) : super(key: key);

  @override
  _EditFormState createState() => _EditFormState();
}

final _formKey = GlobalKey<FormState>();
var idProducto;
var nombre;
var precio;
var image;
var nameImage;
var isPressed = false;
TextEditingController controller;
var textController = new TextEditingController();
var textController2 = new TextEditingController();

class _EditFormState extends State<EditForm> {
  @override
  void initState() {
    super.initState();
  }

  clearTextInput() {
    textController.clear();
    textController2.clear();
  }

  @override
  Widget build(BuildContext context) {
    final updateProduct = Provider.of<UpdateProduct>(context);

    MediaQueryData queryData = MediaQuery.of(context);

    return Scaffold(
      body: ResponsiveWrapper(
        child: Container(
          height: queryData.size.height * 1.3,
          width: double.infinity,
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: queryData.size.height / 15),
                  child: Text(
                    'Edita un producto',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: queryData.size.width * 0.1),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: TextFormField(
                              //enabled: false,
                              decoration: textInputDecoration.copyWith(
                                enabled: false,
                                labelText: isPressed
                                    ? 'ID: '
                                    : 'ID: ${updateProduct.idProduct}',
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .copyWith(color: Colors.black54),
                                prefixIcon: Icon(
                                  Icons.note_add,
                                  size: 35,
                                  //color: Colors.blue[900],
                                ),
                              ),
                              validator: (value) {},
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            autofocus: true,
                            decoration: textInputDecoration.copyWith(
                              labelText: 'Nombre',
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  .copyWith(color: Colors.black),
                              // hintText:
                              //     isPressed ? '' : updateProduct.nombreProducto,
                              // hintStyle: Theme.of(context).textTheme.headline3,
                              prefixIcon: Icon(
                                Icons.edit,
                                size: 35,
                                //color: Colors.blue[900],
                              ),
                            ),
                            validator: (val) {
                              nombre = val;
                              return val.isEmpty ? 'Ingresa el nombre' : null;
                            },
                            controller: textController,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: textInputDecoration.copyWith(
                              // hintText: isPressed ? '' : updateProduct.precio,
                              // hintStyle: Theme.of(context).textTheme.headline3,
                              labelText: 'Precio',
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  .copyWith(
                                    color: Colors.black,
                                  ),
                              prefixIcon: Icon(
                                Icons.attach_money,
                                size: 35,
                                //color: Colors.blue[900],
                              ),
                            ),
                            validator: (val) {
                              precio = val;
                              return val.isEmpty ? 'Ingresa el precio' : null;
                            },
                            controller: textController2,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                clearTextInput();
                                isPressed = true;
                                idProducto = updateProduct.idProduct;
                                image = updateProduct.image;
                                nameImage = updateProduct.nameImage;
                                _updateProduct();
                              }
                            },
                            child: Text(
                              'Registrar',
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _updateProduct() async {
    var dataProduct = {
      'id_producto': idProducto,
      'nombre_producto': nombre,
      'precio': precio,
      'image': image,
      'name_image': nameImage,
      'api_token': 'cX0ywLQ3l3MCyVdGSrcOp9o0TK4Lq12u'
    };

    final response = await Network().updateProduct(dataProduct);
    if (response.res) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text(response.message)));
    } else {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text(response.message)));
    }
  }
}
