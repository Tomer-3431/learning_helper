import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:learning_helper/constants/color_constants.dart';
import 'package:learning_helper/db/global.dart';
import 'package:learning_helper/db/user.dart';
import 'package:learning_helper/home/home_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? _errorMessege;

  Future<void> _loginUser() async {
    try {
      setState(() {
        _errorMessege = null;
      });

      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final uid = userCredential.user!.uid;

      _setCurrentUser(
        userId: uid,
        name: userCredential.user!.displayName,
        email: userCredential.user!.email,
      );

      if (mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessege = 'Firebase Auth Exception: ${e.message}';
      });

      if (kDebugMode) {
        print(e.code);
      }
    } on FirebaseException catch (e) {
      setState(() {
        _errorMessege = 'Firebasea Exception: ${e.message}';
      });

      if (kDebugMode) {
        print(e.code);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _setCurrentUser({
    required String userId,
    String? name,
    String? email,
  }) async {
    currentUser = User.fromUID(uid: userId, name: name, email: email);
  }

  final TextEditingController _emailController = TextEditingController();

  bool isVisable = false;

  final TextEditingController _passwordController = TextEditingController();

  Widget get _emailField => SizedBox(
    width: MediaQuery.of(context).size.width * 0.4,
    child: TextFormField(
      textAlign: .left,
      keyboardType: .emailAddress,
      textInputAction: TextInputAction.next,
      autofocus: false,
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        hint: Text('Enter Your Email: '),
      ),
      onChanged: (value) {
        _formKey.currentState?.clearError();
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Email address cannot be empty';
        }

        final bool isValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        ).hasMatch(value.trim());

        if (!isValid) return 'Please Enter a valid email address';

        return null;
      },
    ),
  );

  Widget get _passwordField => SizedBox(
    width: MediaQuery.of(context).size.width * 0.4,
    child: TextFormField(
      textAlign: .left,
      obscureText: !isVisable,
      keyboardType: isVisable ? .visiblePassword : .none,
      textInputAction: TextInputAction.next,
      autofocus: false,
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        hint: Text('Enter Your Password: '),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isVisable = !isVisable;
            });
          },
          icon: Icon(
            isVisable
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: Colors.white,
            size: 18,
          ),
        ),
      ),
      onChanged: (value) {
        _formKey.currentState?.clearError();
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Password cannot be empty';
        }

        return null;
      },
    ),
  );

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            _emailField,
            _passwordField,
            SizedBox(height: 10),
            CupertinoButton.filled(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _loginUser();
                }
              },
              color: secondaryColor,
              minimumSize: Size(775, 50),
              mouseCursor: SystemMouseCursors.click,
              child: Center(
                child: Text(
                  'Login with email and password',
                  style: TextTheme.of(context).labelLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (_errorMessege != null)
              Text(
                _errorMessege!,
                style: TextTheme.of(
                  context,
                ).bodySmall?.copyWith(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    isVisable = false;
  }
}
