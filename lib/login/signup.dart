import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignupState();
}

class _SignupState extends State<Signup>{
  final TextEditingController _nameController = TextEditingController();

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

  Widget get _nameField => SizedBox(
    width: MediaQuery.of(context).size.width * 0.4,
    child: TextFormField(
      textAlign: .left,
      keyboardType: .name,
      textInputAction: TextInputAction.next,
      autofocus: false,
      controller: _nameController,
      decoration: InputDecoration(
        labelText: 'Name',
        hint: Text('Enter Your Name: '),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Name field cannot be empty';
        }

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
      validator:(value) {
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
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              Text('Signup', style: TextTheme.of(context).titleLarge),
              _nameField,
              _emailField,
              _passwordField,
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                  }
                }, 
                child: Text(
                  'submit',
                  style: TextTheme.of(context).labelLarge,
                )
              ),
            ],
          ),
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