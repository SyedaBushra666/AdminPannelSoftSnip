import 'package:admin_pannel_monotor/app_constant.dart';
import 'package:admin_pannel_monotor/controller/timesheets/view_and_edit_controller.dart';
import 'package:admin_pannel_monotor/helpers/theme/app_theme.dart';
import 'package:admin_pannel_monotor/helpers/utils/ui_mixins.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_container.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_spacing.dart';
import 'package:flutter/material.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';

class DateRangePicker extends StatefulWidget {
  const DateRangePicker({super.key});

  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker>
    with SingleTickerProviderStateMixin, UIMixin {
  late ViewAndEditController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ViewAndEditController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewAndEditController>(
      init: controller,
      builder: (controller) {
        final String start = controller.selectedStartDate != null
            ? dateFormatter.format(controller.selectedStartDate!)
            : "Friday, June 27, 2025";
        final String end = controller.selectedEndDate != null
            ? dateFormatter.format(controller.selectedEndDate!)
            : "Friday, June 27, 2025";

        return MyContainer(
          paddingAll: 0,
          bordered: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// ⬅️ Back button
              Container(
                color: Colors.black,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, size: 15,color: Colors.white,),
                  onPressed: (){}
                  //controller.goToPreviousDay,
                ),
              ),
              MySpacing.width(5),

              /// 📅 Date range (centered)
              InkWell(
                onTap: controller.pickDateRange,
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  children: [
                    MyText.bodySmall(
                      "$start",
                      fontWeight: 500,
                      color: theme.colorScheme.onSurface,
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      LucideIcons.calendar_clock,
                      color: Colors.black,
                      size: 15,
                    ),
                  ],
                ),
              ),
              MySpacing.width(5),
              /// ➡️ Forward button
              Container(
                
                color: Colors.black,
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward, size: 16,color: Colors.white,),
                  onPressed:(){}
                  // controller.goToNextDay,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
