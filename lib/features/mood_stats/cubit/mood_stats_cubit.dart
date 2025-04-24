import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umore_mood_tracker/features/mood_entry/models/mood.dart';
import 'package:umore_mood_tracker/features/mood_entry/models/mood_entry.dart';
import 'package:umore_mood_tracker/features/mood_stats/models/pie_scction_data.dart';
import 'package:umore_mood_tracker/shared/constants/mood_types.dart';
import 'package:umore_mood_tracker/shared/database/database_helper.dart';

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

  void getChartData() async {
    final moodTypeCount = await countByMood();
    late List<PieSectionData> pieChartData = [];

    for (MapEntry<String, int> entry in moodTypeCount.entries) {
      final percentage = entry.value * 100 / moodTypeCount.length;
      pieChartData.add(
        PieSectionData(
          image: moodTypes[entry.key]!.image,
          value: percentage,
          title: '$percentage%',
        ),
      );
    }
  }
}
