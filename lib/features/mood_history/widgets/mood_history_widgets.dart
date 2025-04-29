import 'package:flutter/material.dart';
import 'package:umore_mood_tracker/features/mood_entry/models/mood_entry.dart';
import 'package:umore_mood_tracker/shared/constants/mood_types.dart';
import 'package:umore_mood_tracker/shared/widgets/widgets.dart';

class MoodEntries extends StatelessWidget {
  const MoodEntries({super.key, required this.moodEntry});

  final MoodEntry moodEntry;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    moodTypes[moodEntry.moodId].image,
                    width: 70,
                    height: 70,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MainText(
                          text: moodTypes[moodEntry.moodId].description,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        const SizedBox(height: 4),
                        SubText(
                          text: moodEntry.timestamp,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                moodEntry.notes.isEmpty ? "No notes" : moodEntry.notes,
                style: const TextStyle(fontSize: 16, color: Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
