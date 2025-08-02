import 'package:admin_pannel_monotor/controller/employees/basic_controller.dart';
import 'package:admin_pannel_monotor/controller/employees/member_controller.dart';
import 'package:admin_pannel_monotor/helpers/theme/app_style.dart';
import 'package:admin_pannel_monotor/helpers/theme/app_theme.dart';
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
import 'package:admin_pannel_monotor/models/member.dart';
import 'package:admin_pannel_monotor/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';

class EditMember extends StatefulWidget {
  const EditMember({super.key});

  @override
  State<EditMember> createState() => _EditMemberState();
}

class _EditMemberState extends State<EditMember>
    with SingleTickerProviderStateMixin, UIMixin {
  late BasicController controller;
  late MemberController memberController;
  late Member member;

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(BasicController());
    memberController = Get.find<MemberController>();

    final id = Get.parameters['id'];

    if (id == null) {
      Get.snackbar("Error", "No member ID provided");
      Get.back();
      return;
    }

    final found = memberController.findMemberById(id);
    if (found == null) {
      Get.snackbar("Error", "Member not found. Try again later.");
      Get.back();
      return;
    }

    member = found;

    firstNameController = TextEditingController(text: member.firstName);
    lastNameController = TextEditingController(text: member.lastName);
    emailController = TextEditingController(text: member.email);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      memberController.selectedRole.value = member.role;
      memberController.selectedProject.value = member.project;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Obx(() {
        return Column(
          children: [
            Padding(
              padding: MySpacing.x(flexSpacing),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText.titleMedium("Edit Member",
                      fontSize: 18, fontWeight: 600),
                  MyBreadcrumb(
                    children: [
                      MyBreadcrumbItem(name: 'employees'),
                      MyBreadcrumbItem(name: 'edit member', active: true),
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
                                "Edit Member",
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
                                          MyText.labelMedium("First Name"),
                                          MySpacing.height(8),
                                          TextFormField(
                                            controller: firstNameController,
                                            decoration: InputDecoration(
                                              hintText: "First Name",
                                              hintStyle: MyTextStyle.bodySmall(
                                                  xMuted: true),
                                              border: outlineInputBorder,
                                              enabledBorder: outlineInputBorder,
                                              focusedBorder: focusedInputBorder,
                                              contentPadding: MySpacing.all(16),
                                              isCollapsed: true,
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.never,
                                            ),
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
                                          MyText.labelMedium("Last Name"),
                                          MySpacing.height(8),
                                          TextFormField(
                                            controller: lastNameController,
                                            decoration: InputDecoration(
                                              hintText: "Last Name",
                                              hintStyle: MyTextStyle.bodySmall(
                                                  xMuted: true),
                                              border: outlineInputBorder,
                                              enabledBorder: outlineInputBorder,
                                              focusedBorder: focusedInputBorder,
                                              contentPadding: MySpacing.all(16),
                                              isCollapsed: true,
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.never,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                MySpacing.height(20),
                                MyText.labelMedium("Email Address"),
                                MySpacing.height(8),
                                TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: "demo@getappui.com",
                                    hintStyle:
                                        MyTextStyle.bodySmall(xMuted: true),
                                    border: outlineInputBorder,
                                    enabledBorder: outlineInputBorder,
                                    focusedBorder: focusedInputBorder,
                                    prefixIcon:
                                        const Icon(LucideIcons.mail, size: 20),
                                    contentPadding: MySpacing.all(16),
                                    isCollapsed: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                  ),
                                ),
                                MySpacing.height(20),
                                IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: PopupMenuButton<String>(
                                          onSelected: (role) =>
                                              memberController.selectRole(role),
                                          itemBuilder: (BuildContext context) {
                                            return ['Admin', 'Member']
                                                .map((role) {
                                              return PopupMenuItem(
                                                value: role,
                                                height: 32,
                                                child: MyText.bodySmall(
                                                  role,
                                                  color: theme
                                                      .colorScheme.onSurface,
                                                  fontWeight: 600,
                                                ),
                                              );
                                            }).toList();
                                          },
                                          color: theme.cardTheme.color,
                                          child: MyContainer.bordered(
                                            padding: MySpacing.xy(12, 8),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: MyText.labelMedium(
                                                      memberController
                                                              .selectedRole
                                                              .value ??
                                                          "Select Role",
                                                      color: theme.colorScheme
                                                          .onSurface,
                                                    ),
                                                  ),
                                                ),
                                                Icon(
                                                  LucideIcons.chevron_down,
                                                  size: 22,
                                                  color: theme
                                                      .colorScheme.onSurface,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      MySpacing.width(12),
                                      Expanded(
                                        child: PopupMenuButton<String>(
                                          onSelected: (project) =>
                                              memberController
                                                  .selectProject(project),
                                          itemBuilder: (BuildContext context) {
                                            return ['Project A', 'Project B']
                                                .map((project) {
                                              return PopupMenuItem(
                                                value: project,
                                                height: 32,
                                                child: MyText.bodySmall(
                                                  project,
                                                  color: theme
                                                      .colorScheme.onSurface,
                                                  fontWeight: 600,
                                                ),
                                              );
                                            }).toList();
                                          },
                                          color: theme.cardTheme.color,
                                          child: MyContainer.bordered(
                                            padding: MySpacing.xy(12, 8),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: MyText.labelMedium(
                                                      memberController
                                                              .selectedProject
                                                              .value ??
                                                          "Select Project",
                                                      color: theme.colorScheme
                                                          .onSurface,
                                                    ),
                                                  ),
                                                ),
                                                Icon(
                                                  LucideIcons.chevron_down,
                                                  size: 22,
                                                  color: theme
                                                      .colorScheme.onSurface,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                MySpacing.height(20),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      MyButton.rounded(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        elevation: 0,
                                        padding: MySpacing.xy(20, 16),
                                        backgroundColor:
                                            theme.colorScheme.secondary,
                                        child: MyText.labelMedium(
                                          "cancel",
                                          color: theme.colorScheme.onPrimary,
                                        ),
                                      ),
                                      MySpacing.width(8),
                                      MyButton(
                                        onPressed: () {
                                          final updated = Member(
                                            id: member.id,
                                            firstName: firstNameController.text,
                                            lastName: lastNameController.text,
                                            email: emailController.text,
                                            role: memberController
                                                    .selectedRole.value ??
                                                '',
                                            project: memberController
                                                    .selectedProject.value ??
                                                '',
                                          );
                                          memberController
                                              .updateMember(updated);
                                          Get.back();
                                        },
                                        elevation: 0,
                                        padding: MySpacing.xy(20, 16),
                                        backgroundColor: contentTheme.primary,
                                        borderRadiusAll:
                                            AppStyle.buttonRadius.medium,
                                        child: MyText.bodySmall(
                                          'Update',
                                          color: contentTheme.onPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
  
}
