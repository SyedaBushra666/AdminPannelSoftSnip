import 'package:admin_pannel_monotor/controller/employees/member_controller.dart';
import 'package:admin_pannel_monotor/helpers/utils/my_shadow.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_card.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_spacing.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_container.dart';
import 'package:admin_pannel_monotor/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardRecentActivity extends StatelessWidget {
  DashboardRecentActivity({super.key});

  final MemberController memberController = Get.put(MemberController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return MyCard(
        shadow: MyShadow(elevation: 0.5),
        paddingAll: 16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText.titleMedium("Recent Activity", fontWeight: 600),
            const SizedBox(height: 16),
            Column(
              children: List.generate(memberController.members.length, (index) {
                final member = memberController.members[index];
                return Padding(
                  padding: MySpacing.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🧑 User row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText.bodyLarge(member.fullName, fontWeight: 600),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Row(
                              children: [
                                MyText("View all",
                                    fontSize: 12,
                                    color: Colors.blue,
                                    fontWeight: 500),
                                const SizedBox(width: 4),
                                const Icon(Icons.arrow_forward,
                                    size: 16, color: Colors.black),
                              ],
                            ),
                          )
                        ],
                      ),

                      // 🕓 Last active
                      Row(
                        children: [
                          MyText.bodySmall("Last Active: ",
                              color: Colors.grey),
                          MyText.bodySmall("5 mins ago",
                              color: Colors.grey),
                        ],
                      ),

                      const SizedBox(height: 8),
                      // SnapsSlot(context,(String a ){})
                      // 🖼️ Snap thumbnails
                      SizedBox(
                        height: 100,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          separatorBuilder: (_, __) => MySpacing.width(12),
                          itemBuilder: (context, snapIndex) {
                            return Stack(
                              clipBehavior: Clip.none,
                              children: [
                                MyContainer(
                                  height: 80,
                                  width: 170,
                                  paddingAll: 0,
                                  clipBehavior: Clip.antiAlias,
                                  child: Image.asset(
                                    Images.SnapImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                // 👇 Activity Tag Below Image
                                Positioned(
                                  bottom: 10, // push it slightly below
                                  left:
                                      40, // center it manually based on image width
                                  child: MyContainer(
                                    borderRadiusAll: 20, // capsule style
                                    color: Colors.green,
                                    padding:
                                        MySpacing.xy(12, 4), // inner padding
                                    child: MyText.bodySmall(
                                      "Activity 30%",
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: 800,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      );
    });
  }
}
