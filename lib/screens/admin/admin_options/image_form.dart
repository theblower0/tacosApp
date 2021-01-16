import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tacos_app/models/data_image.dart';
import 'package:tacos_app/models/product.dart';
import 'package:tacos_app/services/api.dart';
import 'package:tacos_app/shared/constants.dart';

class ImageForm extends StatefulWidget {
  ImageForm({Key key}) : super(key: key);

  @override
  _ImageFormState createState() => _ImageFormState();
}

ProductModel product;

var idProducto;
var nombre;
var precio;
var image;
var nameImage;
var token;

class _ImageFormState extends State<ImageForm> {
  GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final dataImage = Provider.of<DataImage>(context);
    MediaQueryData queryData = MediaQuery.of(context);

    return Scaffold(
      body: ResponsiveWrapper(
        child: Container(
          // color: Colors.amber,
          height: queryData.size.height * 1.3,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: queryData.size.height / 18),
                  child: Text(
                    'Añade un nuevo producto',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Container(
                  child: Form(
                      key: _formKey1,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: TextFormField(
                              decoration: textInputDecoration.copyWith(
                                labelText: 'ID Producto',
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: Colors.black54),
                                prefixIcon: Icon(
                                  Icons.note_add,
                                  size: 35,
                                  //color: Colors.blue[900],
                                ),
                              ),
                              validator: (val) {
                                idProducto = val;
                                return val.isEmpty ? 'Ingresa un ID' : null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                              labelText: 'Nombre',
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: Colors.black54),
                              prefixIcon: Icon(
                                Icons.edit,
                                size: 35,
                                //color: Colors.blue[900],
                              ),
                            ),
                            validator: (val) {
                              nombre = val;
                              return val.isEmpty
                                  ? 'Ingresa un nombre de producto'
                                  : null;
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: textInputDecoration.copyWith(
                              labelText: 'Precio',
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: Colors.black54),
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
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          RaisedButton(
                            onPressed: () {
                              if (_formKey1.currentState.validate()) {
                                image = dataImage.image;
                                nameImage = dataImage.nameImage;
                                _uploadProduct();
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

  _uploadProduct() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.get('token');
    var dataProduct = {
      'id_producto': idProducto,
      'nombre_producto': nombre,
      'precio': precio,
      'image': image,
      'name_image': nameImage,
      'api_token': token
    };

    final response = await Network().createProduct(dataProduct);
    if (response.res) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text(response.message)));
    } else {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text(response.message)));
    }
  }
}
