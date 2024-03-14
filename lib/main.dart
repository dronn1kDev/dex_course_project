import 'package:dex_course_temp/routing.dart';
import 'package:dex_course_temp/theme/theme_data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home work #3
      title: 'Flutter Demo',

      theme: themeData,
      routes: AppRouterConfig.routeList,
      initialRoute: AppRouteList.menu,
    );
  }
}
