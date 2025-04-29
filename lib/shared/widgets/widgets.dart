import 'package:flutter/material.dart';
import 'package:umore_mood_tracker/shared/theme/app_colors.dart';
import 'package:umore_mood_tracker/shared/widgets/main_layout.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      showNavBar: false,
      showFab: false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: const Icon(Icons.check, color: Colors.white, size: 80),
              ),
            ),
            const SizedBox(height: 32),
            const MainText(text: 'Mood Entry Saved!'),
            const SizedBox(height: 8),
            const SubText(text: 'Returning to home...'),
          ],
        ),
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      height: 64,
      padding: EdgeInsets.zero,
      notchMargin: 8,
      shape: const CircularNotchedRectangle(),
      elevation: 8.0,
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavBarItem(0, Icons.home, "Home"),
                _buildNavBarItem(1, Icons.insights, "Stats"),
              ],
            ),
          ),
          const SizedBox(width: 48),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavBarItem(2, Icons.history, "History"),
                _buildNavBarItem(3, Icons.person, "Profile"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(int index, IconData icon, String label) {
    return FittedBox(
      child: Column(
        children: [
          IconButton(
            onPressed: () => onItemSelected(index),
            icon: Icon(icon),
            color: selectedIndex == index ? Color(0xFF4169E1) : Colors.black,
            iconSize: 32,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: selectedIndex == index ? Color(0xFF4169E1) : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// Widget to display progress indicators for mood entry steps
class ProgressDotIndicator extends StatelessWidget {
  const ProgressDotIndicator({super.key, required this.isFirstStep});

  final bool isFirstStep;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 2; i++)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              color:
                  i == (isFirstStep ? 0 : 1)
                      ? Colors
                          .white // Highlight current step
                      : Colors.white.withAlpha((0.4 * 255).toInt()),
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }
}

// Button to navigate to the home screen
class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    this.context,
    this.onPressed,
    required this.text,
    this.fontSize,
    this.textColor,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    super.key,
  });

  final BuildContext? context;
  final VoidCallback? onPressed;
  final String text;
  final double? fontSize;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding: padding ?? EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize ?? 14,
            color: textColor ?? AppColors.mainColor,
          ),
        ),
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    this.context,
    this.onPressed,
    required this.text,
    required this.icon,
    required this.borderColor,
    this.fontSize,
    this.textColor,
    this.foregroundColor,
    this.padding,
    super.key,
  });

  final BuildContext? context;
  final VoidCallback? onPressed;
  final String text;
  final Icon icon;
  final Color borderColor;
  final double? fontSize;
  final Color? textColor;
  final Color? foregroundColor;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: padding ?? EdgeInsets.symmetric(vertical: 12),
          side: BorderSide(width: 1, color: borderColor),
          foregroundColor: foregroundColor,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize ?? 14,
            color: textColor ?? AppColors.mainColor,
          ),
        ),
      ),
    );
  }
}

// Widget to display main text with bold styling
class MainText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final double? fontSize;
  final FontStyle? fontStyle;
  final Color? color;

  const MainText({
    super.key,
    required this.text,
    this.textAlign,
    this.fontWeight,
    this.fontSize,
    this.fontStyle,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.white,
        fontSize: fontSize ?? 26,
        fontWeight: fontWeight ?? FontWeight.bold,
        fontStyle: fontStyle ?? FontStyle.normal,
      ),
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}

// Widget to display subtext with smaller font size
class SubText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final Color? color;

  const SubText({
    super.key,
    required this.text,
    this.textAlign,
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.white,
        fontSize: fontSize ?? 16,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontStyle: fontStyle ?? FontStyle.normal,
      ),
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}
