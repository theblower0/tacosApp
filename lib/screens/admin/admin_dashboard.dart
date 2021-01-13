import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tacos_app/screens/admin/admin_options/admin_option.dart';
import 'package:tacos_app/screens/admin/admin_order_option/admin_order_option.dart';
import 'package:tacos_app/screens/admin/admin_order_view/admin_order_view.dart';

class AdminDashboard extends StatefulWidget {
  AdminDashboard({Key key}) : super(key: key);

  @override
  _AdminDashoardState createState() => _AdminDashoardState();
}

class _AdminDashoardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    AdminOption(),
    OrderView(),
    OrderOption(),
    //Menu();
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(227, 26, 33, 1),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        elevation: 30,
        iconSize: 20,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.admin_panel_settings,
            ),
            label: 'Admin',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_bag,
            ),
            label: 'Pedidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.fact_check,
            ),
            label: 'Orden',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.menu_book,
              ),
              label: 'Menú'),
        ],
        onTap: _onItemTapped,
      ),
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
