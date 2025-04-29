import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umore_mood_tracker/features/mood_entry/models/mood_entry.dart';
import 'package:umore_mood_tracker/features/mood_history/cubit/mood_history_cubit.dart';
import 'package:umore_mood_tracker/features/mood_history/widgets/mood_history_widgets.dart';

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

        return MainLayout(
          currentIndex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const MainText(text: 'History', textAlign: TextAlign.start),
              Expanded(
                child: ListView.builder(
                  itemCount: historyList.length,
                  itemBuilder:
                      (context, index) => GestureDetector(
                        onTap: () {
                          showMoodDetails(context, historyList, index, cubit);
                        },
                        child: MoodEntries(moodEntry: historyList[index]),
                      ),
                ),
              ),
            ],
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
            color: Colors.white,
            width: 320,
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          moodTypes[historyList[index].moodId].image,
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MainText(
                                text:
                                    moodTypes[historyList[index].moodId]
                                        .description,
                                        color: Colors.black,
                              ),
                              const SizedBox(height: 4),
                              SubText(
                                text: historyList[index].timestamp,
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SubText(
                      text:
                          historyList[index].notes.isEmpty
                              ? "No notes"
                              : historyList[index].notes,
                      fontSize: 18,
                      color: Colors.black,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomElevatedButton(
                        onPressed: () {
                          cubit.deleteEntry(historyList[index].entryId!);
                          Navigator.pop(context);
                        },
                        backgroundColor: Colors.red,
                        text: 'Delete',
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      size: 24,
                      color: Colors.black,
                    ),
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
