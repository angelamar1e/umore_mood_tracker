import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umore_mood_tracker/features/mood_entry/models/mood_entry.dart';
import 'package:umore_mood_tracker/shared/database/database_helper.dart';

part 'mood_entry_state.dart';

class MoodEntryCubit extends Cubit<MoodEntryState> {
  MoodEntryCubit()
    : super(
        MoodEntryState(
          status: MoodEntryStatus.inMoodSelection,
          selectedMood: -1,
          notes: '',
        ),
      );

  final TextEditingController notesController = TextEditingController();

  void startMoodSelection() {
    emit(state.copyWith(status: MoodEntryStatus.inMoodSelection));
  }

  void startNoteEntry() {
    emit(state.copyWith(status: MoodEntryStatus.inNoteEntry));
  }

  void completeMoodEntry() {
    storeEntry();
    emit(state.copyWith(status: MoodEntryStatus.completed));
  }

  void selectMood(int index) {
    emit(state.copyWith(selectedMood: index));
  }

  void addNotes(String text) {
    emit(state.copyWith(notes: text));
  }

  void storeEntry() async {
    final int moodId = state.selectedMood;
    final String notes = state.notes;
    final String timestamp = DateTime.now().toString();

    // inserts to db table
    await insertEntry(
      MoodEntry(
        entryId: null,
        moodId: moodId,
        notes: notes,
        timestamp: timestamp,
      ),
    );
  }
}
