// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'mood_stats_cubit.dart';

class MoodStatsState {
  final List<MoodEntry> trends;
  final Mood average;
  final Mood mostFrequent;

  MoodStatsState({
    required this.trends,
    required this.average,
    required this.mostFrequent,
  });
}

final class MoodStatsInitial extends MoodStatsState {
  MoodStatsInitial({
    required super.trends,
    required super.average,
    required super.mostFrequent,
  });
}
