import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'mood_history_state.dart';

class MoodHistoryCubit extends Cubit<MoodHistoryState> {
  MoodHistoryCubit() : super(MoodHistoryInitial());
}
