// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'mood_entry_cubit.dart';

class MoodEntryState {
  final MoodEntry entry;

  MoodEntryState({required this.entry});

  MoodEntryState copyWith({MoodEntry? entry}) {
    return MoodEntryState(entry: entry ?? this.entry);
  }
}

final class MoodEntryInitial extends MoodEntryState {
  MoodEntryInitial({required super.entry});
}
