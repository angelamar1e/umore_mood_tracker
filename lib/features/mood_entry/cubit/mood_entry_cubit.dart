import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umore_mood_tracker/features/mood_entry/models/mood_entry.dart';
import 'package:umore_mood_tracker/shared/database/database_helper.dart';

part 'mood_entry_state.dart';

class MoodEntryCubit extends Cubit<MoodEntryState> {
  MoodEntryCubit() : super(MoodEntryInitial());

  final TextEditingController journalController = TextEditingController();

  final List<Map<String, dynamic>> moodData = [
    {
      'type': MoodType.happy,
      'image': 'lib/shared/assets/images/happy_face.png',
      'name': 'Happy',
      'description': 'I feel great!',
    },
    {
      'type': MoodType.sad,
      'image': 'lib/shared/assets/images/sad_face.png',
      'name': 'Sad',
      'description': 'It\'s okay.',
    },
    {
      'type': MoodType.neutral,
      'image': 'lib/shared/assets/images/neutral_face.png',
      'name': 'Neutral',
      'description': 'Meh.',
    },
    {
      'type': MoodType.angry,
      'image': 'lib/shared/assets/images/angry_face.png',
      'name': 'Angry',
      'description': 'It\'s frustrating!',
    },
    {
      'type': MoodType.crying,
      'image': 'lib/shared/assets/images/crying_face.png',
      'name': 'Crying',
      'description': 'I can\'t take this!',
    },
  ];

  void initMoodEntry() {
    emit(MoodEntryInProgress(selectedMoodIndex: -1, moodData: moodData));
  }

  void selectMood(int index) {
    if (state is MoodEntryInProgress) {
      emit((state as MoodEntryInProgress).copyWith(selectedMoodIndex: index));
    } else {
      emit(MoodEntryInProgress(selectedMoodIndex: index, moodData: moodData));
    }
  }

  void completeSelectMoodEntry() {
    if (state is MoodEntryInProgress) {
      final currentState = state as MoodEntryInProgress;
      if (currentState.selectedMoodIndex >= 0) {
        emit(
          MoodEntryComplete(
            selectedMoodIndex: currentState.selectedMoodIndex,
            moodData: currentState.moodData,
            journalText: '',
          ),
        );
      }
    }
  }

  void addJournalText(String text) {
    if (state is MoodEntryComplete) {
      emit((state as MoodEntryComplete).copyWith(journalText: text));
    }
  }

  Future<void> saveMoodEntry() async {
    if (state is MoodEntryComplete) {
      final currentState = state as MoodEntryComplete;

      // FOR DATABASE IMPLEMENTATION

      // final selectedMood =
      //     currentState.moodData[currentState.selectedMoodIndex];
      // final journalText = currentState.journalText;

      emit(
        MoodEntrySaved(
          selectedMoodIndex: currentState.selectedMoodIndex,
          moodData: currentState.moodData,
          journalText: currentState.journalText,
        ),
      );
    }
  }

  MoodType? getSelectedMoodType() {
    if (state is MoodEntryInProgress) {
      final currentState = state as MoodEntryInProgress;
      if (currentState.selectedMoodIndex >= 0) {
        return currentState.moodData[currentState.selectedMoodIndex]['type']
            as MoodType;
      }
    }
    return null;
  }

  void goBackToMoodSelection() {
    if (state is MoodEntryComplete) {
      final currentState = state as MoodEntryComplete;
      emit(
        MoodEntryInProgress(
          selectedMoodIndex: currentState.selectedMoodIndex,
          moodData: currentState.moodData,
        ),
      );
    }
  }
}
