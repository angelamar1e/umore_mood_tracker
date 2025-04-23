// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:umore_mood_tracker/features/mood_entry/models/mood.dart';

class MoodEntry {
  Mood mood;
  String notes;
  DateTime timestamp;

  MoodEntry({required this.mood, required this.notes, required this.timestamp});
}
