import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umore_mood_tracker/features/mood_stats/cubit/mood_stats_cubit.dart';
import 'package:umore_mood_tracker/features/mood_stats/widgets/pie_chart.dart';

class MoodStatsView extends StatelessWidget {
  const MoodStatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoodStatsCubit, MoodStatsState>(
      builder: (context, state) {
        final pieChartData = state.trends;

        return Scaffold(
          appBar: AppBar(title: const Text('Mood Stats')),
          body: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Your Mood Statistics'),
                const SizedBox(height: 16),
                Expanded(child: PieChartSample3(sectionsData: pieChartData)),
                // Display average mood type and score
                if (state.averageMoodType != null) ...[
                  Image.asset(state.averageMoodType!.image),
                  Text(
                    'Average Score: ${state.averageMoodScore?.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],

                // Display most frequent mood type
                if (state.mostFrequent != null) ...[
                  Image.asset(state.mostFrequent!.image),
                  Text(
                    'Most Frequent Mood: ${state.mostFrequent?.description}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
