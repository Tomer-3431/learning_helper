import 'package:flutter/material.dart';
import 'package:learning_helper/constants/color_constants.dart';
import 'package:learning_helper/db/db_constants.dart';
import 'package:learning_helper/db/global.dart';
import 'package:learning_helper/quizMaker/quiz_maker_general_screen.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            SizedBox(height: 10),
            _navRow(
              icon: Icons.construction,
              label: 'Quiz Maker',
              destination: QuizMakerGeneralScreen(),
            ),
          ],
        ),
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
