// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'mood_entry_cubit.dart';

class MoodEntryState {
  final MoodEntry recentEntry;

  MoodEntryState({required this.recentEntry});

  MoodEntryState copyWith({MoodEntry? entry}) {
    return MoodEntryState(recentEntry: entry ?? recentEntry);
  }
}

final class MoodEntryInitial extends MoodEntryState {
  MoodEntryInitial({required super.recentEntry});
}
