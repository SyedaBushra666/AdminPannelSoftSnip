import 'package:admin_pannel_monotor/controller/timesheets/time_zone_controller.dart';
import 'package:admin_pannel_monotor/helpers/theme/app_theme.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_container.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';
import 'package:admin_pannel_monotor/models/timezone.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimezoneDropdown extends StatelessWidget {
  final TimeZoneController controller = Get.put(TimeZoneController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => PopupMenuButton<TimezoneItem>(
          onSelected: controller.setTimezone,
          offset: const Offset(0, 50),
          itemBuilder: (context) => controller.timezones
              .map(
                (item) => PopupMenuItem<TimezoneItem>(
                  value: item,
                  child: Row(
                    children: [
                      Icon(
                        controller.selected.value.label == item.label
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        size: 18,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            MyText(
                              fontSize: 12,
                              item.label
                            ),
                           MyText(
                              
                              item.value
                            ),
                          ],
                        )
                        ),
                    ],
                  ),
                ),
              )
              .toList(),
          child: MyContainer.bordered(
            paddingAll: 10,
            borderColor: theme.colorScheme.secondary,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyText(controller.selected.value.shortCode), // shows PDT / AWST
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ));
  }
}
