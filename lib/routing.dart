import 'package:dex_course_temp/cube_screen.dart';
import 'package:dex_course_temp/menu_screen.dart';
import 'package:dex_course_temp/user_form.dart';

abstract class AppRouteList {
  static const menu = '/menu';
  static const cube = '/menu/cube';
  static const userForm = '/menu/user-form';
}

abstract class AppRouterConfig {
  static final routeList = {
    AppRouteList.menu: (context) => const MenuScreen(),
    AppRouteList.cube: (context) => const CubeScreen(),
    AppRouteList.userForm: (context) => UserFormScreen(),
  };
}
