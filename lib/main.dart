import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:tacos_app/models/data_image.dart';
import 'package:tacos_app/models/image_upate.dart';
import 'package:tacos_app/models/update_product.dart';
import 'package:tacos_app/screens/admin/admin_dashboard.dart';
import 'package:tacos_app/shared/theme.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => DataImage()),
      ChangeNotifierProvider(create: (context) => DataImageUp()),
      ChangeNotifierProvider(create: (context) => UpdateProduct())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1280,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            // ResponsiveBreakpoint.autoScale(1280, name: TABLET),
          ],
          background: Container(color: Color(0xFFF5F5F5))),
      title: 'Tacos App',
      theme: appTheme,
      home: AdminDashboard(),
    );
  }
}
