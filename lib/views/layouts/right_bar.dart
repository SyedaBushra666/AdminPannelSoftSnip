import 'package:admin_pannel_monotor/helpers/theme/app_theme.dart';
import 'package:admin_pannel_monotor/helpers/theme/theme_customizer.dart';
import 'package:admin_pannel_monotor/helpers/utils/ui_mixins.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_button.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_spacing.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';
import 'package:admin_pannel_monotor/views/time_sheets/components/member_dropdown.dart';
import 'package:admin_pannel_monotor/views/time_sheets/components/projectc_dropdown.dart';
import 'package:admin_pannel_monotor/views/time_sheets/components/role_dropdown.dart';
import 'package:flutter/material.dart';

// typedef void OnLeftBarColorSchemeChange(LeftBarThemeType leftBarThemeType);
// typedef void OnTopBarColorSchemeChange(TopBarThemeType topBarThemeType);
// typedef void OnRightBarColorSchemeChange(RightBarThemeType topBarThemeType);
// typedef void OnContentSchemeChange(ContentThemeType contentThemeType);

class RightBar extends StatefulWidget {
  // final RightBarThemeType rightBarThemeType;
  // final LeftBarThemeType leftBarThemeType;
  // final TopBarThemeType topBarThemeType;
  // final ContentThemeType contentThemeType;
  // final OnLeftBarColorSchemeChange onLeftBarColorSchemeChange;
  // final OnTopBarColorSchemeChange onTopBarColorSchemeChange;
  // final OnRightBarColorSchemeChange onRightBarColorSchemeChange;
  // final OnContentSchemeChange onContentSchemeChange;

  const RightBar({
    super.key, // this.leftBarThemeType,
  });

  @override
  _RightBarState createState() => _RightBarState();
}

class _RightBarState extends State<RightBar>
    with SingleTickerProviderStateMixin, UIMixin {
  ThemeCustomizer customizer = ThemeCustomizer.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    customizer = ThemeCustomizer.instance;
    return Container(
      width: MediaQuery.of(context).size.width * 0.23,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28.0, vertical: 32),
                  child: MyText.labelLarge(
                    "FILTERS",
                    color: Colors.black,
                    fontWeight: 800,
                    fontSize: 23,
                  ),
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 32),
              //   child: Container(
              //     decoration: const BoxDecoration(
              //       shape: BoxShape.circle,
              //       color: Colors.black,
              //     ),
              //     padding: EdgeInsets.all(4),
              //     child: const Icon(
              //       Icons.clear,
              //       size: 14,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
            ],
          ),
          MySpacing.height(20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // For Members

                MyText.labelMedium(" Select Member"),
                MySpacing.height(8),
                MemberDropdown(),
                MySpacing.height(15),
                // For Projects

                MyText.labelMedium("Select Project"),
                MySpacing.height(8),
                ProjectDropdown(),

                //for timetype

                MySpacing.height(15),
                MyText.labelMedium("Select Role"),
                MySpacing.height(8),
                RoleDropdown(),
                //RoleDropdown()

                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                       Expanded(
            child: MyButton.rounded(
              onPressed: () {
                Navigator.pop(context);
               // onDelete(); // Call the delete logic outside
              },
              elevation: 0,
              padding: MySpacing.xy(20, 16),
              backgroundColor: theme.colorScheme.primary,
              child: MyText.labelMedium(
                "Apply",
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
           SizedBox(width: 5,),
                      Expanded(
                        child: MyButton.rounded(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    elevation: 0,
                                    padding: MySpacing.xy(20, 16),
                                    backgroundColor: theme.colorScheme.secondary,
                                    child: MyText.labelMedium(
                                      "Cancel",
                                      color: theme.colorScheme.onPrimary,
                                    ),
                                  ),
                      ),
                     
         
                    ],
                  ),
                )
              ],
            )),
          ),
        ],
      ),
    );
  }
}
