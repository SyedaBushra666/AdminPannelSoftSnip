import 'dart:async';
import 'package:admin_pannel_monotor/controller/nft_dashboard_controller.dart';
import 'package:admin_pannel_monotor/helpers/utils/ui_mixins.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_breadcrumb.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_breadcrumb_item.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_flex.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_flex_item.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_spacing.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';
import 'package:admin_pannel_monotor/helpers/widgets/responsive.dart';
import 'package:admin_pannel_monotor/views/layouts/layout.dart';
import 'package:admin_pannel_monotor/views/time_sheets/components/date_picker.dart';
import 'package:admin_pannel_monotor/views/time_sheets/components/member_dropdown.dart';
import 'package:admin_pannel_monotor/views/time_sheets/components/projectc_dropdown.dart';
import 'package:admin_pannel_monotor/views/trackboard/components/time_snaps_slot.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // make sure this import is correct

class SnapshotsView extends StatefulWidget {
  const SnapshotsView({super.key});

  @override
  State<SnapshotsView> createState() => _SnapshotsViewState();
}

class _SnapshotsViewState extends State<SnapshotsView>
    with SingleTickerProviderStateMixin, UIMixin {
  late NFTDashboardController controller;
  Timer? countdownTimer;
  Duration myDuration = const Duration(hours: 12);
  String? selectedImageUrl;

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    if (mounted) {
      const reduceSeconds = 1;

      final seconds = myDuration.inSeconds - reduceSeconds;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    controller = Get.put(NFTDashboardController());
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          String strDigits(int n) => n.toString().padLeft(2, '0');
          final hours = strDigits(myDuration.inHours.remainder(24));
          final minutes = strDigits(myDuration.inMinutes.remainder(60));
          final seconds = strDigits(myDuration.inSeconds.remainder(60));

          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: MySpacing.x(flexSpacing),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText.titleMedium(
                            "Snapshots",
                            fontSize: 18,
                            fontWeight: 600,
                          ),
                          MyBreadcrumb(
                            children: [
                              MyBreadcrumbItem(name: "Trackboard"),
                              MyBreadcrumbItem(name: "snapshots", active: true),
                            ],
                          ),
                        ],
                      ),
                    ),
                    MySpacing.height(flexSpacing),
                    Padding(
                      padding: MySpacing.x(flexSpacing),
                      child: MyFlex(
                        contentPadding: false,
                        children: [
                          MyFlexItem(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        MemberDropdown(),
                                        MySpacing.width(5),
                                        ProjectDropdown()
                                      ],
                                    ),
                                    DateDropdown(),
                                  ],
                                ),
                                SizedBox(height: 20),
                                MySpacing.height(flexSpacing),
                                TimeSnapsSlot(
                                  onImageTap: (url) {
                                    setState(() {
                                      selectedImageUrl = url;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
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
}
