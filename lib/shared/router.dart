import 'package:go_router/go_router.dart';
import 'package:umore_mood_tracker/features/home/views/homepage.dart';
import 'package:umore_mood_tracker/features/mood_entry/views/mood_entry_view.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const Homepage(),
      routes: [
        GoRoute(
          path: 'mood-entry',
          name: 'mood-entry',
          builder: (context, state) => const MoodEntryView(),
        ),
        // GoRoute(
        //   path: 'statistics',
        //   name: 'statistics',
        //   builder: (context, state) => const StatisticsScreen(),
        // ),
        // GoRoute(
        //   path: 'settings',
        //   name: 'settings',
        //   builder: (context, state) => const SettingsScreen(),
        // ),
      ],
    ),
  ],
);
