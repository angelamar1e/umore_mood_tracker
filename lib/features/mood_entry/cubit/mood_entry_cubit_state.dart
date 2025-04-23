// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'mood_entry_cubit_cubit.dart';

class MoodEntryCubitState {
  final MoodEntry entry;

  MoodEntryCubitState({required this.entry});

  MoodEntryCubitState copyWith({MoodEntry? entry}) {
    return MoodEntryCubitState(entry: entry ?? this.entry);
  }
}
