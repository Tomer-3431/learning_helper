import 'package:flutter/material.dart';
import 'package:learning_helper/constants/color_constants.dart';
import 'package:learning_helper/constants/ui_constants.dart';
import 'package:learning_helper/db/db_constants.dart' show anonyName;
import 'package:learning_helper/db/global.dart';
import 'package:learning_helper/login/signin_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          logoutAction(context)
        ],
      ),
      drawer: Drawer(
        elevation: 8,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Hello ',
                      style: TextTheme.of(context).headlineLarge,
                    ),
                    TextSpan(
                      text: currentUser?.name ?? anonyName,
                      style: TextTheme.of(
                        context,
                      ).headlineLarge?.copyWith(color: primaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              _navRow(icon: Icons.quiz, label: 'Quiz Select', destination: Container()),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(32.0),
        child: Center(child: Text('Home Screen', style: h1)),
      ),
    );
  }

  Widget _navRow({
    required IconData icon,
    required String label,
    required Widget destination,
  }) => GestureDetector(
    onTap: () =>
        Navigator.push(context, MaterialPageRoute(builder: (_) => destination)),
    child: Row(
      spacing: 5,
      children: [
        Icon(icon),
        Text(label),
        Expanded(
          child: Row(
            mainAxisAlignment: .end,
            children: [Icon(Icons.arrow_forward_ios)],
          ),
        ),
      ],
    ),
  );
}
