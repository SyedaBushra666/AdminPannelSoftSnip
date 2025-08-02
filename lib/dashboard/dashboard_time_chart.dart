import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class DashboardTimeChart extends StatelessWidget {
  const DashboardTimeChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace with your actual hours data
    List<int> actualHours = [32, 24, 17, 10, 17, 0, 0]; // Mon to Sun

    List<ChartSampleDataNew> data = getCurrentWeekData(actualHours);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 1),
        ),
        primaryYAxis: NumericAxis(
          majorGridLines: const MajorGridLines(width: 1),
          axisLine: const AxisLine(width: 0),
          opposedPosition: false,
        ),
        plotAreaBorderWidth: 0, // removes top and right border
        series: <CartesianSeries>[
          ColumnSeries<ChartSampleDataNew, String>(
            dataSource: data,
            xValueMapper: (item, _) => item.dayLabel,
            yValueMapper: (item, _) => item.hours,
            pointColorMapper: (item, _) => item.isToday ? Colors.pinkAccent : Colors.blue,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            name: 'Hours',
          ),
        ],
        tooltipBehavior: TooltipBehavior(enable: true),
      ),
    );
  }

  List<ChartSampleDataNew> getCurrentWeekData(List<int> hours) {
    final now = DateTime.now();
    final weekday = now.weekday; // Monday = 1
    final monday = now.subtract(Duration(days: weekday - 1));

    return List.generate(7, (index) {
      final date = monday.add(Duration(days: index));
      final label =
          '${DateFormat('EEE').format(date)}\n${DateFormat('MMM d').format(date)}';
      final isToday =
          now.day == date.day && now.month == date.month && now.year == date.year;
      return ChartSampleDataNew(label, hours[index], isToday);
    });
  }
}

class ChartSampleDataNew {
  final String dayLabel;
  final int hours;
  final bool isToday;

  ChartSampleDataNew(this.dayLabel, this.hours, this.isToday);
}
