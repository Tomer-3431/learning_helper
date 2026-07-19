import 'package:flutter/material.dart';
import 'package:learning_helper/constants/ui_constants.dart';
import 'package:learning_helper/login/login.dart';

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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                _buildSignup(),
              ],
            ),
            Spacer(),
            Spacer(),
            Divider(),
            _buildGoogleLogin(),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildSignup() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            Text('Sign Up', style: h1),
            Text(
              'UserName',
              style: TextStyle(decoration: TextDecoration.underline),
            ),
            Text('Email', style: TextStyle(decoration: TextDecoration.underline)),
            Text(
              'Password',
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoogleLogin() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 20,
        children: [
          Text('Login With Google'),
          Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Theme.of(context).primaryColor),
            ),
            child: Center(
              child: Text('PLACE HOLDER', textAlign: TextAlign.center),
            ),
          ),
        ],
      ),
    );
  }
}
