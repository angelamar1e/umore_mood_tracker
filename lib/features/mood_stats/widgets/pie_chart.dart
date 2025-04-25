import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:umore_mood_tracker/features/mood_stats/models/pie_section_data.dart';
import 'package:umore_mood_tracker/shared/theme/app_colors.dart';

class PieChartSample3 extends StatefulWidget {
  final List<PieSectionData> sectionsData;

  const PieChartSample3({super.key, required this.sectionsData});

  @override
  State<StatefulWidget> createState() => PieChartSample3State();
}

class PieChartSample3State extends State<PieChartSample3> {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: AspectRatio(
        aspectRatio: 1,
        child: PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    return;
                  }
                  touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                });
              },
            ),
            borderData: FlBorderData(show: false),
            sectionsSpace: 0,
            centerSpaceRadius: 0, // Adjusted from 0 to 40 for better rendering
            sections: showingSections(),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    final totalValue = widget.sectionsData.fold<double>(
      0,
      (sum, section) => sum + section.value,
    );

    return List.generate(widget.sectionsData.length, (i) {
      final isTouched = i == touchedIndex;
      final section = widget.sectionsData[i];
      final normalizedValue = (section.value / totalValue) * 100;

      return PieChartSectionData(
        color: section.color,
        value: normalizedValue, // Normalized value to ensure total is 100
        title: '${normalizedValue.toStringAsFixed(1)}%', // Display percentage
        badgeWidget: _Badge(
          section.image,
          size: isTouched ? 55.0 : 40.0,
          borderColor: AppColors.contentColorBlue,
        ),
        radius: isTouched ? 110.0 : 100.0,
        titleStyle: TextStyle(
          fontSize: isTouched ? 20.0 : 16.0,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
          shadows: const [Shadow(color: Colors.black, blurRadius: 2)],
        ),
        badgePositionPercentageOffset: .98,
      );
    });
  }
}

class _Badge extends StatelessWidget {
  const _Badge(this.image, {required this.size, required this.borderColor});
  final String image;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: .5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .2),
      child: Center(child: Image.asset(image, height: 50, width: 50)),
    );
  }
}
