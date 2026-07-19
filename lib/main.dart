import 'package:flutter/material.dart';
import 'package:learning_helper/constants/ui_constants.dart';
import 'package:learning_helper/login/login_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      home: LoginScreen(),
    );
  }
}
