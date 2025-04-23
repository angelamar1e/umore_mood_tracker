import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mood_entry_state.dart';

class MoodEntryCubit extends Cubit<MoodEntryState> {
  MoodEntryCubit() : super(MoodEntryInitial());
}
