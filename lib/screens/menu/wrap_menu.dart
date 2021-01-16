import 'package:flutter/material.dart';
import 'package:tacos_app/screens/menu/detail_menu.dart';
import 'package:tacos_app/screens/menu/menu.dart';

class WrappMenu extends StatefulWidget {
  WrappMenu({Key key}) : super(key: key);

  @override
  _WrappMenuState createState() => _WrappMenuState();
}

class _WrappMenuState extends State<WrappMenu> {
  final widgets = [
    Expanded(
      child: Menu(),
    ),
    Expanded(
      child: DetailMenu(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(
            'Menu',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white),
          )),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if ((constraints.maxWidth < 600)) {
          return Column(children: widgets);
        } else {
          return Row(children: widgets);
        }
      }),
    );
  }
}
