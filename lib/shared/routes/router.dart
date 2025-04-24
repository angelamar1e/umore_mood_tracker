import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:umore_mood_tracker/features/home/views/home.dart';
import 'package:umore_mood_tracker/features/mood_entry/cubit/mood_entry_cubit.dart';
import 'package:umore_mood_tracker/features/mood_entry/views/mood_entry_view.dart';
import 'package:umore_mood_tracker/features/mood_stats/views/mood_stats_view.dart';
import 'package:umore_mood_tracker/features/start/start.dart';
import 'package:umore_mood_tracker/shared/routes/app_routes.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    // Start page as a separate route
    GoRoute(
      path: '/',
      name: AppRoutes.start,
      builder: (context, state) => const Start(),
    ),

    // Home and other content pages under a separate root
    GoRoute(
      path: '/home',
      name: AppRoutes.home,
      builder: (context, state) => const Home(),
      routes: [
        GoRoute(
          path: 'mood-entry',
          name: AppRoutes.moodEntry,
          builder:
              (context, state) => BlocProvider(
                create: (context) => MoodEntryCubit(),
                child: const MoodEntryView(),
              ),
        ),
        GoRoute(
          path: 'mood-stats',
          name: AppRoutes.moodStats,
          builder: (context, state) => const MoodStatsView(),
        ),
      ],
    ),
  ],
);
