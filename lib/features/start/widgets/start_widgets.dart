import 'package:flutter/material.dart';

class EmojiImages extends StatelessWidget {
  const EmojiImages({
    super.key,
    required List<String> moodImages,
    required int currentImageIndex,
  }) : _moodImages = moodImages, _currentImageIndex = currentImageIndex;

  final List<String> _moodImages;
  final int _currentImageIndex;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      _moodImages[_currentImageIndex],
      width: 150,
      height: 150,
    );
  }
}
