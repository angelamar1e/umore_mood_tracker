// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'mood_entry_cubit.dart';

enum MoodEntryStatus { initial, inMoodSelection, inNoteEntry, completed}

class MoodEntryState {
  final MoodEntryStatus status;
  final int selectedMood;
  final String notes;

  MoodEntryState({ required this.status,
    required this.selectedMood,
    required this.notes,
  });

  MoodEntryState copyWith({
    MoodEntryStatus? status,
    int? selectedMood,
    String? notes,
  }) {
    return MoodEntryState(
      status: status ?? this.status,
      selectedMood: selectedMood ?? this.selectedMood,
      notes: notes ?? this.notes,
    );
  }
}
