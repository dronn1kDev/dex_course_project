import 'package:dex_course_temp/bloc/cube_position_bloc.dart';
import 'package:dex_course_temp/cube_screen.dart';
import 'package:dex_course_temp/features/auth/presentation/auth_page.dart';
import 'package:dex_course_temp/menu_screen.dart';
import 'package:dex_course_temp/user_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppRouteList {
  static const menu = '/menu';
  static const cube = '/menu/cube';
  static const userForm = '/menu/user-form';
  static const authPage = '/auth';
}

abstract class AppRouterConfig {
  static final routeList = {
    AppRouteList.menu: (context) => const MenuScreen(),
    AppRouteList.cube: (context) => BlocProvider(
          create: (context) => CubePositionBloc(),
          child: const CubeScreen(),
        ),
    AppRouteList.userForm: (context) => const UserFormScreen(),
    AppRouteList.authPage: (context) => const AuthPage(),
  };
}
