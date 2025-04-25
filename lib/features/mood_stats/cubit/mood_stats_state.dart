// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'mood_stats_cubit.dart';

class MoodStatsState {
  final List<PieSectionData> trends;
  final Mood? averageMoodType;
  final double? averageMoodScore;
  final Mood? mostFrequent;

  MoodStatsState({
    required this.trends,
    required this.averageMoodType,
    required this.averageMoodScore,
    required this.mostFrequent,
  });

  MoodStatsState copyWith({
    List<PieSectionData>? trends,
    Mood? averageMoodType,
    double? averageMoodScore,
    Mood? mostFrequent,
  }) {
    return MoodStatsState(
      trends: trends ?? this.trends,
      averageMoodType: averageMoodType ?? this.averageMoodType,
      averageMoodScore: averageMoodScore ?? this.averageMoodScore,
      mostFrequent: mostFrequent ?? this.mostFrequent,
    );
  }
}

final class MoodStatsInitial extends MoodStatsState {
  MoodStatsInitial({
    required super.trends,
    required super.averageMoodType,
    required super.averageMoodScore,
    required super.mostFrequent,
  });
}
