import 'package:flutter/material.dart';
import 'package:umore_mood_tracker/shared/widgets/widgets.dart';

class StatsCard extends StatelessWidget {
  final String cardTitle;
  final String imageState;
  final String textState;

  const StatsCard({
    super.key,
    required this.cardTitle,
    required this.imageState,
    required this.textState,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MainText(
                text: cardTitle,
                color: Colors.black,
                fontSize: 20,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50, width: 50, child: Image.asset(imageState)),
              SubText(
                text: textState,
                color: Colors.black,
                fontSize: 16,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
