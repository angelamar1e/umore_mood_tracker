import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mood_entry_state.dart';

class MoodEntryCubit extends Cubit<MoodEntryState> {
  MoodEntryCubit() : super(MoodEntryInitial());

  // Controller for journal text input
  final TextEditingController journalController = TextEditingController();

  // List of predefined mood data with type, image, name, and description
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

  // Initializes the mood entry process with default values
  void initMoodEntry() {
    emit(MoodEntryInProgress(selectedMoodIndex: -1, moodData: moodData));
  }

  // Updates the selected mood index
  void selectMood(int index) {
    if (state is MoodEntryInProgress) {
      emit((state as MoodEntryInProgress).copyWith(selectedMoodIndex: index));
    } else {
      emit(MoodEntryInProgress(selectedMoodIndex: index, moodData: moodData));
    }
  }

  // Completes the mood selection and transitions to the next state
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

  // Adds journal text to the current state
  void addJournalText(String text) {
    if (state is MoodEntryComplete) {
      emit((state as MoodEntryComplete).copyWith(journalText: text));
    }
  }

  // Saves the mood entry (placeholder for database implementation)
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

  // Retrieves the selected mood type based on the current state
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

  // Reverts back to the mood selection state
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
