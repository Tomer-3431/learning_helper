import 'package:flutter/material.dart';

final TextStyle h1 = TextStyle(
  fontSize: 24,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

final AppBarTheme appBarTheme = AppBarTheme(
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
