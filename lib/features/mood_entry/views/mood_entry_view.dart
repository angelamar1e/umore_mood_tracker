import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umore_mood_tracker/features/mood_entry/cubit/mood_entry_cubit.dart';
import 'package:umore_mood_tracker/shared/widgets/widgets.dart';

class MoodEntryView extends StatefulWidget {
  const MoodEntryView({super.key});

  @override
  State<MoodEntryView> createState() => _MoodEntryViewState();
}

class _MoodEntryViewState extends State<MoodEntryView> {
  @override
  void initState() {
    super.initState();
    context.read<MoodEntryCubit>().initMoodEntry();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoodEntryCubit, MoodEntryState>(
      builder: (context, state) {
        final cubit = context.read<MoodEntryCubit>();

        if (state is MoodEntryInitial) {
          return Center(child: CircularProgressIndicator());
        }

        bool isFirstStep = state is MoodEntryInProgress;

        int selectedIndex = -1;
        List<Map<String, dynamic>> moodData = [];

        if (state is MoodEntryInProgress) {
          final moodEntryState = state;
          selectedIndex = moodEntryState.selectedMoodIndex;
          moodData = moodEntryState.moodData;
        } else if (state is MoodEntryComplete) {
          final moodEntryState = state;
          selectedIndex = moodEntryState.selectedMoodIndex;
          moodData = moodEntryState.moodData;
        }

        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF87CEEB), Color(0xFF4169E1)],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ProgressDotIndicator(isFirstStep: isFirstStep),
                    SizedBox(height: 16),

                    if (!isFirstStep) SizedBox(height: 16),

                    MainText(
                      text:
                          isFirstStep
                              ? 'How are you feeling today?'
                              : 'Tell us more about your mood',
                    ),

                    SizedBox(height: 6),

                    SubText(
                      text:
                          isFirstStep
                              ? 'Select an emoji that best describes your mood'
                              : 'Write your thoughts about how you\'re feeling',
                    ),

                    SizedBox(height: 16),

                    Expanded(
                      child:
                          isFirstStep
                              ? MoodSelection(
                                moodData: moodData,
                                cubit: cubit,
                                selectedIndex: selectedIndex,
                              )
                              : JournalEntry(
                                context: context,
                                selectedIndex: selectedIndex,
                                moodData: moodData,
                              ),
                    ),
                    SizedBox(height: 16),

                    if (isFirstStep && selectedIndex != -1)
                      NextButton(cubit: cubit)
                    else if (!isFirstStep)
                      Column(
                        children: [
                          ReturnButton(cubit: cubit),
                          SizedBox(height: 8),
                          FinishButton(cubit: cubit),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
