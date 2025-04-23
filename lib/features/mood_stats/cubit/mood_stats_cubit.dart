import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'mood_stats_state.dart';

class MoodStatsCubit extends Cubit<MoodStatsState> {
  MoodStatsCubit() : super(MoodStatsInitial());
}
