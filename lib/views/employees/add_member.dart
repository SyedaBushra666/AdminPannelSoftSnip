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
import 'package:admin_pannel_monotor/helpers/widgets/my_text_style.dart';
import 'package:admin_pannel_monotor/helpers/widgets/responsive.dart';
import 'package:admin_pannel_monotor/views/employees/components/role_drop_drown.dart';
import 'package:admin_pannel_monotor/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';


class AddMember extends StatefulWidget {
  const AddMember({super.key});

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember>
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
                      "Add Member",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'employees'),
                        MyBreadcrumbItem(name: 'add member', active: true),
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
                        paddingAll: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: MySpacing.x(8),
                              child: MyContainer(
                                child: MyText.titleMedium(
                                  "Add New Member",
                                  fontWeight: 600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: MySpacing.nTop(flexSpacing),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            MyText.labelMedium(
                                              "first_name",
                                            ),
                                            MySpacing.height(8),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                  hintText: "First Name",
                                                  hintStyle:
                                                      MyTextStyle.bodySmall(
                                                          xMuted: true),
                                                  border: outlineInputBorder,
                                                  enabledBorder:
                                                      outlineInputBorder,
                                                  focusedBorder:
                                                      focusedInputBorder,
                                                  contentPadding:
                                                      MySpacing.all(16),
                                                  isCollapsed: true,
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .never),
                                            ),
                                          ],
                                        ),
                                      ),
                                      MySpacing.width(16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            MyText.labelMedium(
                                              "last_name",
                                            ),
                                            MySpacing.height(8),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                  hintText: "Last Name",
                                                  hintStyle:
                                                      MyTextStyle.bodySmall(
                                                          xMuted: true),
                                                  border: outlineInputBorder,
                                                  enabledBorder:
                                                      outlineInputBorder,
                                                  focusedBorder:
                                                      focusedInputBorder,
                                                  contentPadding:
                                                      MySpacing.all(16),
                                                  isCollapsed: true,
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .never),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  MySpacing.height(20),
                                  MyText.labelMedium(
                                    "email_address",
                                  ),
                                  MySpacing.height(8),
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        hintText: "demo@getappui.com",
                                        hintStyle:
                                            MyTextStyle.bodySmall(xMuted: true),
                                        border: outlineInputBorder,
                                        enabledBorder: outlineInputBorder,
                                        focusedBorder: focusedInputBorder,
                                        prefixIcon: const Icon(
                                          LucideIcons.mail,
                                          size: 20,
                                        ),
                                        contentPadding: MySpacing.all(16),
                                        isCollapsed: true,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never),
                                  ),
                                  MySpacing.height(20),
                                  RoleDropDown(),
                                   MySpacing.height(20),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: MyButton(
                                      onPressed: () {},
                                      elevation: 0,
                                      padding: MySpacing.xy(20, 16),
                                      backgroundColor: contentTheme.primary,
                                      borderRadiusAll:
                                          AppStyle.buttonRadius.medium,
                                      child: MyText.bodySmall(
                                        'Add Member',
                                        color: contentTheme.onPrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    //stop
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
