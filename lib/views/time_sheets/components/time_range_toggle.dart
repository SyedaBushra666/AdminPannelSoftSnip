import 'package:flutter/material.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';

class TimeRangeToggle extends StatefulWidget {
  const TimeRangeToggle({super.key});

  @override
  State<TimeRangeToggle> createState() => _TimeRangeToggleState();
}

class _TimeRangeToggleState extends State<TimeRangeToggle> {
  int selectedIndex = 0;
  final List<String> labels = ["Daily", "Weekly", "Calendar"];
  final double tabWidth = 110;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EBF0),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(labels.length, (index) {
          bool isSelected = selectedIndex == index;

          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: tabWidth,
                height: 34,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: MyText.bodySmall(
                  labels[index],
                  fontSize: 13,
                  fontWeight: isSelected ? 600 : 500,
                  color: isSelected
                      ? Colors.black
                      : Colors.black.withOpacity(0.6),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
