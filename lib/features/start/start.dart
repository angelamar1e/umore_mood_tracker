import 'dart:async';
import 'package:flutter/material.dart';
import '../../../shared/widgets/widgets.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  int _currentImageIndex = 0;
  late Timer _timer;

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
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % _moodImages.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              emojiImages(),
              Column(children: [titleText(), subtitleText()]),
              SizedBox(height: 64),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: GetStartedButton(context: context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Image emojiImages() {
    return Image.asset(
      _moodImages[_currentImageIndex],
      width: 150,
      height: 150,
    );
  }

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
