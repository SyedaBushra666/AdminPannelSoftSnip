import 'package:admin_pannel_monotor/helpers/theme/app_theme.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_button.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_spacing.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';
import 'package:admin_pannel_monotor/helpers/widgets/responsive.dart';
import 'package:flutter/material.dart';


void showAlertDialogDelete({
  required BuildContext context,
  required String userName,
  required String userEmail,
  required VoidCallback onDelete,
}) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: MyText.labelLarge("Remove account",fontWeight: 900,fontSize: 18,),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText.bodyMedium("Name: $userName",fontWeight: 600,),
            MySpacing.height(4),
            MyText.bodyMedium("Email: $userEmail",fontWeight: 600,),
            MySpacing.height(flexSpacing),
            MyText.bodyMedium(
              "Are you sure you want to delete this member? This action cannot be undone.",
              fontWeight: 400,
            ),
          ],
        ),
        actions: [
          MyButton.rounded(
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
          MyButton.rounded(
            onPressed: () {
              Navigator.pop(context);
              onDelete(); // Call the delete logic outside
            },
            elevation: 0,
            padding: MySpacing.xy(20, 16),
            backgroundColor: theme.colorScheme.error,
            child: MyText.labelMedium(
              "Delete",
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ],
      );
    },
  );
}
