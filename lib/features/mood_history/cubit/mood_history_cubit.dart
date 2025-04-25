import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umore_mood_tracker/features/mood_entry/models/mood.dart';
import 'package:umore_mood_tracker/features/mood_history/models/full_entry.dart';
import 'package:umore_mood_tracker/shared/constants/mood_types.dart';
import 'package:umore_mood_tracker/shared/database/database_helper.dart';

part 'mood_history_state.dart';

class MoodHistoryCubit extends Cubit<MoodHistoryState> {
  // fetch history list from db automatically
  MoodHistoryCubit() : super(MoodHistoryInitial(historyList: [])) {
    fetchHistoryList();
  }

  // fetch history list from db, convert to mood history list which has image and desc and emit the state
  void fetchHistoryList() async {
    final historyList = await fetchHistory() ?? [];
    late final List<MoodHistoryEntry> fullHistoryList = List.empty(
      growable: true,
    );

    // get mood info from moodId and convert timestamp to proper date and time format
    for (int i = 0; i < historyList.length; i++) {
      final moodId = historyList[i].moodId;
      final timestamp = historyList[i].timestamp;
      final image = getMoodType(moodId).image;
      final description = getMoodType(moodId).description;
      final notes = historyList[i].notes;
      final formattedDate = convertTimestamp(timestamp);

      fullHistoryList.add(
        MoodHistoryEntry(
          entryId: historyList[i].entryId!,
          moodId: moodId,
          timestamp: formattedDate,
          image: image,
          description: description,
          notes: notes,
        ),
      );
    }

    emit(state.copyWith(historyList: fullHistoryList));
  }

  void deleteEntry(int entryId) async {
    // Remove the entry from the current state list
    final updatedList =
        state.historyList.where((entry) => entry.entryId != entryId).toList();
    emit(state.copyWith(historyList: updatedList));

    // Delete the entry from the database
    await delete(entryId);
  }

  // get moodtype from moodId
  Mood getMoodType(int moodId) {
    return moodTypes.where((mood) => moodTypes.indexOf(mood) == moodId).first;
  }

  // convert timestamp string to proper date and time format, long date format e.g February 1, 2023 12:00 PM
  String convertTimestamp(String timestamp) {
    final dateTime = DateTime.parse(timestamp);
    return "${dateTime.month == 1
        ? 'January'
        : dateTime.month == 2
        ? 'February'
        : dateTime.month == 3
        ? 'March'
        : dateTime.month == 4
        ? 'April'
        : dateTime.month == 5
        ? 'May'
        : dateTime.month == 6
        ? 'June'
        : dateTime.month == 7
        ? 'July'
        : dateTime.month == 8
        ? 'August'
        : dateTime.month == 9
        ? 'September'
        : dateTime.month == 10
        ? 'October'
        : dateTime.month == 11
        ? 'November'
        : 'December'} ${dateTime.day}, ${dateTime.year} ${dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12}:${dateTime.minute.toString().padLeft(2, '0')}${dateTime.hour >= 12 ? 'PM' : 'AM'}";
  }
}
