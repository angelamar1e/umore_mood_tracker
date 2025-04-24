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
                (text) =>
                    cubit.addJournalText(text), // Update journal text in cubit
          ),
        ),
      ],
    );
  }
}

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
}

class DayTimeline extends StatelessWidget {
  final int selectedDayIndex;
  final Function(int) onDaySelected;

  const DayTimeline({
    super.key,
    required this.selectedDayIndex,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final days = List.generate(7, (index) {
      final day = now.add(Duration(days: index));
      return {
        'name':
            ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][day.weekday - 1],
        'number': day.day.toString(),
      };
    });

    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        separatorBuilder: (context, index) => SizedBox(width: 8),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onDaySelected(index),
            child: Container(
              width: 60,
              decoration: BoxDecoration(
                color:
                    selectedDayIndex == index
                        ? Color(0xFF4169E1)
                        : Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    days[index]['name']!,
                    style: TextStyle(
                      color:
                          selectedDayIndex == index
                              ? Colors.white
                              : Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    days[index]['number']!,
                    style: TextStyle(
                      color:
                          selectedDayIndex == index
                              ? Colors.white
                              : Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        padding: EdgeInsets.zero,
      ),
    );
  }
}

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

// Button to navigate to the home screen
class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key, required this.route});

  final String route;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          context.goNamed(route);
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

  final MoodEntryCubit cubit;

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

  final MoodEntryCubit cubit;

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

  final MoodEntryCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          await cubit.saveMoodEntry(); // Save mood entry data
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
  final String text;

  const MainText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
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
    return Text(text, style: TextStyle(fontSize: 14, color: Colors.grey[800]));
  }
}
