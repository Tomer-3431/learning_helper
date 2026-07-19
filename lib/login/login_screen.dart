import 'package:flutter/material.dart';
import 'package:learning_helper/login/google_sign.dart';
import 'package:learning_helper/login/login.dart';
import 'package:learning_helper/login/signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Screen')),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          spacing: 10,
          children: [
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Login(),
                Container(
                  height: 500,
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      vertical: BorderSide(width: 2, color: Colors.white),
                    ),
                  ),
                ),
                Signup()
              ],
            ),
            Spacer(),
            Spacer(),
            Divider(),
            GoogleSign(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
