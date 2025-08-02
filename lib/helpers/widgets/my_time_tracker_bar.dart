import 'package:flutter/material.dart';
import 'dart:math';

class TimeRange {
  final double startHour;
  final double endHour;

  TimeRange(this.startHour, this.endHour);
}

class TimeTrackerBar extends StatefulWidget {
  final List<TimeRange> activeTimes;

  const TimeTrackerBar({Key? key, required this.activeTimes}) : super(key: key);

  @override
  State<TimeTrackerBar> createState() => _TimeTrackerBarState();
}

class _TimeTrackerBarState extends State<TimeTrackerBar> {
  double? hoverX;

  static const double barHeight = 20;
  static const double hourLabelHeight = 20;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final fullWidth = constraints.maxWidth;
        return MouseRegion(
          cursor: hoverX != null
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
          onHover: (event) {
            setState(() {
              hoverX = event.localPosition.dx;
            });
          },
          onExit: (_) => setState(() => hoverX = null),
          child: SizedBox(
            width: fullWidth,
            height: barHeight + hourLabelHeight,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // background bar
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: barHeight,
                  child: Container(color: Colors.grey.shade300),
                ),
                // active segments
                _buildTimeSegments(fullWidth),
                // hour labels
                _buildHourMarkers(fullWidth),
                // hover indicator
                if (hoverX != null)
                  _buildHoverIndicator(fullWidth, hoverX!),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTimeSegments(double fullWidth) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: barHeight,
      child: Stack(
        children: widget.activeTimes.map((range) {
          final left = (range.startHour / 24.0) * fullWidth;
          final right = (range.endHour / 24.0) * fullWidth;
          final width = max(0, right - left);

          return Positioned(
            left: left,
            width: max(0, right - left),
            top: 0,
            bottom: 0,
            child: Container(color: Colors.green),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHourMarkers(double fullWidth) {
    List<Widget> labels = [];
    for (int i = 0; i <= 24; i += 3) {
      final left = (i / 24.0) * fullWidth;
      labels.add(Positioned(
        top: barHeight + 2,
        left: left - 12,
        child: Text('${i.toString().padLeft(2, '0')}:00',
            style: const TextStyle(fontSize: 10)),
      ));
    }
    return Stack(children: labels);
  }

  Widget _buildHoverIndicator(double fullWidth, double currentX) {
    final hour = (currentX / fullWidth) * 24;
    final hourText = "${hour.floor().toString().padLeft(2, '0')}:${((hour - hour.floor()) * 60).floor().toString().padLeft(2, '0')}";

    return Positioned(
      left: currentX - 0.5,
      top: 0,
      bottom: 0,
      child: Column(
        children: [
          const Icon(Icons.access_time, size: 14, color: Colors.black54),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(hourText,
                style: const TextStyle(
                    fontSize: 10, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
