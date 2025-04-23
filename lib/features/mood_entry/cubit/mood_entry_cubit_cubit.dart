import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mood_entry_cubit_state.dart';

class MoodEntryCubitCubit extends Cubit<MoodEntryCubitState> {
  MoodEntryCubitCubit() : super(MoodEntryCubitInitial());
}
