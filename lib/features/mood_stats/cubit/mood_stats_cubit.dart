import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umore_mood_tracker/features/mood_entry/models/mood.dart';
import 'package:umore_mood_tracker/features/mood_stats/models/pie_section_data.dart';
import 'package:umore_mood_tracker/shared/constants/mood_types.dart';
import 'package:umore_mood_tracker/shared/database/database_helper.dart';
import 'package:umore_mood_tracker/shared/theme/app_colors.dart';

part 'mood_stats_state.dart';

class MoodStatsCubit extends Cubit<MoodStatsState> {
  MoodStatsCubit()
    : super(
        MoodStatsInitial(
          trends: [],
          mostFrequent: null,
          averageMoodType: null,
          averageMoodScore: 0,
        ),
      ) {
    getChartData();
    getAverageMood();
    getMostFrequentMood();
  }

  /*TODO: Methods - get history list from db, convert to display as trends, get average, get most frequent 

  */

  void getChartData() async {
    final moodTypeCount = await countByMood();
    late List<PieSectionData> pieChartData = [];
    final entriesCount = moodTypeCount.entries.length;

    for (MapEntry<int, int> entry in moodTypeCount.entries) {
      // get the percentage of each mood type out of 100%
      final percentage = ((entry.value / entriesCount) * 100);
      pieChartData.add(
        PieSectionData(
          color: getPieColor(entry.key),
          image: moodTypes[entry.key].image,
          value: percentage,
          title: '${percentage.toStringAsFixed(0)}%',
        ),
      );

      emit(state.copyWith(trends: pieChartData));
    }
  }

  // get the average mood score from average moodId
  void getAverageMood() async {
    final averageMood = await getAveMood();

    // get moodtype based on closest moodId to averageMood
    final moodType = moodTypes.reduce((a, b) {
      return (averageMood - moodTypes.indexOf(a)).abs() <
              (averageMood - moodTypes.indexOf(b)).abs()
          ? a
          : b;
    });

    emit(
      state.copyWith(averageMoodScore: averageMood, averageMoodType: moodType),
    );
  }

  // get most frequent mood type from history
  void getMostFrequentMood() async {
    final moodTypeCount = await countByMood();
    final mostFrequentMood = moodTypes[moodTypeCount.entries.first.key];

    emit(state.copyWith(mostFrequent: mostFrequentMood));
  }

  Color getPieColor(int index) {
    return index == 0
        ? AppColors.contentColorRed
        : index == 1
        ? AppColors.contentColorOrange
        : index == 2
        ? AppColors.contentColorYellow
        : index == 3
        ? AppColors.contentColorCyan
        : AppColors.contentColorGreen;
  }
}
