import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:tacos_app/login/check_auth.dart';
import 'package:tacos_app/login/login.dart';
import 'package:tacos_app/shared/CustomPageRoute.dart';

class Wrapper extends StatefulWidget {
  Wrapper({Key key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return ResponsiveWrapper(
      child: Container(
        height: queryData.size.height,
        width: queryData.size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/tacos_bg.jpg'),
                colorFilter: ColorFilter.mode(
                    Color.fromRGBO(23, 44, 73, 0.6), BlendMode.darken),
                fit: BoxFit.cover)),
        child: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: queryData.size.height / 5,
                    bottom: queryData.size.height / 40),
                child: Text(
                  '¡Bienvenido!',
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(color: Colors.white, fontSize: 80.0),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: queryData.size.height / 20),
                child: Text(
                  'Selecciona la opción que deses',
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(color: Colors.white),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CustomPageRoute(widget: CheckAuth()),
                  );
                },
                child: Text(
                  'Iniciar Sesión',
                  style: Theme.of(context).textTheme.button,
                ),
              ),
              SizedBox(height: 40),
              RaisedButton(
                onPressed: () {},
                color: Colors.white,
                child: Text(
                  'Menú',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
      // maxWidth: 1200,
      // minWidth: 480,
      // defaultScaleFactor: 1,
      // defaultScale: true,
      // breakpoints: [
      //   ResponsiveBreakpoint.resize(480, name: MOBILE),
      //   ResponsiveBreakpoint.autoScale(800, name: TABLET),
      // ],
    );
  }
}
