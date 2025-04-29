import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:umore_mood_tracker/shared/routes/app_routes.dart';
import 'package:umore_mood_tracker/shared/theme/app_colors.dart';
import 'package:umore_mood_tracker/shared/widgets/widgets.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final int? currentIndex;
  final bool showFab;
  final bool showNavBar;

  const MainLayout({
    super.key,
    required this.child,
    this.currentIndex,
    this.showFab = true,
    this.showNavBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.mainColor, AppColors.secondaryColor],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(child: child),
          ),
        ),
      ),
      floatingActionButton: showFab ? _buildFab(context) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:
          showNavBar && currentIndex != null
              ? CustomBottomNavBar(
                selectedIndex: currentIndex!,
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
              )
              : null,
    );
  }

  Widget _buildFab(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 70,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: () {
            context.goNamed(AppRoutes.moodEntry);
          },
          backgroundColor: Colors.white,
          foregroundColor: AppColors.mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
