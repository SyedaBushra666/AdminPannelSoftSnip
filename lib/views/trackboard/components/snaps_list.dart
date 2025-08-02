import 'package:admin_pannel_monotor/helpers/utils/my_shadow.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_card.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_container.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_spacing.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';
import 'package:admin_pannel_monotor/images.dart';
import 'package:flutter/material.dart';

class SnapsList extends StatefulWidget {
  const SnapsList({super.key});

  @override
  State<SnapsList> createState() => _SnapsListState();
}

class _SnapsListState extends State<SnapsList> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
    height: 215,
    child: ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: 6,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {}, // use your image path here
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 8.3,
            child: MyCard(
              shadow: MyShadow(elevation: 0.5),
              paddingAll: 0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      MouseRegion(
                         cursor: SystemMouseCursors.click, // 👈 hand cursor
                        child: MyContainer(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          paddingAll: 0,
                          height: 130,
                          child: Image.asset(
                            Images.SnapImage,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      MyContainer(
                        alignment: Alignment.bottomCenter,
                        color: Colors.grey.shade300,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 25),
                              const LinearProgressIndicator(
                                backgroundColor: Colors.white,
                                value: 0.5,
                                color: Colors.green,
                              ),
                              const SizedBox(height: 5),
                              MyText.bodySmall(
                                "54% of 10 minutes",
                                fontWeight: 600,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 110,
                    child: MyContainer(
                      paddingAll: 0,
                      height: 48,
                      width: 160,
                      child: Padding(
                        padding: MySpacing.xy(12, 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyText.bodySmall("SoftSnip Project", fontWeight: 800),
                            MyText.bodySmall(
                              "12:00 am to 12:10 am",
                              fontWeight: 300,
                              fontSize: 12,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 16),
    ),
  );
}

  }
