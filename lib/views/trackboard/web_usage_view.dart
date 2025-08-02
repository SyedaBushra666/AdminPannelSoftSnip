import 'package:admin_pannel_monotor/helpers/widgets/my_breadcrumb.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_breadcrumb_item.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_flex.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_flex_item.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_spacing.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';
import 'package:admin_pannel_monotor/helpers/widgets/responsive.dart';
import 'package:admin_pannel_monotor/views/layouts/layout.dart';
import 'package:admin_pannel_monotor/views/time_sheets/components/date_picker.dart';
import 'package:admin_pannel_monotor/views/time_sheets/components/member_dropdown.dart';
import 'package:admin_pannel_monotor/views/time_sheets/components/projectc_dropdown.dart';
import 'package:admin_pannel_monotor/views/trackboard/components/web_usage_table.dart';
import 'package:flutter/material.dart';

class WebUsageView extends StatefulWidget {
  const WebUsageView({super.key});

  @override
  State<WebUsageView> createState() => _WebUsageViewState();
}

class _WebUsageViewState extends State<WebUsageView> {
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: SingleChildScrollView(
        padding: MySpacing.xy(flexSpacing, flexSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText.titleMedium(
                  "Web Usage",
                  fontSize: 18,
                  fontWeight: 600,
                ),
                MyBreadcrumb(
                  children: [
                    MyBreadcrumbItem(name: "Trackboard"),
                    MyBreadcrumbItem(name: "Web Usage", active: true),
                  ],
                ),
              ],
            ),
            MySpacing.height(flexSpacing),

            // Filter bar
            MyFlex(
              contentPadding: false,
              children: [
                MyFlexItem(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              MemberDropdown(),
                              MySpacing.width(5),
                              ProjectDropdown(),
                            ],
                          ),
                          DateDropdown(),
                        ],
                      ),
                      MySpacing.height(flexSpacing),

                      // Table
                     WebUsageTable()
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
