import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umore_mood_tracker/features/mood_history/cubit/mood_history_cubit.dart';
import 'package:umore_mood_tracker/shared/database/database_helper.dart';

class MoodHistoryView extends StatelessWidget {
  const MoodHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoodHistoryCubit, MoodHistoryState>(
      builder: (context, state) {
        final cubit = context.read<MoodHistoryCubit>();
        final historyList = state.historyList;

        // return a list that gets all information from the mood history list, using getMoodType to get the mood type and convertTimestamp to get the date and time

        return Scaffold(
          body: Container(
            child: Column(
              children: List.generate(
                historyList.length,
                (index) => GestureDetector(
                  onTap: () {
                    // open a dialog that displays the full mood entry details, positioned at the bottom of the screen
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                historyList[index].image,
                                width: 50,
                                height: 50,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                historyList[index].description,
                                style: TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Notes: ${historyList[index].notes}",
                                style: TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Date: ${historyList[index].timestamp}",
                                style: TextStyle(fontSize: 18),
                              ),

                              // delete button
                              const SizedBox(height: 16),

                              ElevatedButton(
                                onPressed: () {
                                  // delete the mood entry from the history list
                                  cubit.deleteEntry(historyList[index].entryId);
                                  Navigator.pop(context);
                                },
                                child: const Text("Delete"),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // get date of current mood entry
                          Text(
                            historyList[index].timestamp,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          // get image of current mood entry
                          Image.asset(
                            historyList[index].image,
                            width: 50,
                            height: 50,
                          ),
                          const SizedBox(height: 8),

                          // get desc of current mood entry
                          Text(
                            historyList[index].description,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
