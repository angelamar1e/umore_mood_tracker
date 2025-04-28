import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:umore_mood_tracker/shared/routes/app_routes.dart';
import 'package:umore_mood_tracker/shared/widgets/widgets.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  final bool showFab;

  const MainLayout({
    super.key,
    required this.child,
    required this.currentIndex,
    this.showFab = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4169E1),
      body: child,
      floatingActionButton: showFab ? _buildFab(context) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: currentIndex,
        onItemSelected: (index) {
          if (index == currentIndex) return;
          switch (index) {
            case 0:
              context.goNamed(AppRoutes.home);
              break;
            case 1:
              context.goNamed(AppRoutes.moodStats);
              break;
            case 2:
              context.goNamed(AppRoutes.moodHistory);
              break;
            case 3:
              context.goNamed(AppRoutes.profile);
              break;
          }
        },
      ),
    );
  }

  Widget _buildFab(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 70,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: () {
            context.goNamed('mood-entry');
          },
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF4169E1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
