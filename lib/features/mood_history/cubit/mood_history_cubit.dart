import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umore_mood_tracker/features/mood_entry/models/mood_entry.dart';

part 'mood_history_state.dart';

class MoodHistoryCubit extends Cubit<MoodHistoryState> {
  MoodHistoryCubit() : super(MoodHistoryInitial(historyList: List.empty()));

  //TODO: Methods - delete entry
}
