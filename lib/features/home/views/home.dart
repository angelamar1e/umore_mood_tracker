import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:umore_mood_tracker/shared/widgets/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name = "Name";
  int _selectedIndex = 0;
  int _selectedDayIndex = 0;

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
        child: Center(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MainText(text: "Hello, $name!"),

                  SizedBox(height: 24),

                  // Day selector
                  DayTimeline(
                    selectedDayIndex: _selectedDayIndex,
                    onDaySelected: (index) {
                      setState(() => _selectedDayIndex = index);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              context.goNamed('mood-entry');
            },
            backgroundColor: Colors.white,
            foregroundColor: Color(0xFF4169E1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Icon(Icons.add),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }
}
