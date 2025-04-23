import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umore_mood_tracker/features/mood_entry/models/mood.dart';
import 'package:umore_mood_tracker/features/mood_entry/models/mood_entry.dart';

part 'mood_entry_state.dart';

class MoodEntryCubit extends Cubit<MoodEntryState> {
  MoodEntryCubit()
    : super(
        MoodEntryInitial(
          entry: MoodEntry(
            mood: Mood(
              image: FileImage(File('lib/shared/assets/images/happy_face.png')),
              description: '',
            ),
            notes: '',
            timestamp: DateTime(2025),
          ),
        ),
      );

  //TODO: Methods - add entry
}
