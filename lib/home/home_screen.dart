import 'package:flutter/material.dart';
import 'package:learning_helper/constants/ui_constants.dart';
import 'package:learning_helper/login/signin_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          logoutAction(context)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Text(
            'Home Screen',
            style: h1,
          ),
        ),
      ),
    );
  }
}