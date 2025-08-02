import 'package:admin_pannel_monotor/controller/employees/basic_controller.dart';
import 'package:admin_pannel_monotor/helpers/theme/app_style.dart';
import 'package:admin_pannel_monotor/helpers/utils/ui_mixins.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_breadcrumb.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_breadcrumb_item.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_button.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_container.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_flex.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_flex_item.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_spacing.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';
import 'package:admin_pannel_monotor/helpers/widgets/responsive.dart';
import 'package:admin_pannel_monotor/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';


class ViewMember extends StatefulWidget {
  const ViewMember({super.key});

  @override
  State<ViewMember> createState() => _ViewMemberState();
}

class _ViewMemberState extends State<ViewMember>
    with SingleTickerProviderStateMixin, UIMixin {
  late BasicController controller;

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
                      "View Member",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'employees'),
                        MyBreadcrumbItem(name: 'view member', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(
                  children: [
                    MyFlexItem(
                      sizes: "lg-7",
                      child: MyContainer.bordered(
                        paddingAll: 24,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius:30,
                                  backgroundColor:
                                      contentTheme.primary.withOpacity(0.1),
                                  child: Icon(
                                    LucideIcons.user_round,
                                    size: 25,
                                    color: contentTheme.primary,
                                  ),
                                ),
                                MySpacing.width(10),
                                // Name and Email
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText.titleMedium(
                                  "Bushra Umer",
                                  fontWeight: 700,
                                  fontSize: 20,
                                ),
                               MyText.labelMedium(
                              "bushra@example.com",
                              
                            ),

                              ],
                            ),
                              ],
                            ),

                            // Role
                            MySpacing.height(20),       
                            _infoTile("Role", "Organization Admin"),     
                            MySpacing.width(5),     
                            _infoTile("Project", "SoftSnip"),     
                            MySpacing.width(5),  
                            // Joining Date
                            _infoTile("Joined", "Jan 10, 2024"),

                            MySpacing.height(10),

                            // Back Button
                            Align(
                              alignment: Alignment.centerRight,
                              child: MyButton(
                                onPressed: () {
                                  Get.back();
                                },
                                elevation: 0,
                                padding: MySpacing.xy(20, 16),
                                backgroundColor: contentTheme.primary,
                                borderRadiusAll: AppStyle.buttonRadius.medium,
                                child: MyText.bodySmall(
                                  'Back',
                                  color: contentTheme.onPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
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

  // Info row widget
  Widget _infoTile(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(left: 5,right: 5),
      child: Row(
       
        children: [
          MyText.bodyLarge(
            "$label: ",
            fontWeight: 600,
            
          ),
          MyText.bodyLarge(value),
        ],
      ),
    );
  }

    }