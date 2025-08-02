import 'package:admin_pannel_monotor/controller/timesheets/time_type_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



import 'package:admin_pannel_monotor/controller/timesheets/time_type_controller.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_container.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeTypeDropdown extends StatelessWidget {
  final TimeTypeController controller = Get.put(TimeTypeController());
  final double maxDropdownWidth = 400;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final availableWidth = constraints.maxWidth;
      final dropdownWidth = availableWidth > maxDropdownWidth
          ? maxDropdownWidth
          : availableWidth * 0.9;

      return Obx(() {
        return PopupMenuButton<TimeType>(
          constraints: BoxConstraints(
            maxWidth: dropdownWidth,
            minWidth: 200,
          ),
          onSelected: (TimeType type) => controller.setTimeType(type),
          offset: const Offset(0, 50),
          itemBuilder: (context) {
            return TimeType.values.map((type) {
              return PopupMenuItem<TimeType>(
                value: type,
                child: SizedBox(
                  width: dropdownWidth - 32,
                  child: _TimeTypePopupItem(
                    type: type,
                    controller: controller,
                  ),
                ),
              );
            }).toList();
          },
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 150,
              maxWidth: dropdownWidth,
            ),
            child: MyContainer(
              paddingAll: 10,
              border: Border(
                left: BorderSide(color: Colors.blue, width: 5), // Different color for time type
              ),
              borderColor: Theme.of(context).colorScheme.secondary,
              bordered: true,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.blue, // Matching border color
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.access_time, size: 14, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: MyText(
                      controller.currentTimeTypeName,
                      fontWeight: 500,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}

class _TimeTypePopupItem extends StatelessWidget {
  final TimeType type;
  final TimeTypeController controller;

  const _TimeTypePopupItem({
    required this.type,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          children: [
            GestureDetector(
              onTap: () => controller.setTimeType(type),
              child: Icon(
                controller.selectedTimeType.value == type
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
                color: controller.selectedTimeType.value == type
                    ? Colors.blue // Matching the theme color
                    : Colors.grey,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: MyText(
                type.toString().split('.').last,
                fontWeight: 500,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ));
  }
}