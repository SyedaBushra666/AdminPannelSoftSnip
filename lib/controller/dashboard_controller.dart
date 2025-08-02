import 'package:admin_pannel_monotor/controller/my_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartSampleData {
  ChartSampleData({
    this.x,
    this.y,
    this.xValue,
    this.yValue,
    this.secondSeriesYValue,
    this.thirdSeriesYValue,
    this.pointColor,
    this.size,
    this.text,
    this.open,
    this.close,
    this.low,
    this.high,
    this.volume,
  });

  final dynamic x;
  final num? y;
  final dynamic xValue;
  final num? yValue;
  final num? secondSeriesYValue;
  final num? thirdSeriesYValue;
  final Color? pointColor;
  final num? size;
  final String? text;
  final num? open;
  final num? close;
  final num? low;
  final num? high;
  final num? volume;
}

class DashboardController extends MyController {
  DashboardController();

  String selectedTimeOnPage = "Year";
  String selectedTimeByLocation = "Year";
  String selectedTimeDesign = "Year";
  String selectedTimeLatency = "Year";

  final List<ChartSampleData> revenueChart1 = [
    ChartSampleData(x: 'Mon', y: 0),
    ChartSampleData(x: 'Tue', y: 30),
    ChartSampleData(x: 'Wed', y: 35),
    ChartSampleData(x: 'The', y: 30),
    ChartSampleData(x: 'Fri', y: 45),
    ChartSampleData(x: 'Sat', y: 40),
    ChartSampleData(x: 'Sun', y: 55),
  ];

  final List<ChartSampleData> revenueChart2 = [
    ChartSampleData(x: 'Mon', y: 10),
    ChartSampleData(x: 'Tue', y: 50),
    ChartSampleData(x: 'Wed', y: 30),
    ChartSampleData(x: 'The', y: 20),
    ChartSampleData(x: 'Fri', y: 35),
    ChartSampleData(x: 'Sat', y: 30),
    ChartSampleData(x: 'Sun', y: 45),
  ];

  final TooltipBehavior revenue = TooltipBehavior(
    enable: true,
    tooltipPosition: TooltipPosition.pointer,
    format: 'point.x : point.y',
  );


final List<Map<String, String>> dashboard = [
  {
    "value": "A",
    "sum": "100",
    "metric": "Clicks",
    "tag": "Marketing",
  },
  {
    "value": "B",
    "sum": "200",
    "metric": "Views",
    "tag": "Analytics",
  },
  {
    "value": "C",
    "sum": "300",
    "metric": "Revenue",
    "tag": "Sales",
  },
];

  final List<ChartSampleData> chartData = [
    ChartSampleData(x: "Mon\nJul 22", y: 6, yValue: 3200),
  ChartSampleData(x: "Tue\nJul 23", y: 7, yValue: 4000),
  ChartSampleData(x: "Wed\nJul 24", y: 4.5, yValue: 2900),
  ChartSampleData(x: "Thu\nJul 25", y: 8, yValue: 5000),
  ChartSampleData(x: "Fri\nJul 26", y: 6.5, yValue: 4500),
  ChartSampleData(x: "Sat\nJul 27", y: 3, yValue: 1500),
  ChartSampleData(x: "Sun\nJul 28", y: 0, yValue: 0),

  ];


  final TooltipBehavior chart = TooltipBehavior(
    enable: true,
    format: 'point.x : point.yValue1 : point.yValue2',
  );

  final List<ChartSampleData> facebookChart = [
    ChartSampleData(x: 1, y: 35),
    ChartSampleData(x: 2, y: 23),
    ChartSampleData(x: 3, y: 34),
    ChartSampleData(x: 4, y: 25),
    ChartSampleData(x: 5, y: 40),
    ChartSampleData(x: 6, y: 35),
    ChartSampleData(x: 7, y: 30),
    ChartSampleData(x: 8, y: 25),
    ChartSampleData(x: 9, y: 30),
  ];

  final TooltipBehavior facebook = TooltipBehavior(
    enable: true,
    tooltipPosition: TooltipPosition.pointer,
    format: 'point.x : point.y',
  );

  final List<ChartSampleData> circleChart = [
    ChartSampleData(
        x: 'David', y: 25, pointColor: const Color.fromRGBO(9, 0, 136, 1)),
    ChartSampleData(
        x: 'Steve', y: 38, pointColor: const Color.fromRGBO(147, 0, 119, 1)),
    ChartSampleData(
        x: 'Jack', y: 34, pointColor: const Color.fromRGBO(228, 0, 124, 1)),
    ChartSampleData(
        x: 'Others', y: 52, pointColor: const Color.fromRGBO(255, 189, 57, 1)),
  ];

  void onSelectedTime(String time) {
    selectedTimeOnPage = time;
    update();
  }

  void onSelectedTimeByLocation(String time) {
    selectedTimeByLocation = time;
    update();
  }

  void onSelectedTimeDesign(String time) {
    selectedTimeDesign = time;
    update();
  }

  void onSelectedTimeLatency(String time) {
    selectedTimeLatency = time;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    // No model or dummy list now
  }

  void goToProducts() {
    Get.toNamed('/apps/ecommerce/products');
  }

  void goToCustomers() {
    Get.toNamed('/apps/ecommerce/customers');
  }
}
