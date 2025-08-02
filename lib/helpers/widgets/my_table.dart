import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';

class MyCustomTable extends StatelessWidget {
  final List<Widget>? headers; // styled widget headers (e.g. with Column)
  final List<String>? stringHeaders; // fallback for old simple usage
  final List<List<Widget>> rows;
  final double columnSpacing;
  final Color headerColor;
  final EdgeInsets cellPadding;
  final double? fontSize;

  const MyCustomTable({
    super.key,
    this.headers,
    this.stringHeaders,
    required this.rows,
    this.columnSpacing = 20,
    this.headerColor = const Color(0xFFF5F5F5),
    this.cellPadding = const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderRow(),
        const Divider(height: 1),
        SizedBox(
          // Height will auto-size based on rows (or you can customize this)
          height: rows.length * 55,
          child: ListView.separated(
            itemCount: rows.length,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final row = rows[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: List.generate(row.length, (i) {
                    return Expanded(
                      child: Padding(
                        padding: cellPadding,
                        child: row[i],
                      ),
                    );
                  }),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderRow() {
    final headerWidgets = headers ??
        stringHeaders?.map(
          (h) => MyText.labelMedium(h, fontSize: fontSize, fontWeight: 700),
        ).toList() ??
        [];

    return Container(
      color: headerColor,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: List.generate(headerWidgets.length, (i) {
          return Expanded(
            child: Padding(
              padding: cellPadding,
              child: headerWidgets[i],
            ),
          );
        }),
      ),
    );
  }
}
