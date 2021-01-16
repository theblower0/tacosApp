import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tacos_app/login/wrapper.dart';
import 'package:tacos_app/screens/admin/admin_dashboard.dart';
import 'package:tacos_app/shared/CustomPageRoute.dart';
import 'package:tacos_app/shared/constants.dart';
import 'package:tacos_app/services/api.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var userName;
  var password;
  var apiToken;

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
      body: ResponsiveWrapper(
        child: Container(
          height: queryData.size.height,
          width: queryData.size.width,
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: queryData.size.height / 25),
                  child: SvgPicture.asset(
                    'assets/images/login_il.svg',
                    height: queryData.size.height / 3,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'Inicia Sesión',
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(color: Colors.black, fontSize: 40),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: queryData.size.width * 0.2),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: TextFormField(
                              decoration: textInputDecoration.copyWith(
                                labelText: 'Usuario',
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: Colors.black54),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  size: 35,
                                  //color: Colors.blue[900],
                                ),
                              ),
                              validator: (val) {
                                userName = val;
                                return val.isEmpty
                                    ? 'Ingresa un usuario'
                                    : null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration: textInputDecoration.copyWith(
                              labelText: 'Contraseña',
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    color: Colors.black54,
                                  ),
                              prefixIcon: Icon(
                                Icons.lock,
                                size: 35,
                                //color: Colors.blue[900],
                              ),
                            ),
                            validator: (val) {
                              password = val;
                              return val.isEmpty
                                  ? 'Ingresa la contraseña'
                                  : null;
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                print(userName);
                                print(password);
                                _login();
                              }
                            },
                            child: Text(
                              'Iniciar',
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

  void _login() async {
    setState(() {
      loading = true;
    });
    var data = {'name': userName, 'password': password};

    var res = await Network().authData(data, '/users/login');
    print(res.body);
    var body = json.decode(res.body);
    if (body['res']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('name', jsonEncode(body['name']));

      Navigator.push(
        context,
        CustomPageRoute(widget: AdminDashboard()),
      );
    } else {
      validateAttempt(body['message']);
      //_showMsg(body['message']);
    }
    setState(() {
      loading = false;
    });
  }

  int i = 3;
  attempt(msg) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text(msg + '\nQuedan $i intentos')));
    i--;
    if (i < 0) {
      Navigator.push(context, CustomPageRoute(widget: Wrapper()));
    }
  }

  validateAttempt(msg) {
    Listener(
      onPointerDown: attempt(msg),
    );
  }
}
