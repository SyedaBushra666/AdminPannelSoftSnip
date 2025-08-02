import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_container.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_flex.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_flex_item.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_spacing.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';

// Replace with your actual model if different
class ChartSampleData {
  final String x;
  final int y;
  final int yValue;

  ChartSampleData({
    required this.x,
    required this.y,
    required this.yValue,
  });
}

class ChartWithAnimation extends StatelessWidget {
  final List<ChartSampleData> chartData;
  final TooltipBehavior tooltipBehavior;
  final double flexSpacing;

  const ChartWithAnimation({
    super.key,
    required this.chartData,
    required this.tooltipBehavior,
    this.flexSpacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MySpacing.horizontal(flexSpacing),
      child: MyFlex(
        children: [
          MyFlexItem(
            sizes: "lg-7",
            child: MyContainer(
              child: Column(
                children: [
                  MyText.titleMedium("Animation delay"),
                  MySpacing.height(flexSpacing),
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    tooltipBehavior: tooltipBehavior,
                    axes: <ChartAxis>[
                      NumericAxis(
                        numberFormat: NumberFormat.compact(),
                        majorGridLines: const MajorGridLines(width: 0),
                        opposedPosition: true,
                        name: 'yAxis1',
                        interval: 1000,
                        minimum: 0,
                        maximum: 7000,
                      )
                    ],
                    series: [
                      ColumnSeries<ChartSampleData, String>(
                        color: Colors.blue,
                        animationDuration: 2000,
                        dataSource: chartData,
                        xValueMapper: (ChartSampleData data, _) => data.x,
                        yValueMapper: (ChartSampleData data, _) => data.y,
                        name: 'Unit Sold',
                      ),
                      LineSeries<ChartSampleData, String>(
                        animationDuration: 4500,
                        animationDelay: 2000,
                        dataSource: chartData,
                        xValueMapper: (ChartSampleData data, _) => data.x,
                        yValueMapper: (ChartSampleData data, _) => data.yValue,
                        yAxisName: 'yAxis1',
                        markerSettings: const MarkerSettings(isVisible: true),
                        name: 'Total Transaction',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
