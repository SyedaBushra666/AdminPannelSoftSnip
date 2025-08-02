import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class WorkingHoursCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
      SfCalendar(
        view: CalendarView.day,
        timeSlotViewSettings: TimeSlotViewSettings(
          startHour: 0,
          endHour: 24,
          timeIntervalHeight: 30,
          timeFormat: 'h a',
        ),
        dataSource: _getDataSource(), // Optional
     
    );
  }

  // Optional: Sample data source showing example work hours per day
  MeetingDataSource _getDataSource() {
    final List<Appointment> appointments = <Appointment>[];

    // Assume user worked 9-12 on Monday, 10-4 on Tuesday, etc.
    final DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      final DateTime date = today.subtract(Duration(days: today.weekday - 1 - i));
      appointments.add(
        Appointment(
          startTime: date.add(Duration(hours: 9)),
          endTime: date.add(Duration(hours: 17)),
          subject: ' Activity % ',
          color: Colors.green.withOpacity(0.4),
          isAllDay: false,
        ),
      );
    }

    return MeetingDataSource(appointments);
  }
}

// Simple DataSource for appointments
class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
