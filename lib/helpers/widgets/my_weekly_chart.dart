import 'package:admin_pannel_monotor/controller/fl_chart_controller.dart';
import 'package:admin_pannel_monotor/helpers/utils/ui_mixins.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_flex_item.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeeklyChartWidget extends StatefulWidget {
  const WeeklyChartWidget({super.key});

  @override
  State<WeeklyChartWidget> createState() => _WeeklyChartWidgetState();
}

class _WeeklyChartWidgetState extends State<WeeklyChartWidget>
    with SingleTickerProviderStateMixin, UIMixin {
  late FlChartController controller;

  @override
  void initState() {
    controller = Get.put(FlChartController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlChartController>(
      init: controller,
      builder: (controller) {
        return Column(
          children: [
             MyFlexItem(
                      sizes: "lg-6 md-12",
                      child: SizedBox(
                        height: 200,
                        child: BarChart(controller.barChartData),
                      ),
                    ),
            
          ],
        );
      },
    );
  }

  // Widget bottomTitles(double value, TitleMeta meta) {
  //   final titles = <String>['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  //   final Widget text = Text(
  //     titles[value.toInt()],
  //     style: const TextStyle(
  //       color: Color(0xff7589a2),
  //       fontWeight: FontWeight.bold,
  //       fontSize: 14,
  //     ),
  //   );

  //   return SideTitleWidget(
  //     axisSide: meta.axisSide,
  //     space: 16, // margin top
  //     child: text,
  //   );
  // }
}
// SizedBox(
            //   height: 180,
            //   child: BarChart(
            //     BarChartData(
            //       maxY: 20,
            //       barTouchData: BarTouchData(
            //         enabled: false,
            //         touchTooltipData: BarTouchTooltipData(
            //           //tooltipBgColor: Colors.transparent,
            //           tooltipPadding: EdgeInsets.zero,
            //           tooltipMargin: 0,
            //           getTooltipItem: (group, groupIndex, rod, rodIndex) {
            //             return BarTooltipItem(
            //               rod.toY.toStringAsFixed(0),
            //               const TextStyle(
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 12,
            //               ),
            //             );
            //           },
            //         ),
            //       ),
            //       titlesData: FlTitlesData(
            //         show: true,
            //         leftTitles: const AxisTitles(
            //           sideTitles: SideTitles(showTitles: false),
            //         ),
            //         rightTitles: const AxisTitles(
            //           sideTitles: SideTitles(showTitles: false),
            //         ),
            //         topTitles: const AxisTitles(
            //           sideTitles: SideTitles(showTitles: false),
            //         ),
            //         bottomTitles: AxisTitles(
            //           sideTitles: SideTitles(
            //             showTitles: true,
            //             getTitlesWidget: bottomTitles,
            //             reservedSize: 42,
            //           ),
            //         ),
            //       ),
            //       borderData: FlBorderData(show: false),
            //       gridData: const FlGridData(show: false),
            //       barGroups: controller.showingBarGroups,
            //     ),
            //   ),
            // ),