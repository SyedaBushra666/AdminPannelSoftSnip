import 'package:admin_pannel_monotor/helpers/widgets/my_flex_item.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_table.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeeklyProjectTable extends StatelessWidget {
  const WeeklyProjectTable({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekDates = List.generate(7, (i) => weekStart.add(Duration(days: i)));

    // Project 1
    final projectName = "Softsnip";
    final hoursWorked = ['5:30:23', '6:20:21', '7:58:43', '8:00:00', '5:14:9', 0, 0];
    final totalHours = "28:20:00";

    // All Projects (same as above for now)
    final allProjectsHours = hoursWorked;
    final allProjectsTotal = totalHours;

   final headers = [
  MyText.labelMedium("Project", fontWeight: 800,fontSize: 18,),
  ...weekDates.map(
    (d) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyText.bodyLarge(
          DateFormat('d').format(d), // e.g., Mon
          color: Colors.black,
          fontSize: 32,
        ),
        SizedBox(width: 5,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             MyText.bodySmall(
              DateFormat('EEE').format(d), // e.g., 4 Jul
              fontWeight: 700,
            ),
            MyText.bodySmall(
              DateFormat('MMM').format(d), // e.g., 4 Jul
              fontWeight: 700,
              color: Colors.grey,
            ),
          ],
        ),
      ],
    ),
  ),
  MyText.labelMedium("Total", fontWeight: 800,fontSize: 18,),
];


    final projectRow = [
      MyText.bodyMedium(projectName, ),
      ...hoursWorked.map((h) => MyText.bodySmall("$h h")),
      MyText.bodyMedium("$totalHours h", color: Colors.blue),
    ];

    final allProjectsRow = [
      MyText.bodyMedium("All Projects",),
      ...allProjectsHours.map((h) => MyText.bodySmall("$h h")),
      MyText.bodyMedium("$allProjectsTotal h", color: Colors.blue, ),
    ];

    return SizedBox(
      height: 250,
      child: MyFlexItem(
        child: MyCustomTable(
          fontSize: 18,
          headers: headers,
          rows: [projectRow, allProjectsRow], // Multiple rows
        ),
      ),
    );
  }
}
