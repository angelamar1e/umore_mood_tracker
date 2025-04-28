import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umore_mood_tracker/features/mood_entry/models/mood_entry.dart';
import 'package:umore_mood_tracker/features/mood_history/cubit/mood_history_cubit.dart';

import 'package:umore_mood_tracker/shared/constants/mood_types.dart';
import 'package:umore_mood_tracker/shared/widgets/main_layout.dart';
import 'package:umore_mood_tracker/shared/widgets/widgets.dart';

class MoodHistoryView extends StatelessWidget {
  const MoodHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoodHistoryCubit, MoodHistoryState>(
      builder: (context, state) {
        final cubit = context.read<MoodHistoryCubit>();
        final historyList = state.historyList;

        // return a list that gets all information from the mood history list, using getMoodType to get the mood type and convertTimestamp to get the date and time

        return MainLayout(
          currentIndex: 2,
          child: ListView.builder(
            itemCount: historyList.length,
            itemBuilder:
                (context, index) => GestureDetector(
                  onTap: () {
                    // Show a dialog in the center of the screen with mood entry details
                    showMoodDetails(context, historyList, index, cubit);
                  },
                  child: MoodEntries(historyList: historyList),
                ),
          ),
        );
      },
    );
  }

  Future<dynamic> showMoodDetails(
    BuildContext context,
    List<MoodEntry> historyList,
    int index,
    MoodHistoryCubit cubit,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: 320, // Fixed width for square appearance
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Close button in top-right corner
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      size: 24,
                      color: Colors.grey,
                    ),
                  ),
                ),
                // Row with image and mood description + timestamp
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Mood image
                    Image.asset(
                      moodTypes[historyList[index].moodId].image,
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(width: 16),
                    // Column with mood description and timestamp
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Mood description
                          Text(
                            moodTypes[historyList[index].moodId].description,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Timestamp
                          Text(
                            historyList[index].timestamp,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Notes with ellipsis when too long
                Text(
                  historyList[index].notes.isEmpty
                      ? "No notes"
                      : historyList[index].notes,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                // Delete button - align to the right
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomElevatedButton(
                    onPressed: () {
                      // delete the mood entry from the history list
                      cubit.deleteEntry(historyList[index].entryId!);
                      Navigator.pop(context);
                    },
                    backgroundColor: Colors.red,
                    textStyle: TextStyle(fontSize: 16, color: Colors.white),
                    text: 'Delete',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MoodEntries extends StatelessWidget {
  const MoodEntries({super.key, required this.historyList});

  final List<MoodEntry> historyList;

  @override
  Widget build(BuildContext context) {
    int? index;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Container(
        height: 120, // Fixed height for all cards
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row with image and mood description + timestamp
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mood image
                Image.asset(
                  moodTypes[historyList[index!].moodId].image,
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 16),
                // Column with mood description and timestamp
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Mood description
                      Text(
                        moodTypes[historyList[index].moodId].description,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Timestamp
                      Text(
                        historyList[index].timestamp,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Notes with ellipsis when too long
            Expanded(
              child: Text(
                historyList[index].notes.isEmpty
                    ? "No notes"
                    : historyList[index].notes,
                style: const TextStyle(fontSize: 16),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
