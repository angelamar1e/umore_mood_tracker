import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umore_mood_tracker/features/mood_entry/cubit/mood_entry_cubit.dart';
import 'package:umore_mood_tracker/shared/constants/mood_types.dart';

// Widget for selecting a mood with visual feedback
class MoodSelection extends StatelessWidget {
  const MoodSelection(this.cubit, {super.key, required this.selectedIndex});

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
                    moodTypes[selectedIndex]
                        .description, // Display mood description
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
  const JournalEntry(this.context, {super.key, required this.selectedIndex});

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
          moodTypes[selectedIndex]
              .description, // Display selected mood description
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
              hintText: 'What made you feel this way?',
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
                (text) => cubit.addNotes(text), // Update journal text in cubit
          ),
        ),
      ],
    );
  }
}