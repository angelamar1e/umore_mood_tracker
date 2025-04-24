part of 'mood_entry_cubit.dart';

enum MoodType { happy, sad, neutral, angry, crying }

class MoodEntryState {}

final class MoodEntryInitial extends MoodEntryState {}

final class MoodEntryInProgress extends MoodEntryState {
  final int selectedMoodIndex;
  final List<Map<String, dynamic>> moodData;

  MoodEntryInProgress({
    required this.selectedMoodIndex,
    required this.moodData,
  });

  MoodEntryInProgress copyWith({
    int? selectedMoodIndex,
    List<Map<String, dynamic>>? moodData,
  }) {
    return MoodEntryInProgress(
      selectedMoodIndex: selectedMoodIndex ?? this.selectedMoodIndex,
      moodData: moodData ?? this.moodData,
    );
  }
}

final class MoodEntryComplete extends MoodEntryState {
  final int selectedMoodIndex;
  final List<Map<String, dynamic>> moodData;
  final String journalText;

  MoodEntryComplete({
    required this.selectedMoodIndex,
    required this.moodData,
    this.journalText = '',
  });

  MoodEntryComplete copyWith({
    int? selectedMoodIndex,
    List<Map<String, dynamic>>? moodData,
    String? journalText,
  }) {
    return MoodEntryComplete(
      selectedMoodIndex: selectedMoodIndex ?? this.selectedMoodIndex,
      moodData: moodData ?? this.moodData,
      journalText: journalText ?? this.journalText,
    );
  }
}

final class MoodEntrySaved extends MoodEntryState {
  final int selectedMoodIndex;
  final List<Map<String, dynamic>> moodData;
  final String journalText;

  MoodEntrySaved({
    required this.selectedMoodIndex,
    required this.moodData,
    required this.journalText,
  });
}
