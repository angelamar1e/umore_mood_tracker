import 'package:flutter/material.dart';

class DayTimeline extends StatelessWidget {
  final int selectedDayIndex;
  final bool hasData;

  const DayTimeline({
    super.key,
    required this.selectedDayIndex,
    required this.hasData,
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

    return Expanded(
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        separatorBuilder: (context, index) => SizedBox(width: 8),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 100,
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
              SizedBox(height: 6),
              if (hasData) Image.asset('lib/shared/assets/images/fire.png', height: 32),
            ],
          );
        },
        padding: EdgeInsets.zero,
      ),
    );
  }
}
