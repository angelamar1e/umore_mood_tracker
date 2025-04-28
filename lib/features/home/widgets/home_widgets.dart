import 'package:flutter/material.dart';

class DayTimeline extends StatefulWidget {
  final bool hasData;

  const DayTimeline({super.key, required this.hasData});

  @override
  State<DayTimeline> createState() => _DayTimelineState();
}

class _DayTimelineState extends State<DayTimeline> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Scroll to today's position after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Scroll to the today's position (index 6)
      // The 68 value is the approximate width of each day card + separator
      _scrollController.animateTo(
        6 * 76.0, // Width of each card (60) + separator (8)
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final days = List.generate(14, (index) {
      final showDay = now.add(Duration(days: index - 6));
      return {
        'name':
            ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][showDay.weekday -
                1],
        'number': showDay.day.toString(),
      };
    });

    return Expanded(
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: 14,
        separatorBuilder: (context, index) => SizedBox(width: 8),
        itemBuilder: (context, index) {
          // Determine if the day is today (index 6 is today since we start 6 days before)
          final isToday = index == 6;

          return Column(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                color: isToday ? Color(0xFF4169E1) : Colors.white,
                child: SizedBox(
                  height: 100,
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        days[index]['name']!,
                        style: TextStyle(
                          color: isToday ? Colors.white : Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        days[index]['number']!,
                        style: TextStyle(
                          color: isToday ? Colors.white : Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 6),
              if (widget.hasData)
                Image.asset('lib/shared/assets/images/fire.png', height: 32),
            ],
          );
        },
        padding: EdgeInsets.zero,
      ),
    );
  }
}
