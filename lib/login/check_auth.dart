import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tacos_app/login/login.dart';
import 'package:tacos_app/screens/admin/admin_dashboard.dart';
import 'package:tacos_app/shared/loading.dart';

class CheckAuth extends StatefulWidget {
  CheckAuth({Key key}) : super(key: key);

  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool loading = false;
  bool isAuth = false;
  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      setState(() {
        loading = true;
        isAuth = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;
    if (isAuth) {
      widget = AdminDashboard();
    } else {
      loading = false;
      widget = Login();
    }
    return loading ? Loading() : Scaffold(body: widget);
  }
}
