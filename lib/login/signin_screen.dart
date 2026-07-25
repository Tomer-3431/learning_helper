import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:learning_helper/constants/color_constants.dart';
import 'package:learning_helper/db/global.dart';
import 'package:learning_helper/login/platform_login.dart';
import 'package:learning_helper/login/login.dart';
import 'package:learning_helper/login/signup.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SigninScreenState();
}

enum AuthState { signup, login }

class _SigninScreenState extends State<SigninScreen> {
  late AuthState _currentAuthState;

  @override
  void initState() {
    super.initState();

    _currentAuthState = AuthState.login;
  }

  void _hadleDiffrenetAuthAction() {
    switch (_currentAuthState) {
      case AuthState.signup:
        setState(() {
          _currentAuthState = AuthState.login;
        });
        break;
      case AuthState.login:
        setState(() {
          _currentAuthState = AuthState.signup;
        });
        break;
    }
  }

  Widget _buildHeader() {
    final String welcomeText = 'Welcome to Learnign Helper!';

    late String title;
    late String leadingText;
    late String hintText;
    late String actionText;

    switch (_currentAuthState) {
      case AuthState.signup:
        title = 'Sign Up';
        leadingText = '$welcomeText Please create an account to continue';
        hintText = 'Already have an account? ';
        actionText = 'Log in';
        break;
      case AuthState.login:
        title = 'Log in';
        leadingText = '$welcomeText Please log in to continue';
        hintText = 'Don\'t have an account? ';
        actionText = 'Sign up';
        break;
    }

    TextSpan subtitle = TextSpan(
      children: [
        TextSpan(text: hintText, style: TextTheme.of(context).bodyLarge),
        TextSpan(
          text: actionText,
          style: TextTheme.of(
            context,
          ).bodyLarge?.copyWith(color: primaryColor),
          mouseCursor: SystemMouseCursors.click,
          recognizer: TapGestureRecognizer()..onTap = _hadleDiffrenetAuthAction,
        ),
      ],
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextTheme.of(context).titleLarge),
        SizedBox(height: 10),
        Text(leadingText, style: TextTheme.of(context).bodyLarge),
        Text.rich(subtitle),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Signin Screen')),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          spacing: 10,
          children: [
            Text(currentUser?.name ?? ''),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Spacer(),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 900
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    SizedBox(
                      height: 20,
                    ),
                    switch (_currentAuthState) {
                      AuthState.signup => Signup(),
                      AuthState.login => Login()
                    },
                    SizedBox(height: 20,),
                    SocialLogin()
                  ],
                ),
                Spacer()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
