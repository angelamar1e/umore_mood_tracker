import 'package:flutter/material.dart';
import 'package:umore_mood_tracker/shared/theme/app_colors.dart';
import 'package:umore_mood_tracker/shared/widgets/main_layout.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 3,
      child: Container(decoration: gradientBackground()),
    );
  }
}
