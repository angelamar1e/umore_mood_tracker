import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:umore_mood_tracker/features/mood_entry/cubit/mood_entry_cubit.dart';
import 'package:umore_mood_tracker/shared/routes/app_routes.dart';
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
    // Initialize mood entry process
    context.read<MoodEntryCubit>().initMoodEntry();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoodEntryCubit, MoodEntryState>(
      builder: (context, state) {
        final cubit = context.read<MoodEntryCubit>();

        // Success state
        if (state is MoodEntrySaved) {
          // Add navigation after a delay
          Future.delayed(const Duration(seconds: 2), () {
            context.goNamed(AppRoutes.home);
          });

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
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.check, // Use check instead of check_circle
                            color: Colors.white,
                            size: 80,
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
                      Text(
                        'Mood Entry Saved!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Returning to home...',
                        style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        // Determine if the current step is the first step
        bool isFirstStep = state is MoodEntryInProgress;

        // Variables to hold selected mood index and mood data
        int selectedIndex = -1;
        List<Map<String, dynamic>> moodData = [];

        // Extract mood data and selected index based on state
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
