// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'mood_history_cubit.dart';

class MoodHistoryState {
  final List<MoodHistoryEntry> historyList;

  MoodHistoryState({required this.historyList});

  MoodHistoryState copyWith({List<MoodHistoryEntry>? historyList}) {
    return MoodHistoryState(historyList: historyList ?? this.historyList);
  }
}

final class MoodHistoryInitial extends MoodHistoryState {
  MoodHistoryInitial({required super.historyList});
}
