
import 'package:admin_pannel_monotor/controller/employees/basic_controller.dart';
import 'package:admin_pannel_monotor/helpers/utils/ui_mixins.dart';
import 'package:admin_pannel_monotor/helpers/utils/utils.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_breadcrumb.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_breadcrumb_item.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_card.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_flex.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_flex_item.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_spacing.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';
import 'package:admin_pannel_monotor/helpers/widgets/responsive.dart';
import 'package:admin_pannel_monotor/views/layouts/layout.dart';
import 'package:admin_pannel_monotor/views/time_sheets/components/activity_tracker_bar.dart';
import 'package:admin_pannel_monotor/views/time_sheets/components/data_table_daily.dart';
import 'package:admin_pannel_monotor/views/time_sheets/components/date_picker.dart';
import 'package:admin_pannel_monotor/views/time_sheets/components/date_range_picker.dart';
import 'package:admin_pannel_monotor/views/time_sheets/components/member_dropdown.dart';
import 'package:admin_pannel_monotor/views/time_sheets/components/projectc_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyTimesheet extends StatefulWidget {
  const DailyTimesheet({super.key});

  @override
  State<DailyTimesheet> createState() => _DailyTimesheetState();
}

class _DailyTimesheetState extends State<DailyTimesheet>
    with SingleTickerProviderStateMixin, UIMixin {
  late BasicController controller;
  DateTime selectedDate = DateTime.now();
  double progress = 0.4; // ✅ Defined here to avoid undefined error

  void onStartChange(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
    });
  }

  @override
  void initState() {
    super.initState();
    controller = Get.put(BasicController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Daily Timesheet",
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: "Timesheets"),
                        MyBreadcrumbItem(name: "Daily timesheet", active: false),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: MyFlex(
                  contentPadding: false,
                  children: [
                    MyFlexItem(
                        // sizes: "xxl-8 xl-10",
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            MemberDropdown(),
                            MySpacing.width(5),
                            ProjectDropdown()
                            
                          ],
                        ),
                          DateDropdown(),
                      ],
                    )),
                    MyFlexItem(
                      // sizes: "xxl-8 xl-8",
                      child: Column(
                        children: [
                          MyCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Label + time
                                Row(
                                  children: [
                                    MyText(
                                      "Total Hours Worked Today",
                                      fontWeight: 500,
                                      fontSize: 18,
                                    ),
                                    MySpacing.width(8),
                                    MyText(
                                      "3:45:00",
                                      color: Colors.blue,
                                      fontWeight: 700,
                                      fontSize: 18,
                                    ),
                                  ],
                                ),
                                
                                MySpacing.height(10),
                                 
                                TimeTrackerBar(
                                  segments: [
                                    TimeSegment(
                                      start:
                                          const TimeOfDay(hour: 9, minute: 0),
                                      end: const TimeOfDay(hour: 9, minute: 30),
                                      color: Colors.orange, // Meeting
                                    ),
                                    TimeSegment(
                                      start:
                                          const TimeOfDay(hour: 10, minute: 0),
                                      end: const TimeOfDay(hour: 11, minute: 0),
                                      color: Colors.blue, // Focus
                                    ),
                                    TimeSegment(
                                      start:
                                          const TimeOfDay(hour: 14, minute: 0),
                                      end: const TimeOfDay(hour: 16, minute: 0),
                                      color: Colors.grey.shade400, // Break
                                    ),
                                    TimeSegment(
                                      start:
                                          const TimeOfDay(hour: 16, minute: 15),
                                      end: const TimeOfDay(hour: 17, minute: 0),
                                      color: Colors.green, // Other
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          MySpacing.height(10),
                          DataTableDaily(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildPersonalDetail(String title, String description) {
    return Row(
      children: [
        MyText.titleMedium(
          title,
          fontWeight: 600,
        ),
        MySpacing.width(8),
        Expanded(
          child: MyText.bodyMedium(
            description,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class ContactsData extends DataTableSource with UIMixin {
  final List<Contacts> data = [
    Contacts(
      name: "Ali Khan",
      email: "ali.khan@example.com",
      phoneNumber: "3001234567",
      company: "Softtech Ltd.",
      createdAt: DateTime(2022, 5, 14),
    ),
    Contacts(
      name: "Zara Ahmed",
      email: "zara.ahmed@example.com",
      phoneNumber: "3017654321",
      company: "NextGen Inc.",
      createdAt: DateTime(2023, 1, 8),
    ),
    Contacts(
      name: "Imran Raza",
      email: "imran.raza@example.com",
      phoneNumber: "3029876543",
      company: "Alpha Systems",
      createdAt: DateTime(2021, 9, 23),
    ),
  ];

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(
      cells: [
        DataCell(MyText.titleMedium(data[index].name, fontWeight: 600)),
        DataCell(MyText.bodyMedium("91+ ${data[index].phoneNumber}")),
        DataCell(MyText.bodyMedium(data[index].email)),
        DataCell(MyText.bodyMedium(data[index].company)),
        DataCell(
          MyText.bodyMedium(
            '${Utils.getDateStringFromDateTime(
              data[index].createdAt,
              showMonthShort: true,
            )}',
          ),
        ),
      ],
    );
  }
}

class Contacts {
  final String name;
  final String email;
  final String phoneNumber;
  final String company;
  final DateTime createdAt;

  Contacts({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.company,
    required this.createdAt,
  });
}