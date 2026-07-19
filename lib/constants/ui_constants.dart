import 'package:flutter/material.dart';
import 'package:learning_helper/constants/color_constants.dart';

final TextStyle h1 = TextStyle(
  fontSize: 24,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

final AppBarTheme _appBarTheme = AppBarTheme(
  backgroundColor: Colors.green,
  elevation: 32.0,
  shadowColor: Colors.green.withValues(alpha: 0.3),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
  ),
  centerTitle: true,
  titleTextStyle: const TextStyle(
    fontSize: 26,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    decorationThickness: 2,
  ),
);

final InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
  labelStyle: TextStyle(fontSize: 16, color: Colors.white),
  hintStyle: TextStyle(fontSize: 18, color: Colors.white),
);

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
  primaryColorDark: primaryColor,
  cardColor: cardColor,
  appBarTheme: _appBarTheme,
  brightness: Brightness.dark,
  inputDecorationTheme: _inputDecorationTheme,
  textTheme: TextTheme(titleLarge: h1),
);
