// controllers/time_type_controller.dart
import 'package:get/get.dart';

enum TimeType {
  normal,
  idle,
  resumed,
  manual,
}

class TimeTypeController extends GetxController {
  final selectedTimeType = TimeType.normal.obs;
  
  void setTimeType(TimeType type) {
    selectedTimeType.value = type;
  }
  
  String get currentTimeTypeName {
    return selectedTimeType.value.toString().split('.').last.capitalizeFirst!;
  }
}