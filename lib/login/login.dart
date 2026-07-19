import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_helper/constants/ui_constants.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  bool isVisable = false;

  final TextEditingController _passwordController = TextEditingController();
  Widget get _emailField =>
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: TextFormField(
          textAlign: .left,
          keyboardType: .emailAddress,
          textInputAction: TextInputAction.next,
          autofocus: false,
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            hint: Text(
              'Enter Your Email: '
            )
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Email address cannot be empty';
            }
          },
        ),
      );

  Widget get _nameField =>
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: TextField(
          textAlign: .left,
          keyboardType: .name,
          textInputAction: TextInputAction.next,
          autofocus: false,
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Name',
            hint: Text(
              'Enter Your Name: '
            )
          ),    
        ),
      );
  Widget get _passwordField =>
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: TextField(
          textAlign: .left,
          obscureText: !isVisable,
          keyboardType: isVisable ? .visiblePassword : .none,
          textInputAction: TextInputAction.next,
          autofocus: false,
          controller: _passwordController,
          decoration: InputDecoration(
            labelText: 'Password',
            hint: Text(
              'Enter Your Password: '
            ),
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
            )
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            Text('Login', style: h1),
            _nameField,
            _emailField,
            _passwordField
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    _nameController.dispose();
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
