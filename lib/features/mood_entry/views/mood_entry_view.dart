import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:umore_mood_tracker/features/mood_entry/cubit/mood_entry_cubit.dart';
import 'package:umore_mood_tracker/features/mood_entry/widgets/mood_entry_widgets.dart';
import 'package:umore_mood_tracker/shared/widgets/widgets.dart';

class MoodEntryView extends StatelessWidget {
  const MoodEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoodEntryCubit, MoodEntryState>(
      builder: (context, state) {
        final cubit = context.read<MoodEntryCubit>();

        final bool isFirstStep =
            state.status == MoodEntryStatus.inMoodSelection;

        int selectedIndex = state.selectedMood;

        if (state.status == MoodEntryStatus.completed) {
          Future.delayed(const Duration(seconds: 1), () {
            if (context.mounted) {
              // Check if still mounted before using context
              context.goNamed('home'); // Navigate to mood stats screen
            }
          });

          return SuccessScreen();
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
                    const SizedBox(height: 16),
                    Expanded(
                      child:
                          isFirstStep
                              ? MoodSelection(
                                cubit,
                                selectedIndex: selectedIndex,
                              )
                              : JournalEntry(
                                context,
                                selectedIndex: selectedIndex,
                              ),
                    ),
                    SizedBox(height: 16),
                    if (isFirstStep && selectedIndex != -1)
                      NextButton(cubit: cubit)
                    else if (!isFirstStep)
                      Column(
                        children: [
                          ReturnButton(cubit: cubit),
                          const SizedBox(height: 8),
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
