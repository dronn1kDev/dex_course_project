import 'package:flutter/material.dart';

final themeData = ThemeData(
  useMaterial3: true,
  primarySwatch: Colors.purple,
  // inpu
  // colorScheme: ColorScheme(
  //   brightness: brightness,
  //   primary: ColorCollection.primary,
  //   onPrimary: ColorCollection.onPrimary,
  //   secondary: secondary,
  //   onSecondary: onSecondary,
  //   error: error,
  //   onError: onError,
  //   background: background,
  //   onBackground: onBackground,
  //   surface: surface,
  //   onSurface: onSurface,
  // ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.w400,
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: Colors.black,
      // foregroundColor: ColorCollection.primary,
    ),
  ),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  ),
);
