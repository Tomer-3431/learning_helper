import 'package:flutter/material.dart';
import 'package:learning_helper/constants/ui_constants.dart';
import 'package:learning_helper/home/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.green.shade900,
        cardColor: Colors.teal.shade100,
        appBarTheme: appBarTheme,
        brightness: Brightness.dark,
      ),
      home: HomeScreen(),
    );
  }
}
