import 'package:flutter/material.dart';

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
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildLogin(),
                Divider(),
                _buildSignup()
              ],
            ),
            Divider(),
            _buildGoogleLogin(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogin() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Login'
          ),
        ],
      ),
    );
  }

  Widget _buildSignup() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sign Up'
          ),
        ],
      ),
    );
  }

  Widget _buildGoogleLogin() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        spacing: 20,
        children: [
          Text('Login With Google'),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Theme.of(context).primaryColor),
            ),
            child: Center(child: Text('PLACE HOLDER')),
          ),
        ],
      ),
    );
  }
}
