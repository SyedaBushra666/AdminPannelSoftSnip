import 'package:admin_pannel_monotor/controller/employees/member_controller.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_container.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_dropdown_search.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';
import 'package:admin_pannel_monotor/models/member.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemberDropdown extends StatelessWidget {
  final MemberController controller = Get.put(MemberController());
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
          return PopupMenuButton<Member>(
            constraints: BoxConstraints(
              maxWidth: dropdownWidth,
              minWidth: 200,
            ),
            offset: const Offset(0, 50),
            onSelected: controller.selectMember,
            itemBuilder: (context) => [
              PopupMenuItem(
                enabled: false,
                padding: const EdgeInsets.all(8),
                child: MyDropdownSearch(
  controller: controller.searchController,
  searchText: controller.searchText,
  hintText: "Search Members",
)
              ),
              ...controller.filteredMembers.map(
                (member) => PopupMenuItem<Member>(
                  value: member,
                  child: _MemberPopupItem(
                    member: member,
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
                    const Icon(Icons.person_3_outlined,
                        size: 16, color: Colors.black),
                    const SizedBox(width: 8),
                    Expanded(
                      child: MyText(
                        controller.selectedMember.value?.fullName ??
                            'Select Member',
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

class _MemberPopupItem extends StatelessWidget {
  final Member member;
  final MemberController controller;

  const _MemberPopupItem({
    required this.member,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = controller.selectedMember.value?.id == member.id;

    return Row(
      children: [
        Icon(
          isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
          size: 18,
          color: isSelected ? Colors.blue : Colors.grey,
        ),
        // const SizedBox(width: 10),
        // const Icon(Icons.person_3_outlined, size: 16, color: Colors.black),
        
        const SizedBox(width: 10),
        Expanded(
          child: MyText(
            '${member.firstName} ${member.lastName}',
            overflow: TextOverflow.ellipsis,
            fontWeight: 500,
          ),
        ),
      ],
    );
  }
}
