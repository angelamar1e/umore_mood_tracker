import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umore_mood_tracker/features/mood_stats/cubit/mood_stats_cubit.dart';
import 'package:umore_mood_tracker/features/mood_stats/widgets/mood_stats_widgets.dart';
import 'package:umore_mood_tracker/features/mood_stats/widgets/pie_chart.dart';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const MainText(
                text: 'Your Mood Statistics',
                textAlign: TextAlign.start,
              ),
              pieChartData.isEmpty
                  ? const Center(
                    child: MainText(
                      text:
                          'No mood data available yet.\nAdd some entries to see statistics!',
                      textAlign: TextAlign.center,
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  )
                  : SizedBox(
                    child: PieChartSample3(sectionsData: pieChartData),
                  ),
              // Display average mood type and score
              Row(
                children: [
                  if (state.averageMoodType != null) ...[
                    StatsCard(
                      cardTitle: 'Average Mood Score',
                      imageState: state.averageMoodType!.image,
                      textState:
                          '${state.averageMoodScore?.toStringAsFixed(2)}',
                    ),
                  ],
                  const SizedBox(width: 20),
                  if (state.mostFrequent != null) ...[
                    StatsCard(
                      cardTitle: 'Most Frequent Mood',
                      imageState: state.mostFrequent!.image,
                      textState: '${state.mostFrequent?.description}',
                    ),
                  ],
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

