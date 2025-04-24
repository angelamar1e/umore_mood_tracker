import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umore_mood_tracker/features/mood_entry/models/mood_entry.dart';
import 'package:umore_mood_tracker/shared/database/database_helper.dart';

part 'mood_entry_state.dart';

class MoodEntryCubit extends Cubit<MoodEntryState> {
  MoodEntryCubit()
    : super(
        MoodEntryInitial(
          recentEntry: MoodEntry(moodKey: '', notes: '', timestamp: ''),
        ),
      );

  void addEntry(MoodEntry moodEntry) {
    // emits recent entry to state
    emit(state.copyWith(entry: moodEntry));
    insertEntry(moodEntry);
  }
}
