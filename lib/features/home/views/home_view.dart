import 'package:flutter/material.dart';
import 'package:umore_mood_tracker/features/home/widgets/home_widgets.dart';
import 'package:umore_mood_tracker/shared/theme/app_colors.dart';
import 'package:umore_mood_tracker/shared/widgets/main_layout.dart';
import 'package:umore_mood_tracker/shared/widgets/widgets.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  final String name = "User";
  final _selectedDayIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 0,
      child: Container(
        decoration: gradientBackground(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MainText(text: "Hello, $name!", color: Colors.white),
                const SizedBox(height: 20),
                DayTimeline(selectedDayIndex: _selectedDayIndex, hasData: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
