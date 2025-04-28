import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umore_mood_tracker/features/mood_stats/cubit/mood_stats_cubit.dart';
import 'package:umore_mood_tracker/features/mood_stats/widgets/pie_chart.dart';
import 'package:umore_mood_tracker/shared/theme/app_colors.dart';
import 'package:umore_mood_tracker/shared/widgets/main_layout.dart';
import 'package:umore_mood_tracker/shared/widgets/widgets.dart';

class MoodStatsView extends StatelessWidget {
  const MoodStatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoodStatsCubit, MoodStatsState>(
      builder: (context, state) {
        final pieChartData = state.trends;

        return MainLayout(
          currentIndex: 1,
          child: Container(
            decoration: gradientBackground(),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MainText(text: 'Your Mood Statistics', color: Colors.white),
                    SizedBox(
                      child: PieChartSample3(sectionsData: pieChartData),
                    ),
                    // Display average mood type and score
                    Row(
                      children: [
                        if (state.averageMoodType != null) ...[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Average Mood Score',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Image.asset(
                                        state.averageMoodType!.image,
                                      ),
                                    ),
                                    Text(
                                      '${state.averageMoodScore?.toStringAsFixed(2)}',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(width: 20),
                        if (state.mostFrequent != null) ...[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Most Frequent Mood',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Image.asset(
                                        state.mostFrequent!.image,
                                      ),
                                    ),
                                    Text(
                                      '${state.mostFrequent?.description}',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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
