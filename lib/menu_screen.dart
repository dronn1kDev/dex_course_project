import 'package:dex_course_temp/core/presentation/app_filled_button.dart';
import 'package:dex_course_temp/routing.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppFilledButton(
              onPressed: () => _goToCube(context),
              child: const Text('Cube'),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () => _goToUserForm(context),
              child: const Text('User Form'),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRouteList.authPage),
              child: const Text('Auth'),
            ),
          ],
        ),
      ),
    );
  }

  void _goToCube(BuildContext context) =>
      Navigator.of(context).pushNamed(AppRouteList.cube);

  void _goToUserForm(BuildContext context) =>
      Navigator.of(context).pushNamed(AppRouteList.userForm);
}
