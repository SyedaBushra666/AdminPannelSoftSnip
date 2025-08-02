import 'package:admin_pannel_monotor/controller/employees/member_controller.dart';
import 'package:admin_pannel_monotor/helpers/theme/app_style.dart';
import 'package:admin_pannel_monotor/helpers/theme/app_theme.dart';
import 'package:admin_pannel_monotor/helpers/utils/my_shadow.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_button.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_card.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_container.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_flex_item.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_spacing.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';

class DashboardMembersList extends StatefulWidget {
  const DashboardMembersList({super.key});

  @override
  State<DashboardMembersList> createState() => _DashboardMembersListState();
}

class _DashboardMembersListState extends State<DashboardMembersList> {
  final MemberController memberController = Get.put(MemberController());
  @override
  Widget build(BuildContext context) {
    return MyFlexItem(
  sizes: "lg-8",
  child: MyCard(
    shadow: MyShadow(elevation: 0.5),
    padding: MySpacing.xy(16, 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row with title + Add Member button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText.titleMedium(
              "Members Overview",
              fontWeight: 600,
            ),
              MyButton(
                              onPressed: () {
                                Get.toNamed("/contacts/addmember");
                              },
                              elevation: 0,
                              padding: MySpacing.xy(12, 16),
                              backgroundColor: Colors.blue,
                              borderRadiusAll: AppStyle.buttonRadius.medium,
                              child: Row(
                                children: [
                                  Icon(LucideIcons.circle_plus,
                                      color: Colors.blue.shade50, size: 16),
                                  MySpacing.width(12),
                                  MyText.bodySmall("Add Member",
                                      color:Colors.white),
                                ],
                              ),
                            ),
          ],
        ),
        MySpacing.height(12),

        // Member list
        Obx(() {
          return Column(
            children: memberController.members.map((member) {
              return Padding(
                padding: MySpacing.only(bottom: 12),
                child: Row(
                  children: [
                    // Circle with first letter
                    MyContainer.rounded(
                      paddingAll: 0,
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      color: theme.colorScheme.primary.withAlpha(30),
                      child: MyText.bodyMedium(
                        member.fullName.isNotEmpty
                            ? member.fullName[0].toUpperCase()
                            : '?',
                        fontWeight: 700,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    MySpacing.width(12),

                    // Name and Status
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.bodyLarge(
                            member.fullName,
                            fontWeight: 600,
                          ),
                          MySpacing.height(4),
                          Row(
                            children: [
                              Icon(
                                member.isActive
                                    ? Icons.circle
                                    : Icons.circle_outlined,
                                size: 10,
                                color: member.isActive
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              MySpacing.width(6),
                              MyText.bodySmall(
                                member.isActive
                                    ? "Active"
                                    : "Inactive",
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // More actions icon
                    IconButton(
                      icon: const Icon(Icons.more_vert, size: 20),
                      onPressed: () {
                        //controller.openMemberOptions(member);
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        }),
      ],
    ),
  ),
);
  }
}