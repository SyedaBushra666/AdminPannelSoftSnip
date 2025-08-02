import 'package:admin_pannel_monotor/controller/employees/member_controller.dart';
import 'package:admin_pannel_monotor/helpers/utils/ui_mixins.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_card.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_spacing.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_table.dart';
import 'package:admin_pannel_monotor/views/employees/components/alert_dialogue_delete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';


class EmployeeTable extends StatefulWidget with UIMixin {
   EmployeeTable({super.key});

  @override
  State<EmployeeTable> createState() => _EmployeeTableState();
}

class _EmployeeTableState extends State<EmployeeTable> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MemberController>(
      init: MemberController()..loadDummyData(),
      builder: (controller) {
        final filteredMembers = controller.filteredMembers; // 👈 use filtered list
        return MyCard(
          paddingAll: 0,
          child: Column(
            children: [
             // MemberHeaderBar(controller: controller), // 👈 filter bar
              MySpacing.height(12),
              Expanded(
                child: MyCustomTable(
                  fontSize: 16,
                  stringHeaders: const [
                    "Name",
                    "Email",
                    "Role",
                    "Projects",
                    "Status",
                    "Actions",
                  ],
                  rows: filteredMembers.map((member) {
                    return [
                      Text("${member.firstName} ${member.lastName}"),
                      Text(member.email),
                      Text(member.role),
                      Text(member.project),
                      _buildStatusCell(member.isActive),
                      _buildInlineActions(context, member.id),
                    ];
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusCell(bool isActive) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.green : Colors.yellow,
          ),
        ),
        Text(isActive ? "Active" : "Inactive"),
      ],
    );
  }

  Widget _buildInlineActions(BuildContext context, String id) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _actionIcon(LucideIcons.eye, Colors.blueGrey, "View", () {
          Get.toNamed('/view-member');
        }),
        _actionIcon(LucideIcons.pencil, Colors.orange, "Edit", () {
          Get.toNamed('/edit_member/$id');
        }),
        _actionIcon(LucideIcons.trash, Colors.redAccent, "Delete", () {
          showAlertDialogDelete(
            context: context,
            userName: "Bushra Syeda",
            userEmail: "bushra@example.com",
            onDelete: () {
              // delete logic here
            },
          );
        }),
      ],
    );
  }

  Widget _actionIcon(
    IconData icon,
    Color color,
    String tooltip,
    VoidCallback onTap,
  ) {
    return Tooltip(
      message: tooltip,
      waitDuration: const Duration(milliseconds: 300),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Material(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Icon(icon, size: 16, color: color),
            ),
          ),
        ),
      ),
    );
  }
}
