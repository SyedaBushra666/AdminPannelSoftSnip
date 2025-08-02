import 'package:admin_pannel_monotor/controller/my_controller.dart';
import 'package:admin_pannel_monotor/helpers/theme/app_theme.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_button.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_spacing.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewAndEditController extends MyController {
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  void setSelectedDateRange(DateTime start, DateTime end) {
    selectedStartDate = start;
    selectedEndDate = end;
    update(); // If you're using GetX to refresh the UI
  }

  Future<void> pickDateRange() async {
    final ViewAndEditController controller = Get.find();
    DateTime tempStart = selectedStartDate ?? DateTime.now();
    DateTime tempEnd = selectedEndDate ?? DateTime.now();
    String selectedQuickRange = 'Today';

    await showDialog(
      context: Get.context!,
      builder: (_) {
        return Dialog(
          insetPadding: const EdgeInsets.all(10),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 600;

              return Container(
                padding: const EdgeInsets.all(16),
                constraints: BoxConstraints(
                  maxWidth: 800,
                  minWidth: isWide ? 600 : double.infinity,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    isWide
                        ? Row(
                            children: [
                              // Quick ranges (left)
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    _quickRangesList(selectedQuickRange,
                                        (label, start, end) {
                                      tempStart = start;
                                      tempEnd = end;
                                      selectedQuickRange = label;
                                      controller.update();
                                    }),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: MyButton.medium(
                                            buttonType: MyButtonType.outlined,
                                            backgroundColor: Colors.white,
                                            borderColor: Colors.black,
                                            soft: true,
                                              onPressed: () => Get.back(),
                                              child:  MyText.bodySmall("Cancel",color: Colors.black,)),
                                        ),
                                         MySpacing.width(5),
                                        Expanded(
                                          child: MyButton.medium(
                                            backgroundColor: Colors.green,
                                            onPressed: () {
                                              controller.setSelectedDateRange(
                                                  tempStart, tempEnd);
                                              Get.back();
                                            },
                                            child:  MyText.bodySmall("Apply",color: Colors.white,),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                             // const VerticalDivider(),
                              // Calendars (right)
                              Expanded(
                                flex: 4,
                                child: _calendars(tempStart, tempEnd,
                                    (s) => tempStart = s, (e) => tempEnd = e),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              _quickRangesList(selectedQuickRange,
                                  (label, start, end) {
                                tempStart = start;
                                tempEnd = end;
                                selectedQuickRange = label;
                                controller.update();
                              }),
                              const SizedBox(height: 16),
                              _calendars(tempStart, tempEnd,
                                  (s) => tempStart = s, (e) => tempEnd = e),
                            ],
                          ),
                    //const SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

Widget _calendars(DateTime start, DateTime end,
    Function(DateTime) onStartChange, Function(DateTime) onEndChange) {
  return Row(
    children: [
      Expanded(
        child: CalendarDatePicker(
          initialDate: start,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          onDateChanged: onStartChange,
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: CalendarDatePicker(
          initialDate: end,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          onDateChanged: onEndChange,
        ),
      ),
    ],
  );
}

//_____________________________________For List of durations
Widget _quickRangesList(
    String selected,
     Function(String, DateTime, DateTime) onSelect) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  List<Map<String, dynamic>> quickRanges = [
    {
      "label": "Today",
      "start": today,
      "end": today,
    },
    {
      "label": "Yesterday",
      "start": today.subtract(const Duration(days: 1)),
      "end": today.subtract(const Duration(days: 1)),
    },
    {
      "label": "Last 7 days",
      "start": today.subtract(const Duration(days: 6)),
      "end": today,
    },
    {
      "label": "Last week",
      "start": today.subtract(Duration(days: today.weekday + 6)),
      "end": today.subtract(Duration(days: today.weekday)),
    },
    {
      "label": "Last 2 weeks",
      "start": today.subtract(const Duration(days: 13)),
      "end": today,
    },
    {
      "label": "This month",
      "start": DateTime(today.year, today.month, 1),
      "end": DateTime(today.year, today.month + 1, 0),
    },
    {
      "label": "Last month",
      "start": DateTime(today.year, today.month - 1, 1),
      "end": DateTime(today.year, today.month, 0),
    },
  ];

  return ListView.builder(
    shrinkWrap: true,
    itemCount: quickRanges.length,
    itemBuilder: (_, index) {
      final item = quickRanges[index];
      bool isToday(DateTime date) {
  final now = DateTime.now();
  return now.year == date.year && now.month == date.month && now.day == date.day;
}

      return MyButton.outlined(
        backgroundColor: isToday(DateTime.now()) ? theme.primaryColorDark: Colors.white ,
       soft: true,
       borderColor: theme.primaryColorDark,
        onPressed: () {
          onSelect(item['label'], item['start'], item['end']);
        },
        child: MyText(
          item['label'],
          style: TextStyle(
            color: theme.primaryColorDark ,
            fontWeight:  FontWeight.w500
          ),
        ),
      );
    },
  );
}
