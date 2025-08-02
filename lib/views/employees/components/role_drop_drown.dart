
import 'package:admin_pannel_monotor/controller/employees/basic_controller.dart';
import 'package:admin_pannel_monotor/helpers/theme/app_theme.dart';
import 'package:admin_pannel_monotor/helpers/utils/ui_mixins.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_container.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_spacing.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';


class RoleDropDown extends StatefulWidget {
  const RoleDropDown({
    super.key,
  });

  @override
  State<RoleDropDown> createState() => _RoleDropDownState();
}

class _RoleDropDownState extends State<RoleDropDown>   with SingleTickerProviderStateMixin, UIMixin {
  late BasicController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(BasicController());
  }
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.stretch,
        children: [
          // Role Dropdown
          Expanded(
            child: PopupMenuButton<UserRole>(
              onSelected: controller.onSelectRole,
              itemBuilder:
                  (BuildContext context) {
                return UserRole.values
                    .map((role) {
                  return PopupMenuItem(
                    value: role,
                    height: 32,
                    child: MyText.bodySmall(
                      role.name.capitalize!,
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
                          controller
                                  .selectedRole
                                  ?.name
                                  .capitalize! ??
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
          MySpacing.width(
              12), // space between the two dropdowns
    
          // Project Dropdown
          Expanded(
            child: PopupMenuButton<Project>(
              onSelected:
                  controller.onSelectProject,
              itemBuilder:
                  (BuildContext context) {
                return controller.projectList
                    .map((project) {
                  return PopupMenuItem(
                    value: project,
                    height: 32,
                    child: MyText.bodySmall(
                      project.name,
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
                          controller
                                  .selectedProject
                                  ?.name ??
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
    );
  }
}
