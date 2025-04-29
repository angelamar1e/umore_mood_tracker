import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:umore_mood_tracker/features/mood_entry/cubit/mood_entry_cubit.dart';
import 'package:umore_mood_tracker/features/mood_entry/widgets/mood_entry_widgets.dart';
import 'package:umore_mood_tracker/shared/widgets/main_layout.dart';
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
          Future.delayed(const Duration(seconds: 2), () {
            if (context.mounted) {
              context.goNamed('home');
            }
          });

          return SuccessScreen();
        }

        return MainLayout(
          showNavBar: false,
          showFab: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProgressDotIndicator(isFirstStep: isFirstStep),
              SizedBox(height: 16),
              MainText(
                text:
                    isFirstStep
                        ? 'How are you feeling today?'
                        : 'Tell us more about your mood',
                color: Colors.white,
              ),
              SizedBox(height: 6),
              SubText(
                text:
                    isFirstStep
                        ? 'Select an emoji that best describes your mood'
                        : 'Write your thoughts about how you\'re feeling',
                color: Colors.white60,
              ),
              const SizedBox(height: 16),
              Expanded(
                child:
                    isFirstStep
                        ? MoodSelection(cubit, selectedIndex: selectedIndex)
                        : JournalEntry(context, selectedIndex: selectedIndex),
              ),
              SizedBox(height: 16),
              if (isFirstStep && selectedIndex != -1)
                CustomElevatedButton(
                  onPressed: () => cubit.startNoteEntry(),
                  text: 'Next',
                  backgroundColor: Colors.white,
                )
              else if (!isFirstStep)
                Column(
                  children: [
                    CustomOutlinedButton(
                      onPressed: () => cubit.startMoodSelection(),
                      text: 'Back',
                      icon: Icon(Icons.arrow_back_ios_new, size: 18),
                      borderColor: Colors.white,
                      textColor: Colors.white,
                      foregroundColor: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    CustomElevatedButton(
                      onPressed: () => cubit.completeMoodEntry(),
                      text: 'Finish',
                      backgroundColor: Colors.white,
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
