import 'package:admin_pannel_monotor/controller/employees/member_controller.dart';
import 'package:admin_pannel_monotor/helpers/theme/app_style.dart';
import 'package:admin_pannel_monotor/helpers/theme/theme_customizer.dart';
import 'package:admin_pannel_monotor/helpers/utils/ui_mixins.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_breadcrumb.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_breadcrumb_item.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_button.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_flex.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_flex_item.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_spacing.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';
import 'package:admin_pannel_monotor/helpers/widgets/responsive.dart';
import 'package:admin_pannel_monotor/views/employees/components/employee_table.dart';
import 'package:admin_pannel_monotor/views/employees/components/my_search_field.dart';
import 'package:admin_pannel_monotor/views/layouts/layout.dart';
import 'package:admin_pannel_monotor/views/layouts/right_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';

class MemberList extends StatefulWidget {
  const MemberList({super.key});

  @override
  State<MemberList> createState() => _MemberListState();
}

class _MemberListState extends State<MemberList>
    with SingleTickerProviderStateMixin, UIMixin {
  late MemberController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(MemberController());
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
                      "Members (5)",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: "Members"),
                        MyBreadcrumbItem(name: "All members ", active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: MyFlex(
                  children: [
                    MyFlexItem(
                        // sizes: "xxl-8 xl-10",
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MySearchField(
                          hintText: "Search member here ...",
                        ),

                        // DateDropdown(),
                        Row(
                          children: [
                            MyButton(
                              onPressed: () {
                                Get.toNamed("/contacts/addmember");
                              },
                              elevation: 0,
                              padding: MySpacing.xy(12, 16),
                              backgroundColor: contentTheme.primary,
                              borderRadiusAll: AppStyle.buttonRadius.medium,
                              child: Row(
                                children: [
                                  Icon(LucideIcons.circle_plus,
                                      color: contentTheme.light, size: 16),
                                  MySpacing.width(12),
                                  MyText.bodySmall("Add Member",
                                      color: contentTheme.onPrimary),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            MyButton.outlined(
                              onPressed: () {
                               ThemeCustomizer.openRightBar(true);
                              },
                              
                              elevation: 0,
                              padding: MySpacing.xy(12, 16),
                              borderColor: contentTheme.primary,
                              backgroundColor: contentTheme.primary,
                              borderRadiusAll: AppStyle.buttonRadius.medium,
                              child: Row(
                                children: [
                                  Icon(
                                    LucideIcons.list_filter,
                                    color: Colors.black,
                                    size: 16,
                                  ),
                                  MySpacing.width(12),
                                  MyText.bodySmall(
                                    "Filters",
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                    MyFlexItem(child: SizedBox(
                      height: 400,
                      child: EmployeeTable()))
                    // InviteTable()
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

class _FilterDialogContent extends StatefulWidget {
  @override
  State<_FilterDialogContent> createState() => _FilterDialogContentState();
}

class _FilterDialogContentState extends State<_FilterDialogContent> {
  String? selectedRole;
  String? selectedProject;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MySpacing.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText.titleMedium("Apply Filters", fontWeight: 700),
              IconButton(
                icon: Icon(Icons.close, size: 20),
                onPressed: () => Get.back(),
              ),
            ],
          ),
          MySpacing.height(16),

          // Role Filter
          _buildFilterField(
            label: "Role",
            child: DropdownButtonFormField<String>(
              decoration: _inputDecoration(),
              value: selectedRole,
              hint: Text("Select role"),
              items: ["Admin", "Member", "Viewer"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => selectedRole = val),
            ),
          ),

          MySpacing.height(16),

          // Project Filter
          _buildFilterField(
            label: "Project",
            child: DropdownButtonFormField<String>(
              decoration: _inputDecoration(),
              value: selectedProject,
              hint: Text("Select project"),
              items: ["Alpha", "Beta", "Gamma"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => selectedProject = val),
            ),
          ),

          MySpacing.height(24),

          // Apply Button
          Align(
            alignment: Alignment.centerRight,
            child: MyButton(
              padding: MySpacing.xy(24, 12),
              onPressed: () {
                Get.back();
                // Show applied filters as snack or chips
                Get.snackbar(
                    "Filters Applied", "Your filters have been updated",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green.withOpacity(0.1),
                    colorText: Colors.green[900],
                    margin: EdgeInsets.all(16),
                    duration: Duration(seconds: 2));
              },
              child: MyText.bodyMedium("Apply"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterField({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.labelMedium(label, fontWeight: 600),
        MySpacing.height(8),
        child,
      ],
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }
}
