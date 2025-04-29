import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:umore_mood_tracker/features/start/widgets/start_widgets.dart';
import 'package:umore_mood_tracker/shared/routes/app_routes.dart';
import 'package:umore_mood_tracker/shared/widgets/main_layout.dart';
import 'package:umore_mood_tracker/shared/widgets/widgets.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  int _currentImageIndex = 0;
  late Timer _timer;

  // List of mood image paths
  final List<String> _moodImages = [
    'lib/shared/assets/images/happy_face.png',
    'lib/shared/assets/images/smiling_face.png',
    'lib/shared/assets/images/neutral_face.png',
    'lib/shared/assets/images/sad_face.png',
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
    return MainLayout(
      showFab: false,
      showNavBar: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          EmojiImages(
            moodImages: _moodImages,
            currentImageIndex: _currentImageIndex,
          ),
          Column(
            children: [
              const MainText(
                text: 'UMORE',
                fontSize: 48,
              ),
              const SubText(
                text: 'Track yourself more',
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ],
          ),
          const SizedBox(height: 64),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: CustomElevatedButton(
              text: 'Get Started',
              onPressed: () => context.goNamed(AppRoutes.home),
              backgroundColor: Colors.white,
              foregroundColor: Color(0xFF4169E1),
            ),
          ),
        ],
      ),
    );
  }
}
