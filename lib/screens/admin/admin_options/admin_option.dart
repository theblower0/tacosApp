import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tacos_app/login/wrapper.dart';
import 'package:tacos_app/screens/admin/admin_options/add_dish.dart';
import 'package:tacos_app/screens/admin/admin_options/delete_dish.dart';
import 'package:tacos_app/screens/admin/admin_options/edit_dish.dart';

class AdminOption extends StatefulWidget {
  AdminOption({Key key}) : super(key: key);

  @override
  _AdminOptionState createState() => _AdminOptionState();
}

class _AdminOptionState extends State<AdminOption> {
  //final List<String> optionsBar = ['Agregar'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              FlatButton.icon(
                onPressed: () {
                  _logout();
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 30,
                ),
                label: Text(
                  'Cerrar Sesión',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white),
                ),
              )
            ],
            backgroundColor: Color.fromRGBO(227, 26, 33, 1),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20))),
            title: Text('Aministrador',
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: Colors.white)),
            bottom: TabBar(
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 8.0, color: Colors.white),
                  insets: EdgeInsets.symmetric(horizontal: 40.0)),
              tabs: [
                Tab(
                    icon: Icon(
                  Icons.add_box,
                )),
                Tab(icon: Icon(Icons.mode_edit)),
                Tab(icon: Icon(Icons.cancel)),
              ],
            ),
          ),
          body: TabBarView(children: [AddDish(), EditDish(), DeleteDish()]),
        ));
    // return LayoutBuilder(builder: (context, constraints) {
    //   print(constraints);
    //   if (constraints.maxWidth < 600) {
    //     return Text('Widget menor a 600');
    //   } else {
    //     return Text('Widget mayor a 600');
    //   }
    // });
    // return Container(
    //   child: Text(
    //     'Agregar platillos, modificar platillos, eliminar platillos',
    //     style: Theme.of(context).textTheme.headline1,
    //   ),
    // );
  }

  _logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Wrapper()));
  }
}
