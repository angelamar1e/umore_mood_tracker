import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:umore_mood_tracker/features/mood_entry/cubit/mood_entry_cubit.dart';

// Widget for selecting a mood with visual feedback
class MoodSelection extends StatelessWidget {
  const MoodSelection({
    super.key,
    required this.moodData,
    required this.cubit,
    required this.selectedIndex,
  });

  final List<Map<String, dynamic>>
  moodData; // List of mood data containing image and description
  final MoodEntryCubit cubit; // Cubit to manage mood selection state
  final int selectedIndex; // Index of the currently selected mood

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            FittedBox(
              child: Row(
                children: List.generate(
                  moodData.length,
                  (index) => GestureDetector(
                    onTap: () {
                      cubit.selectMood(index); // Update selected mood index
                    },
                    child: Opacity(
                      opacity:
                          selectedIndex == index
                              ? 1.0
                              : 0.5, // Highlight selected mood
                      child: Transform.scale(
                        scale:
                            selectedIndex == index
                                ? 1.5
                                : 1.0, // Scale selected mood
                        child: Image.asset(
                          moodData[index]['image'], // Display mood image
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            if (selectedIndex != -1)
              Column(
                children: [
                  Text(
                    moodData[selectedIndex]['description'], // Display mood description
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}

// Widget for entering a journal entry related to the selected mood
class JournalEntry extends StatelessWidget {
  const JournalEntry({
    super.key,
    required this.context,
    required this.selectedIndex,
    required this.moodData,
  });

  final BuildContext context; // Build context for the widget
  final int selectedIndex; // Index of the selected mood
  final List<Map<String, dynamic>> moodData; // List of mood data

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MoodEntryCubit>(); // Access the MoodEntryCubit

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          moodData[selectedIndex]['image'],
          width: 100,
          height: 100,
        ), // Display selected mood image
        Text(
          '${moodData[selectedIndex]['description']}', // Display selected mood description
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        SizedBox(height: 24),
        Expanded(
          child: TextField(
            controller: cubit.journalController, // Controller for journal text
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              hintText: 'What made you feel this way?', // Placeholder text
              hintStyle: TextStyle(color: Colors.grey[800]),
              fillColor: Colors.white.withAlpha((0.2 * 255).toInt()),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.all(16),
            ),
            style: TextStyle(color: Colors.black),
            keyboardType: TextInputType.multiline,
            onChanged:
                (text) =>
                    cubit.addJournalText(text), // Update journal text in cubit
          ),
        ),
      ],
    );
  }
}

// Widget to display progress indicators for mood entry steps
class ProgressDotIndicator extends StatelessWidget {
  const ProgressDotIndicator({super.key, required this.isFirstStep});

  final bool isFirstStep; // Indicates if the current step is the first step

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 2; i++)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              color:
                  i == (isFirstStep ? 0 : 1)
                      ? Colors
                          .white // Highlight current step
                      : Colors.white.withAlpha((0.4 * 255).toInt()),
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }
}

// Button to navigate to the mood entry screen
class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key, required this.context});

  final BuildContext context; // Build context for navigation

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          context.goNamed('mood-entry'); // Navigate to mood entry screen
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text(
          'Get started',
          style: TextStyle(fontSize: 18, color: Color(0xFF4169E1)),
        ),
      ),
    );
  }
}

// Button to proceed to the next step in mood entry
class NextButton extends StatelessWidget {
  const NextButton({super.key, required this.cubit});

  final MoodEntryCubit cubit; // Cubit to manage mood entry state

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          cubit.completeSelectMoodEntry(); // Complete mood selection step
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text(
          'Next',
          style: TextStyle(fontSize: 18, color: Color(0xFF4169E1)),
        ),
      ),
    );
  }
}

// Button to return to the previous step in mood entry
class ReturnButton extends StatelessWidget {
  const ReturnButton({super.key, required this.cubit});

  final MoodEntryCubit cubit; // Cubit to manage navigation state

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed:
            () =>
                cubit
                    .goBackToMoodSelection(), // Navigate back to mood selection
        icon: Icon(Icons.arrow_back_ios_new, size: 18),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14),
          side: BorderSide(width: 1, color: Colors.white),
          foregroundColor: Colors.white,
        ),
        label: Text('Back', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

// Button to finish mood entry and save the data
class FinishButton extends StatelessWidget {
  const FinishButton({super.key, required this.cubit});

  final MoodEntryCubit cubit; // Cubit to manage saving mood entry

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final BuildContext currentContext =
              context; // Capture context before async gap
          await cubit.saveMoodEntry(); // Save mood entry data
          Future.delayed(const Duration(seconds: 2), () {
            if (currentContext.mounted) {
              // Check if still mounted before using context
              currentContext.goNamed(
                'mood-stats',
              ); // Navigate to mood stats screen
            }
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text(
          'Finish',
          style: TextStyle(fontSize: 18, color: Color(0xFF4169E1)),
        ),
      ),
    );
  }
}

// Widget to display main text with bold styling
class MainText extends StatelessWidget {
  final String text; // Text to display

  const MainText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}

// Widget to display subtext with smaller font size
class SubText extends StatelessWidget {
  final String text; // Text to display

  const SubText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 14, color: Colors.grey[800]),
    );
  }
}
