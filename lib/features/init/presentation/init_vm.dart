import 'package:dex_course_temp/routing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InitViewModel {
  const InitViewModel();

  Future<void> goToAuth(BuildContext context) => Future.delayed(
      const Duration(seconds: 2), () => context.go(AppRouteList.auth));
}
