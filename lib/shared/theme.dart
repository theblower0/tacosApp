import 'package:flutter/material.dart';

final appTheme = ThemeData(
  fontFamily: 'Nunito',
  textTheme: TextTheme(
      headline2: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.w600,
      ),
      headline1: TextStyle(
        fontSize: 50.0,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(fontSize: 25.0, fontWeight: FontWeight.normal),
      headline4: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
      button: TextStyle(
          fontSize: 30.0,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.normal,
          color: Colors.white),
      headline3: TextStyle(
          fontSize: 30.0,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.normal)),
  scaffoldBackgroundColor: Colors.white,
  buttonTheme: ButtonThemeData(
    buttonColor: Color.fromRGBO(227, 26, 33, 1),
    disabledColor: Color.fromRGBO(227, 26, 33, 1),
    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
  ),
);
