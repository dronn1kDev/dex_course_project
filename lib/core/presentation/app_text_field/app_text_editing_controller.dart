import 'package:flutter/material.dart';
import 'package:reactive_variables/reactive_variables.dart';

class AppTextEditingController extends TextEditingController {
  final Rv<String?> errorText = Rv(null);

  AppTextEditingController({
    super.text,
  });
}
