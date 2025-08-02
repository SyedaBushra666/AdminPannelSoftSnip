import 'package:admin_pannel_monotor/helpers/widgets/my_container.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_spacing.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum DateViewType { today, week }

class DateDropdown extends StatefulWidget {
  final DateViewType viewType;

  const DateDropdown({super.key, this.viewType = DateViewType.today});

  @override
  State<DateDropdown> createState() => _DateDropdownState();
}

class _DateDropdownState extends State<DateDropdown> {
  DateTime selectedDate = DateTime.now();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isDropdownOpen = false;

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isDropdownOpen = true);
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    setState(() => _isDropdownOpen = false);
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size buttonSize = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    double screenWidth = MediaQuery.of(context).size.width;

    double availableRight = screenWidth - offset.dx;
    double popupWidth = 360;

    bool showOnRight = availableRight >= popupWidth || availableRight > offset.dx;

    return OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _closeDropdown,
        child: Stack(
          children: [
            Positioned(
              left: showOnRight ? offset.dx : null,
              right: showOnRight ? null : screenWidth - offset.dx - buttonSize.width,
              top: offset.dy + buttonSize.height + 8,
              width: popupWidth,
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                child: SizedBox(
                  height: 360,
                  child: CalendarDatePicker(
                    initialDate: selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                    onDateChanged: (date) {
                      setState(() => selectedDate = date);
                      _closeDropdown();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Get week start and end for display
  String _formatDateRange(DateTime date) {
    DateTime start = date.subtract(Duration(days: date.weekday - 1)); // Monday
    DateTime end = start.add(const Duration(days: 6)); // Sunday

    String startStr = DateFormat('MMM d, y').format(start);
    String endStr = DateFormat('MMM d, y').format(end);

    return '$startStr - $endStr';
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MyContainer(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        onTap: _toggleDropdown,
        bordered: true,
        child: Row(
          children: [
            MyContainer(
              paddingAll: 0,
              onTap: () => setState(() {
                selectedDate = selectedDate.subtract(const Duration(days: 1));
              }),
              borderRadius: BorderRadius.circular(4),
              child: const Icon(Icons.arrow_back, size: 20, color: Colors.black),
            ),
            MySpacing.width(8),
            const Icon(Icons.date_range, size: 16, color: Colors.black),
            MySpacing.width(8),
            MyText.bodyMedium(
              widget.viewType == DateViewType.today
                  ? DateFormat('EEEE, MMM d, y').format(selectedDate)
                  : _formatDateRange(selectedDate),
              fontWeight: 500,
              color: Colors.black,
            ),
            MySpacing.width(8),
            InkWell(
              onTap: () => setState(() {
                selectedDate = selectedDate.add(const Duration(days: 1));
              }),
              borderRadius: BorderRadius.circular(4),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Icon(Icons.arrow_forward, size: 20, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
