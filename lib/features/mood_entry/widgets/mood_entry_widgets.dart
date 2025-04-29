import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umore_mood_tracker/features/mood_entry/cubit/mood_entry_cubit.dart';
import 'package:umore_mood_tracker/shared/constants/mood_types.dart';

// Widget for selecting a mood with visual feedback
class MoodSelection extends StatelessWidget {
  const MoodSelection(this.cubit, {super.key, required this.selectedIndex});

  final MoodEntryCubit cubit;
  final int selectedIndex;

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
                      cubit.selectMood(index);
                    },
                    child: Opacity(
                      opacity: selectedIndex == index ? 1.0 : 0.5,
                      child: Transform.scale(
                        scale: selectedIndex == index ? 1.5 : 1.0,
                        child: Image.asset(
                          moodTypes[index].image,
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
                    moodTypes[selectedIndex].description,
                    style: TextStyle(fontSize: 18, color: Colors.white),
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

class JournalEntry extends StatelessWidget {
  const JournalEntry(this.context, {super.key, required this.selectedIndex});

  final BuildContext context;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MoodEntryCubit>();

    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              moodTypes[selectedIndex].image,
              width: 100,
              height: 100,
            ),
            Text(
              moodTypes[selectedIndex].description,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 24),
            SizedBox(
              height: 100,
              child: TextField(
                controller: cubit.notesController,
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
                onChanged: (text) => cubit.addNotes(text),
              ),
            ),
            SizedBox(height: 20), // Add bottom padding
          ],
        ),
      ),
    );
  }
}
