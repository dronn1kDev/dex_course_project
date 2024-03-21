import 'package:flutter/material.dart';

abstract class ColorCollection {
  static const primary = Color(0xFFDF3A76);
  static const onPrimary = Colors.white;
  static const primaryContainer = Color(0xFFFFD8EC);
  static const onPrimaryContainer = Color(0xFF37072A);
  static const secondary = Color(0xFFB61263);
  static const onSecondary = Colors.white;
  static const error = Color(0xFFBA1A1A);
  static const onError = Colors.white;
  static const surface = Color(0xFFFFF8F9);
  static const onSurface = Color(0xFF211A1D);
  static const background = surface;
  static const onBackground = onSurface;

  static const outline = Color(0xFF81737A);

  static const onSurfaceVariant = Color(0xFF4F4449);

  static const surfaceContainerLow = Color(0xFFFEF0F5);

  static const outlineVariant = Color(0xFFD3C2C9);
}
