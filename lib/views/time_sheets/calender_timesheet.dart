import 'package:admin_pannel_monotor/controller/Calender/calender_controller.dart';
import 'package:admin_pannel_monotor/helpers/utils/my_shadow.dart';
import 'package:admin_pannel_monotor/helpers/utils/ui_mixins.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_breadcrumb.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_breadcrumb_item.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_card.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_flex.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_flex_item.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_spacing.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';
import 'package:admin_pannel_monotor/helpers/widgets/responsive.dart';
import 'package:admin_pannel_monotor/views/layouts/layout.dart';
import 'package:admin_pannel_monotor/views/time_sheets/components/date_picker.dart';
import 'package:admin_pannel_monotor/views/time_sheets/components/member_dropdown.dart';
import 'package:admin_pannel_monotor/views/time_sheets/components/projectc_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderTimeSheet extends StatefulWidget {
  const CalenderTimeSheet({super.key});

  @override
  State<CalenderTimeSheet> createState() => _CalenderTimeSheetState();
}

class _CalenderTimeSheetState extends State<CalenderTimeSheet>
    with SingleTickerProviderStateMixin, UIMixin {
  late CalenderController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(CalenderController());
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
                      "Calender Timesheet",
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: "Timesheets"),
                        MyBreadcrumbItem(
                            name: "Calender timesheet", active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              MyFlex(
                children: [
                  MyFlexItem(
                      // sizes: "xxl-8 xl-10",
                      child: Padding(
                    padding: MySpacing.x(flexSpacing),
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
                    ),
                  )),
                  MyFlexItem(
                    child: Padding(
                      padding: MySpacing.x(flexSpacing),
                      child: MyCard(
                        shadow: MyShadow(elevation: 0.5),
                        height: 700,
                        child: SfCalendar(
                          view: CalendarView.week,
                          allowedViews: const [
                            CalendarView.day,
                            CalendarView.week,
                            CalendarView.month,
                          ],
                          dataSource: controller.events,
                          allowDragAndDrop: true,
                          onDragEnd: controller.dragEnd,
                          monthViewSettings: const MonthViewSettings(
                            showAgenda: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
