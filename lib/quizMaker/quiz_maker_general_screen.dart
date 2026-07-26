import 'package:flutter/material.dart';
import 'package:learning_helper/constants/color_constants.dart';
import 'package:learning_helper/home/sidebar.dart';
import 'package:learning_helper/quizMaker/overview_section.dart';

class QuizMakerGeneralScreen extends StatefulWidget {
  const QuizMakerGeneralScreen({super.key});

  @override
  State<QuizMakerGeneralScreen> createState() => _QuizMakerGeneralScreenState();
}

class _QuizMakerGeneralScreenState extends State<QuizMakerGeneralScreen> {
  late _QuizMakerSections _currentSection;

  @override
  void initState() {
    super.initState();

    _currentSection = .overview;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz Maker')),
      drawer: Sidebar(),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              spacing: 10,
              children: _sections()
            ),
            Expanded(
              child: _currentSection.screen!
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _sections() {
    List<Widget> row = [];

    for (int i = 0; i < _QuizMakerSections.values.length; i++) {
      if (i != 0) {
        row.add(
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 1,
            height: 30,
            decoration: BoxDecoration(
              border: Border.symmetric(
                vertical: BorderSide(color: primaryColor, width: 1),
              ),
            ),
          ),
        );
      }

      final section = _QuizMakerSections.values[i];

      row.add(
        MouseRegion(
          onHover: (event) => SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              if (_currentSection.screen != null) {
                setState(() {
                  _currentSection = section;
                });
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: BoxBorder.all(
                  color: (_currentSection == section) ? primaryColor : Colors.transparent,
                  width: 2,
                )
              ),
              child: Text(
                section.title,
                style: TextTheme.of(context).labelMedium,
              ),
            ),
          ),
        ),
      );
    }

    return row;
  }
}

enum _QuizMakerSections {
  overview(title: 'Overview', screen: OverviewSection()),
  questions(title: 'Questions'),
  test(title: 'Test'),
  students(title: 'Students'),
  settings(title: 'Settings');

  final String title;
  final Widget? screen;

  const _QuizMakerSections({required this.title, this.screen});
}
