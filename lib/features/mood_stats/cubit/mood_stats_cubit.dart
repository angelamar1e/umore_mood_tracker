import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umore_mood_tracker/features/mood_entry/models/mood.dart';
import 'package:umore_mood_tracker/features/mood_entry/models/mood_entry.dart';

part 'mood_stats_state.dart';

class MoodStatsCubit extends Cubit<MoodStatsState> {
  MoodStatsCubit()
    : super(
        MoodStatsInitial(
          trends: List.empty(),
          average: Mood(image: FileImage(File('')), description: ''),
          mostFrequent: Mood(image: FileImage(File('')), description: ''),
        ),
      );

  /*TODO: Methods - get history list from db, convert to display as trends, get average, get most frequent 

  */
}
