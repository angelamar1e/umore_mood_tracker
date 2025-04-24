import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:umore_mood_tracker/features/mood_entry/cubit/mood_entry_cubit.dart';

class MoodSelection extends StatelessWidget {
  const MoodSelection({
    super.key,
    required this.moodData,
    required this.cubit,
    required this.selectedIndex,
  });

  final List<Map<String, dynamic>> moodData;
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
                  moodData.length,
                  (index) => GestureDetector(
                    onTap: () {
                      cubit.selectMood(index);
                    },
                    child: Opacity(
                      opacity: selectedIndex == index ? 1.0 : 0.5,
                      child: Transform.scale(
                        scale: selectedIndex == index ? 1.5 : 1.0,
                        child: Image.asset(
                          moodData[index]['image'],
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
                    moodData[selectedIndex]['description'],
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

class JournalEntry extends StatelessWidget {
  const JournalEntry({
    super.key,
    required this.context,
    required this.selectedIndex,
    required this.moodData,
  });

  final BuildContext context;
  final int selectedIndex;
  final List<Map<String, dynamic>> moodData;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MoodEntryCubit>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(moodData[selectedIndex]['image'], width: 100, height: 100),
        Text(
          '${moodData[selectedIndex]['description']}',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        SizedBox(height: 24),
        Expanded(
          child: TextField(
            controller: cubit.journalController,
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
            onChanged: (text) => cubit.addJournalText(text),
          ),
        ),
      ],
    );
  }
}

class ProgressDotIndicator extends StatelessWidget {
  const ProgressDotIndicator({super.key, required this.isFirstStep});

  final bool isFirstStep;

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
                      ? Colors.white
                      : Colors.white.withAlpha((0.4 * 255).toInt()),
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }
}

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key, required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          context.goNamed('mood-entry');
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

class NextButton extends StatelessWidget {
  const NextButton({super.key, required this.cubit});

  final MoodEntryCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          cubit.completeSelectMoodEntry();
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

class ReturnButton extends StatelessWidget {
  const ReturnButton({super.key, required this.cubit});

  final MoodEntryCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => cubit.goBackToMoodSelection(),
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

class FinishButton extends StatelessWidget {
  const FinishButton({super.key, required this.cubit});

  final MoodEntryCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          await cubit.saveMoodEntry();
          Future.delayed(const Duration(seconds: 2), () {
            context.goNamed('mood-stats');
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

class MainText extends StatelessWidget {
  final String text;

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

class SubText extends StatelessWidget {
  final String text;

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
