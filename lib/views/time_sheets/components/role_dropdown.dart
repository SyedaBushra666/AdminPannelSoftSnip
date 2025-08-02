import 'package:admin_pannel_monotor/controller/employees/role_controller.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_dropdown_search.dart';
import 'package:admin_pannel_monotor/models/roles.dart';
import 'package:admin_pannel_monotor/views/employees/components/my_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_container.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';

class RoleDropdown extends StatelessWidget {
  final RoleController controller = Get.put(RoleController());
  final double maxDropdownWidth = 300;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final dropdownWidth = availableWidth > maxDropdownWidth
            ? maxDropdownWidth
            : availableWidth * 0.9;

        return Obx(() {
          return PopupMenuButton<RoleModel>(
            constraints: BoxConstraints(
              maxWidth: dropdownWidth,
              minWidth: 200,
            ),
            offset: const Offset(0, 50),
            onSelected: controller.selectRole,
            itemBuilder: (context) => [
              // here search item will come

              PopupMenuItem(
                enabled: false,
                child: SizedBox(
                    width: dropdownWidth - 32, // Account for padding
                    child: MyDropdownSearch(
                      controller: controller.searchController,
                      searchText: controller.searchText,
                      hintText: "Search roles here ",
                    )),
              ),
              ...controller.filteredRoles.map(
                (role) => PopupMenuItem<RoleModel>(
                  value: role,
                  child: _RolePopupItem(
                    role: role,
                    controller: controller,
                  ),
                ),
              )
            ],
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 120,
                maxWidth: dropdownWidth,
              ),
              child: MyContainer(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                bordered: true,
                child: Row(
                  children: [
                    const Icon(Icons.security_outlined,
                        size: 16, color: Colors.black),
                    const SizedBox(width: 8),
                    Expanded(
                      child: MyText(
                        controller.selectedRole.value?.name ?? 'Select Role',
                        overflow: TextOverflow.ellipsis,
                        fontWeight: 500,
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down_circle_sharp, size: 18),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}

class _RolePopupItem extends StatelessWidget {
  final RoleModel role;
  final RoleController controller;

  const _RolePopupItem({
    required this.role,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = controller.selectedRole.value?.id == role.id;

    return Row(
      children: [
        Icon(
          isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
          size: 18,
          color: isSelected ? Colors.blue : Colors.grey,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: MyText(
            role.name,
            overflow: TextOverflow.ellipsis,
            fontWeight: 500,
          ),
        ),
      ],
    );
  }
}
