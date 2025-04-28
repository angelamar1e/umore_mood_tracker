import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF87CEEB), Color(0xFF4169E1)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check, // Use check instead of check_circle
                      color: Colors.white,
                      size: 80,
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Text(
                  'Mood Entry Saved!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Returning to home...',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
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
      shape: CircularNotchedRectangle(),
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

          SizedBox(width: 48),

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
            iconSize: 28,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
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

  final bool isFirstStep; // Indicates if the current step is the first step

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
    this.textStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    super.key,
  });

  final BuildContext? context;
  final VoidCallback? onPressed;
  final String text;
  final TextStyle? textStyle;
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
          padding: padding ?? EdgeInsets.symmetric(vertical: 8),
        ),
        child: Text(text, style: textStyle),
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
    this.textStyle,
    required this.borderColor,
    this.foregroundColor,
    this.padding,
    super.key,
  });

  final BuildContext? context;
  final VoidCallback? onPressed;
  final String text;
  final Icon icon;
  final TextStyle? textStyle;
  final Color borderColor;
  final Color? foregroundColor;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 8),
          side: BorderSide(width: 1, color: borderColor),
          foregroundColor: foregroundColor,
        ),
        child: Text(text, style: textStyle),
      ),
    );
  }
}

// Widget to display main text with bold styling
class MainText extends StatelessWidget {
  final String text;
  final Color color;

  const MainText({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: color),
    );
  }
}

// Widget to display subtext with smaller font size
class SubText extends StatelessWidget {
  final String text;
  final Color color; // Text to display

  const SubText({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: color,
      ),
    );
  }
}
