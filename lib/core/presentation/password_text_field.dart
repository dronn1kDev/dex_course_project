import 'package:dex_course_temp/core/presentation/app_text_field.dart';
import 'package:dex_course_temp/core/presentation/password_text_editing_controller.dart';
import 'package:flutter/material.dart';
import 'package:reactive_variables/reactive_variables.dart';

class PasswordTextField extends StatelessWidget {
  final PassTextEditingController controller;

  final String labelText;

  const PasswordTextField(
      {super.key, required this.controller, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Obs(
        rvList: [controller.isTextHidden],
        builder: (context) {
          return AppTextField(
            labelText: labelText,
            controller: controller,
            obscureText: controller.isTextHidden(),
            prefixIcon: const Icon(Icons.lock_outlined),
            suffixIcon: IconButton(
              onPressed: onIconPressed,
              icon: controller.isTextHidden()
                  ? const Icon(Icons.visibility_off_outlined)
                  : const Icon(Icons.visibility_outlined),
            ),
          );
        });
  }

  void onIconPressed() =>
      controller.isTextHidden(!controller.isTextHidden.value);
}
