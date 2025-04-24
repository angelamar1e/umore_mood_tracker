import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:umore_mood_tracker/features/start/start.dart';
import 'package:umore_mood_tracker/features/home/views/home.dart';
import 'package:umore_mood_tracker/features/mood_entry/cubit/mood_entry_cubit.dart';
import 'package:umore_mood_tracker/features/mood_entry/views/mood_entry_view.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'start',
      builder: (context, state) => const Start(),
      routes: [
        GoRoute(
          path: 'home',
          name: 'home',
          builder: (context, state) => const Home(),
        ),
        GoRoute(
          path: 'mood-entry',
          name: 'mood-entry',
          builder:
              (context, state) => BlocProvider(
                create: (context) => MoodEntryCubit(),
                child: const MoodEntryView(),
              ),
        ),
      ],
    ),
  ],
);
