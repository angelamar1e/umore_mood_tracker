part of 'mood_entry_cubit.dart';

// Enum representing different mood types
enum MoodType { happy, sad, neutral, angry, crying }

@immutable
sealed class MoodEntryState {}

// Initial state of the MoodEntry feature
final class MoodEntryInitial extends MoodEntryState {}

// State representing an in-progress mood entry
final class MoodEntryInProgress extends MoodEntryState {
  // Index of the selected mood
  final int selectedMoodIndex;
  // List of mood data containing additional details
  final List<Map<String, dynamic>> moodData;

  MoodEntryInProgress({
    required this.selectedMoodIndex,
    required this.moodData,
  });

  // Creates a copy of the current state with optional updated values
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

// State representing a completed mood entry
final class MoodEntryComplete extends MoodEntryState {
  // Index of the selected mood
  final int selectedMoodIndex;
  // List of mood data containing additional details
  final List<Map<String, dynamic>> moodData;
  // Text for the journal entry
  final String journalText;

  MoodEntryComplete({
    required this.selectedMoodIndex,
    required this.moodData,
    this.journalText = '',
  });

  // Creates a copy of the current state with optional updated values
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

// State representing a saved mood entry
final class MoodEntrySaved extends MoodEntryState {
  // Index of the selected mood
  final int selectedMoodIndex;
  // List of mood data containing additional details
  final List<Map<String, dynamic>> moodData;
  // Text for the journal entry
  final String journalText;

  MoodEntrySaved({
    required this.selectedMoodIndex,
    required this.moodData,
    required this.journalText,
  });
}
