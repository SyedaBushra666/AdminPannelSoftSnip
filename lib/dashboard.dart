import 'package:admin_pannel_monotor/controller/dashboard_controller.dart';
import 'package:admin_pannel_monotor/dashboard/dashboard_members_list.dart';
import 'package:admin_pannel_monotor/dashboard/dashboard_recent_activity.dart';
import 'package:admin_pannel_monotor/dashboard/dashboard_time_chart.dart';
import 'package:admin_pannel_monotor/helpers/theme/app_theme.dart';
import 'package:admin_pannel_monotor/helpers/utils/my_shadow.dart';
import 'package:admin_pannel_monotor/helpers/utils/ui_mixins.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_breadcrumb.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_breadcrumb_item.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_card.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_container.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_flex.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_flex_item.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_list_extension.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_spacing.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';
import 'package:admin_pannel_monotor/helpers/widgets/responsive.dart';
import 'package:admin_pannel_monotor/images.dart';
import 'package:admin_pannel_monotor/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late DashboardController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(DashboardController());
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
                      "dashboard".tr,
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'dashboard'.tr, active: true),
                        MyBreadcrumbItem(name: 'ecommerce'.tr),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(
                  runAlignment: WrapAlignment.start,
                  wrapCrossAlignment: WrapCrossAlignment.start,
                  children: [
                    MyFlexItem(
                        //sizes: "lg-5",
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: buildCard(
                            Colors.blue,
                            Icons.people,
                            "Total Members",
                            "124",
                            "+6 this week",
                          ),
                        ),
                        MySpacing.width(16),
                        Expanded(
                          child: buildCard(
                            Colors.green,
                            Icons.schedule,
                            "Tracked Hours Today",
                            "87h 42m",
                            "+12% vs yesterday",
                          ),
                        ),
                        MySpacing.width(16),
                        Expanded(
                          child: buildCard(
                            Colors.orange,
                            Icons.work_outline,
                            "Active Projects",
                            "15",
                            "3 new this month",
                          ),
                        ),
                        MySpacing.width(16),
                        Expanded(
                          child: buildCard(
                            Colors.purple,
                            Icons.camera_alt,
                            "Screenshots Taken",
                            "1,284",
                            "+8% this week",
                          ),
                        ),
                      ],
                    )),
                    MyFlexItem(
                      child: MyFlex(
                        runAlignment: WrapAlignment.start,
                        wrapCrossAlignment: WrapCrossAlignment.start,
                        contentPadding: false,
                        children: [
                          MyFlexItem(
                            sizes: "lg-8 xl-8",
                            child: MyCard(
                              shadow: MyShadow(elevation: 0.5),
                              paddingAll: 0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Header with Title + Dropdown
                                  Padding(
                                    padding: MySpacing.all(16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: MyText.titleMedium(
                                            "Weekly Time Tracked Overview", // updated title
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: 600,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              LucideIcons.move_right,
                                              size: 20,
                                            ))
                                      ],
                                    ),
                                  ),

                                  const Divider(),
                                  MySpacing.height(12),

                                  // Mini Info Cards (Current/Previous/Prod/Apps)
                                  MyFlex(
                                    children: [
                                      MyFlexItem(
                                        sizes: "lg-3",
                                        child: buildResponseTimeByLocationData(
                                          "Current Week",
                                          "32h 40m",
                                          LucideIcons.clock,
                                          contentTheme.primary,
                                        ),
                                      ),
                                      MyFlexItem(
                                        sizes: "lg-3",
                                        child: buildResponseTimeByLocationData(
                                          "Previous Week",
                                          "28h 20m",
                                          LucideIcons.clock,
                                          contentTheme.red,
                                        ),
                                      ),
                                      MyFlexItem(
                                        sizes: "lg-3",
                                        child: buildResponseTimeByLocationData(
                                          "Avg Activity",
                                          "82%",
                                          LucideIcons.activity,
                                          contentTheme.success,
                                        ),
                                      ),
                                      MyFlexItem(
                                        sizes: "lg-3",
                                        child: buildResponseTimeByLocationData(
                                          "Projects Worked",
                                          "1",
                                          LucideIcons.layout_grid,
                                          contentTheme.warning,
                                        ),
                                      ),
                                    ],
                                  ),

                                  MySpacing.height(12),
                                  const Divider(),
                                  DashboardTimeChart()

                                  
                                ],
                              ),
                            ),
                          ),
                          MyFlexItem(
                              sizes: "lg-4",
                              child: MyCard(
                                shadow: MyShadow(elevation: 0.5),
                                paddingAll: 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        MyText.titleMedium(
                                          "Unusual Activity",
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: 600,
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              LucideIcons.move_right,
                                              size: 20,
                                            ))
                                      ],
                                    ),
                                    SfCircularChart(
                                      tooltipBehavior:
                                          TooltipBehavior(enable: true),
                                      series: <CircularSeries>[
                                        DoughnutSeries<ChartSampleData, String>(
                                            radius: '80%',
                                            explode: true,
                                            explodeOffset: '10%',
                                            dataSource: controller.circleChart,
                                            pointColorMapper:
                                                (ChartSampleData data, _) =>
                                                    data.pointColor,
                                            xValueMapper:
                                                (ChartSampleData data, _) =>
                                                    data.x,
                                            yValueMapper:
                                                (ChartSampleData data, _) =>
                                                    data.y,
                                            dataLabelSettings:
                                                const DataLabelSettings(
                                                    isVisible: true)),
                                      ],
                                    ),
                                    // MySpacing.height(12),
                                    Column(
                                      children: [
                                        MySpacing.height(12),
                                        buildCircleChartData(
                                            const Color.fromRGBO(9, 0, 136, 1),
                                            "Suspicious app / URL",
                                            "9.3% "),
                                        MySpacing.height(8),
                                        buildCircleChartData(
                                            const Color.fromRGBO(
                                                147, 0, 119, 1),
                                            "Low single input keyboard",
                                            "11.3%"),
                                        MySpacing.height(8),
                                        buildCircleChartData(
                                            const Color.fromRGBO(
                                                228, 0, 124, 1),
                                            "Low single input mouse",
                                            "28.5% "),
                                        MySpacing.height(8),
                                        buildCircleChartData(
                                            const Color.fromRGBO(
                                                255, 189, 57, 1),
                                            "Unusually high activity",
                                            "72.2% "),
                                      ],
                                    )
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                    MyFlexItem(
                      child: MyFlex(
                        contentPadding: false,
                        children: [
                          MyFlexItem(
                               sizes: "lg-7 xl-7",
                            child: DashboardRecentActivity()),
                          MyFlexItem(
                             sizes: "lg-5",
                            child: DashboardMembersList()
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

  Widget buildCircleChartData(Color color, String name, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            MyContainer.rounded(
              paddingAll: 4,
              color: color,
            ),
            MySpacing.width(8),
            MyText.bodyMedium(name)
          ],
        ),
        MyText.bodyMedium(price),
      ],
    );
  }

  Widget buildResponseTimeByLocationData(
      String currentTime, String price, IconData icon, Color iconColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.circle_dot_dashed,
              size: 16,
            ),
            MySpacing.width(8),
            MyText.bodyMedium(
              currentTime,
            ),
          ],
        ),
        MySpacing.height(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText.bodyLarge(
              price,
              fontSize: 20,
              fontWeight: 600,
              muted: true,
            ),
            MySpacing.width(8),
            Icon(
              icon,
              size: 16,
              color: iconColor,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildCard(
    Color color,
    IconData icons,
    String title,
    String value,
    String extraInfo,
  ) {
    return MyCard(
      shadow: MyShadow(elevation: 0.5),
      height: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyLarge(
                  title,
                  fontSize: 15,
                  fontWeight: 600,
                ),
                MyText.bodyLarge(
                  value,
                  fontWeight: 600,
                  fontSize: 20,
                ),
                MyText.bodyMedium(
                  extraInfo,
                  muted: true,
                ),
              ],
            ),
          ),
          MyContainer(
            height: 70,
            width: 70,
            paddingAll: 0,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: color.withAlpha(30),
            child: Icon(
              icons,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

