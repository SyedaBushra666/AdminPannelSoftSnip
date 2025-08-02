import 'package:flutter/material.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_spacing.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_table.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';

class WebUsageTable extends StatelessWidget {
  const WebUsageTable({super.key});

  @override
  Widget build(BuildContext context) {
    return MyCustomTable(
      stringHeaders: [
        "Application",
        "Project",
        "Time Spent",
        "Duration",
        "Percentage",
      ],
      rows: _appUsageList.map((data) => _buildRow(data)).toList(),
    );
  }

  List<Map<String, dynamic>> get _appUsageList => [
        {
          "icon": "assets/icons/chrome.png",
          "appName": "Google Chrome",
          "project": "SoftSnip Project",
          "timeSpent": "0:47:56",
          "duration": "12:00 am - 12:47 am",
          "percentage": 0.6,
        },
        {
          "icon": "assets/icons/youtube.png",
          "appName": "Youtube.com",
           "project": "SoftSnip Project",
          "timeSpent": "1:15:30",
          "duration": "01:00 am - 02:15 am",
          "percentage": 0.75,
        },
        {
          "icon": "assets/icons/whatsapp.png",
          "appName": "web.whatsapp.com",
           "project": "SoftSnip Project",
          "timeSpent": "0:25:10",
          "duration": "11:00 am - 11:25 am",
          "percentage": 0.3,
        },
      ];

  List<Widget> _buildRow(Map<String, dynamic> data) {
    return [
      Row(
        children: [
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue,
            ),
            child: Image.asset(
              data["icon"],
              fit: BoxFit.cover,
            ),
          ),
          MySpacing.width(5),
          MyText.bodySmall(data["appName"]),
        ],
      ),
      MyText.bodySmall(data["project"]),
      MyText.bodySmall(data["timeSpent"], color: Colors.blue),
      MyText.bodySmall(data["duration"], color: Colors.blue),
      Row(
        children: [
          MyText.bodySmall("${(data["percentage"] * 100).toStringAsFixed(0)}%"),
          MySpacing.width(5),
          Container(
            width: 100,
            child: LinearProgressIndicator(
              value: data["percentage"],
              backgroundColor: Colors.grey.shade600,
              minHeight: 5,
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    ];
  }
}
