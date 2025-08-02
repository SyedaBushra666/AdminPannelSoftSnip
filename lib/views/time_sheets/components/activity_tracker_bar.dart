import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeSegment {
  final TimeOfDay start;
  final TimeOfDay end;
  final Color color;

  TimeSegment({
    required this.start,
    required this.end,
    required this.color,
  });
}

class TimeTrackerBar extends StatelessWidget {
  final List<TimeSegment> segments;

  const TimeTrackerBar({super.key, required this.segments});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomPaint(
              size: Size(constraints.maxWidth, 40),
              painter: _TimeBarPainter(segments: segments),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (index) {
                final time = TimeOfDay(hour: index * 4, minute: 0);
                final formatted = DateFormat('HH:mm').format(
                  DateTime(2025, 1, 1, time.hour, time.minute),
                );
                return Text(formatted,
                    style: const TextStyle(fontSize: 12, color: Colors.grey));
              }),
            ),
          ],
        );
      },
    );
  }
}

class _TimeBarPainter extends CustomPainter {
  final List<TimeSegment> segments;
  _TimeBarPainter({required this.segments});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var segment in segments) {
      final double startX = _timeToPosition(segment.start, size.width);
      final double endX = _timeToPosition(segment.end, size.width);
      final rect = Rect.fromLTRB(startX, 0, endX, size.height);
      paint.color = segment.color;
      canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(4)), paint);
    }

    final borderPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width, size.height), const Radius.circular(6)),
        borderPaint);
  }

  double _timeToPosition(TimeOfDay time, double width) {
    final minutes = time.hour * 60 + time.minute;
    return (minutes / 1440) * width;
  }

  @override
  bool shouldRepaint(covariant _TimeBarPainter oldDelegate) {
    return oldDelegate.segments != segments;
  }
}
