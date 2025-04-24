import 'dart:async';
import 'package:flutter/material.dart';
import '../../../shared/widgets/widgets.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  int _currentImageIndex = 0; // Tracks the current index of the mood image
  late Timer _timer; // Timer to periodically update the image index

  // List of mood image paths
  final List<String> _moodImages = [
    'lib/shared/assets/images/happy_face.png',
    'lib/shared/assets/images/sad_face.png',
    'lib/shared/assets/images/neutral_face.png',
    'lib/shared/assets/images/angry_face.png',
    'lib/shared/assets/images/crying_face.png',
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the timer to update the image index every 500ms
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % _moodImages.length;
      });
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Set a gradient background for the screen
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF87CEEB), Color(0xFF4169E1)],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center content vertically
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Stretch content horizontally
            children: [
              emojiImages(), // Display the mood image
              Column(
                children: [titleText(), subtitleText()],
              ), // Display title and subtitle
              SizedBox(height: 64), // Add spacing
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: GetStartedButton(
                  context
                ), // Display the "Get Started" button
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to display the current mood image
  Image emojiImages() {
    return Image.asset(
      _moodImages[_currentImageIndex],
      width: 150,
      height: 150,
    );
  }

  // Widget to display the title text
  Text titleText() {
    return Text(
      'UMORE',
      style: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  // Widget to display the subtitle text
  Text subtitleText() {
    return Text(
      'Track yourself more',
      style: TextStyle(
        fontSize: 20,
        fontStyle: FontStyle.italic,
        color: Colors.white,
      ),
    );
  }
}
