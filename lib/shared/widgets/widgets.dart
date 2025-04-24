import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:umore_mood_tracker/features/mood_entry/cubit/mood_entry_cubit.dart';
import 'package:umore_mood_tracker/shared/constants/mood_types.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      height: 64,
      padding: EdgeInsets.zero,
      notchMargin: 8,
      shape: CircularNotchedRectangle(),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavBarItem(0, Icons.home, "Home"),
                _buildNavBarItem(1, Icons.insights, "Stats"),
              ],
            ),
          ),

          SizedBox(width: 48),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavBarItem(2, Icons.history, "History"),
                _buildNavBarItem(3, Icons.settings, "Settings"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(int index, IconData icon, String label) {
    return FittedBox(
      child: Column(
        children: [
          IconButton(
            onPressed: () => onItemSelected(index),
            icon: Icon(icon),
            color: selectedIndex == index ? Color(0xFF4169E1) : Colors.black,
            iconSize: 28,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: selectedIndex == index ? Color(0xFF4169E1) : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for selecting a mood with visual feedback
class MoodSelection extends StatelessWidget {
  const MoodSelection(this.cubit, {
    super.key,
    required this.selectedIndex,
  });

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
                  moodTypes.length,
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
                          moodTypes[index].image, // Display mood image
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
                    moodTypes[selectedIndex].description, // Display mood description
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
  const JournalEntry(this.context, {
    super.key,
    required this.selectedIndex,
  });

  final BuildContext context; // Build context for the widget
  final int selectedIndex; // Index of the selected mood

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MoodEntryCubit>(); // Access the MoodEntryCubit

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          moodTypes[selectedIndex].image,
          width: 100,
          height: 100,
        ), // Display selected mood image
        Text(
          moodTypes[selectedIndex].description, // Display selected mood description
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        SizedBox(height: 24),
        Expanded(
          child: TextField(
            controller: cubit.notesController, // Controller for journal text
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
                    cubit.addNotes(text), // Update journal text in cubit
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
  const GetStartedButton(this.context, {super.key});

  final BuildContext context; // Build context for navigation

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MoodEntryCubit>();
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          cubit.startMoodSelection();
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
          cubit.startNoteEntry(); // Complete mood selection step, and start note entry
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
                cubit.startMoodSelection(), // Navigate back to mood selection
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
              cubit.completeMoodEntry(); // Save mood entry data
          Future.delayed(const Duration(seconds: 2), () {
            if (currentContext.mounted) {
              // Check if still mounted before using context
              currentContext.goNamed(
                'home',
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
