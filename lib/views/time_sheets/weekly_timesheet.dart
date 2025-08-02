import 'package:admin_pannel_monotor/controller/employees/basic_controller.dart';
import 'package:admin_pannel_monotor/helpers/utils/ui_mixins.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_breadcrumb.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_breadcrumb_item.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_card.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_flex.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_flex_item.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_spacing.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_weekly_chart.dart';
import 'package:admin_pannel_monotor/helpers/widgets/responsive.dart';
import 'package:admin_pannel_monotor/views/layouts/layout.dart';
import 'package:admin_pannel_monotor/views/time_sheets/components/data_table_weekly.dart';
import 'package:admin_pannel_monotor/views/time_sheets/components/date_picker.dart';
import 'package:admin_pannel_monotor/views/time_sheets/components/member_dropdown.dart';
import 'package:admin_pannel_monotor/views/time_sheets/components/projectc_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeeklyTimesheet extends StatefulWidget {
  const WeeklyTimesheet({super.key});

  @override
  State<WeeklyTimesheet> createState() => _WeeklyTimesheetState();
}

class _WeeklyTimesheetState extends State<WeeklyTimesheet>
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
                      "Weekly Timesheet",
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: "Timesheets"),
                        MyBreadcrumbItem(
                            name: "Weekly timesheet", active: true),
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
                           
                            MySpacing.width(5),
                            ProjectDropdown(),
                             
                          ],
                        ),
                    
                      DateDropdown(viewType: DateViewType.week,),
                         
                      ],
                    )),
                    MyFlexItem(
                      // sizes: "xxl-8 xl-8",
                      child: MyFlex(
                        children: [
                          MyFlexItem(
                            child: MyCard(
                              
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Label + time
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          MyText(
                                            "Total Hours Worked this Week",
                                            fontWeight: 500,
                                            fontSize: 18,
                                          ),
                                          MySpacing.width(8),
                                          MyText(
                                            " 54:30:34",
                                            color: Colors.blue,
                                            fontWeight: 700,
                                            fontSize: 18,
                                          ),
                                        ],
                                      ),
                                     
                                          
                                    ],
                                  ),
                            
                                  MySpacing.height(5),
                                  WeeklyChartWidget(),
                                ],
                              ),
                            ),
                          ),
                        
                          MyFlexItem(child: WeeklyProjectTable()),
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
}
