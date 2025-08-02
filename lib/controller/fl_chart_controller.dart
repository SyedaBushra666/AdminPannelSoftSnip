import 'dart:async';
import 'dart:math' as math;
import 'dart:math';
import 'package:admin_pannel_monotor/controller/my_controller.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';

class FlChartController extends MyController {
  @override
  void onInit() {
    super.onInit();
    timer = Timer.periodic(const Duration(milliseconds: 40), (timer) {
      while (sinPoints.length > limitCount) {
        sinPoints.removeAt(0);
        cosPoints.removeAt(0);
      }

      sinPoints.add(FlSpot(xValue, math.sin(xValue)));
      cosPoints.add(FlSpot(xValue, math.cos(xValue)));
      update();
      xValue += step;
    });

    /// Bar Chart 1

    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

 


  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }
  
  /// Chart 3
  final limitCount = 100;
  final sinPoints = <FlSpot>[];
  final cosPoints = <FlSpot>[];

  double xValue = 0;
  double step = 0.05;

  late Timer timer;

  LineChartBarData sinLine(List<FlSpot> points) {
    return LineChartBarData(
        spots: points,
        dotData: const FlDotData(show: false),
        gradient: LinearGradient(
            colors: [Colors.blue.withOpacity(0), Colors.blue],
            stops: const [0.1, 1.0]),
        barWidth: 4,
        isCurved: false);
  }

  LineChartBarData cosLine(List<FlSpot> points) {
    return LineChartBarData(
        spots: points,
        dotData: const FlDotData(show: false),
        gradient: LinearGradient(
            colors: [Colors.pink.withOpacity(0), Colors.pink],
            stops: const [0.1, 1.0]),
        barWidth: 4,
        isCurved: false);
  }

  /// Chart 4
  final cutOffYValue = 5.0;

  /// Bar Chart 1

  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(toY: y1, color: Colors.purple, width: width),
        BarChartRodData(toY: y2, color: Colors.redAccent, width: width),
      ],
    );
  }

  /// Bar Chart 2

  BarChartData get barChartData => BarChartData(
      barTouchData: barTouchData,
      titlesData: titlesData,
      borderData: borderBarChartData,
      barGroups: barGroups,
      gridData: const FlGridData(show: false),
      alignment: BarChartAlignment.spaceAround,
      maxY: 20);

  FlBorderData get borderBarChartData => FlBorderData(show: false);

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipPadding: EdgeInsets.all(5),
          getTooltipColor: (group) => Colors.transparent,
          
          tooltipMargin: 8,
            
                    getTooltipItem: (BarChartGroupData group, int groupIndex,
              BarChartRodData rod, int rodIndex) {
            return BarTooltipItem(
          

              rod.toY.round().toString(),
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            );
          },
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true, reservedSize: 30, getTitlesWidget: getTitles),
        ),
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mon';
        break;
      case 1:
        text = 'Tue';
        break;
      case 2:
        text = 'Wed';
        break;
      case 3:
        text = 'Thu';
        break;
      case 4:
        text = 'Fri';
        break;
      case 5:
        text = 'Sat';
        break;
      case 6:
        text = 'Sun';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
        axisSide: meta.axisSide, space: 4, child: Text(text, style: style));
  }

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
            x: 0,
            barRods: [BarChartRodData(toY: 8, gradient: _barsGradient)],
            showingTooltipIndicators: [0]),
        BarChartGroupData(
            x: 1,
            barRods: [BarChartRodData(toY: 10, gradient: _barsGradient)],
            showingTooltipIndicators: [0]),
        BarChartGroupData(
            x: 2,
            barRods: [BarChartRodData(toY: 14, gradient: _barsGradient)],
            showingTooltipIndicators: [0]),
        BarChartGroupData(
            x: 3,
            barRods: [BarChartRodData(toY: 15, gradient: _barsGradient)],
            showingTooltipIndicators: [0]),
        BarChartGroupData(
            x: 4,
            barRods: [BarChartRodData(toY: 13, gradient: _barsGradient)],
            showingTooltipIndicators: [0]),
        BarChartGroupData(
            x: 5,
            barRods: [BarChartRodData(toY: 10, gradient: _barsGradient)],
            showingTooltipIndicators: [0]),
        BarChartGroupData(
            x: 6,
            barRods: [BarChartRodData(toY: 0, gradient: _barsGradient)],
            showingTooltipIndicators: [0]),
      ];

  LinearGradient get _barsGradient => LinearGradient(
      colors: [Colors.blue.shade800, Colors.cyan],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter);



  
  



}
