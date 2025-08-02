import 'package:get/get.dart';

class TimesheetController extends GetxController {
  // This will hold the currently selected date (can be today by default)
  Rx<DateTime> selectedDate = DateTime.now().obs;

  // Optional: Update selected date (used when user picks a date)
  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  // Get Monday of the selected week
  DateTime get startOfWeek =>
      selectedDate.value.subtract(Duration(days: selectedDate.value.weekday - 1));

  // Get Sunday of the selected week
  DateTime get endOfWeek => startOfWeek.add(const Duration(days: 6));

  // You can also expose week days as list of DateTimes
  List<DateTime> get currentWeekDates =>
      List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
}
