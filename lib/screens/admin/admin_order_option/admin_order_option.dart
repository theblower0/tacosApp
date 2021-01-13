import 'package:flutter/material.dart';

class OrderOption extends StatefulWidget {
  OrderOption({Key key}) : super(key: key);

  @override
  _OrderOptionState createState() => _OrderOptionState();
}

class _OrderOptionState extends State<OrderOption> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(227, 26, 33, 1),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20))),
            title: Text('Ordenes',
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: Colors.white)),
            bottom: TabBar(
              labelStyle: Theme.of(context).textTheme.headline4,
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 8.0, color: Colors.white),
                  insets: EdgeInsets.symmetric(horizontal: 40.0)),
              tabs: [
                Tab(
                  text: 'Cancelar',
                ),
                Tab(text: 'Historial'),
              ],
            ),
          ),
        ));
  }
}
