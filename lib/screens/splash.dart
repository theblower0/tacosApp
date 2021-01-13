import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tacos_app/login/login.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 5);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromRGBO(227, 26, 33, 0.8),
      body: Container(
          color: Color.fromRGBO(227, 26, 33, 1),
          alignment: Alignment(0.0, 0.0),
          child: SvgPicture.asset(
            'assets/images/logo.svg',
            height: 250,
            fit: BoxFit.scaleDown,
          )),
    );
  }
}
