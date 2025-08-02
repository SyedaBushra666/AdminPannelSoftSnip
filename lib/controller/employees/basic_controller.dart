import 'package:admin_pannel_monotor/controller/my_controller.dart';
import 'package:admin_pannel_monotor/helpers/extensions/date_time_extention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


enum Gender {
  male,
  female,
  none;

  const Gender();
}
// enum User {
//   admin,
//   manager,
//   user,
//   other;
//   const User();
// }

enum TextFieldBorderType { outline, underline, none }

enum UserRole {
  admin,
  manager,
  user,
  observer,
}

class Project {
  final String id;
  final String name;

  Project({required this.id, required this.name});
}

class BasicController extends MyController {
  FloatingLabelBehavior floatingLabelBehavior = FloatingLabelBehavior.always;
  TextFieldBorderType borderType = TextFieldBorderType.outline;

  UserRole? selectedRole;

  void onSelectRole(UserRole role) {
    selectedRole = role;
    update(); // or setState(() {}) if not using GetX
  }

  Project? selectedProject;
  List<Project> projectList = [
    Project(id: '1', name: 'Design System'),
    Project(id: '2', name: 'Marketing Website'),
    Project(id: '3', name: 'Internal Tools'),
  ];

  void onSelectProject(Project project) {
    selectedProject = project;
    update(); // or setState() / notifyListeners()
  }

  bool showPassword = false,
      publicStatus = false,
      newsletter = true,
      checked = false;

//
  Gender selectedGender = Gender.male;
  // User selectedUserRole = User.admin;

  bool filled = false;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateTimeRange? selectedDateTimeRange;
  DateTime? selectedDateTime;
  RangeValues rangeSlider = const RangeValues(20, 40);
  double slider1 = 10, slider2 = 50;

  OutlineInputBorder? get inputBorder {
    if (borderType == TextFieldBorderType.underline) {
      return null;
    }

    if (borderType == TextFieldBorderType.none) {
      return const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide.none);
    }
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    );
  }

  void onChangeGender(Gender? value) {
    selectedGender = value ?? selectedGender;
    update();
  }

  //   void onChangeUserRole(User? value) {
  //   selectedUserRole =  value ?? selectedUserRole;
  //   update();
  // }

  void onChangeLabelType(FloatingLabelBehavior value) {
    floatingLabelBehavior = value;
    update();
  }

  void changeNewsletterStatus(bool value) {
    newsletter = value;
    update();
  }

  void onChangeSlider1(double value) {
    slider1 = value;
    update();
  }

  void onChangeSlider2(double value) {
    slider2 = value;
    update();
  }

  void onChangedChecked(bool? value) {
    checked = value ?? checked;
    update();
  }

  void onChangeRangeSlider(RangeValues value) {
    rangeSlider = value;
    update();
  }

  void onChangeBorderType(TextFieldBorderType value) {
    borderType = value;
    if (borderType == TextFieldBorderType.none) {
      filled = true;
    }
    update();
  }

  void onChangedFilledChecked(bool? value) {
    filled = value ?? filled;
    update();
  }

  void changeAccountStatus(bool value) {
    publicStatus = value;
    update();
  }

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  Future<void> pickDate() async {
    final DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      update();
    }
  }

  Future<void> pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
        context: Get.context!, initialTime: selectedTime ?? TimeOfDay.now());
    if (picked != null && picked != selectedTime) {
      selectedTime = picked;
      update();
    }
  }

  Future<void> pickDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
        context: Get.context!,
        initialEntryMode: DatePickerEntryMode.input,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateTimeRange) {
      selectedDateTimeRange = picked;
      update();
    }
  }

  Future<void> pickDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
          context: Get.context!, initialTime: selectedTime ?? TimeOfDay.now());
      if (pickedTime != null) {
        selectedDateTime = pickedDate.applied(pickedTime);
        update();
      }
    }
  }
}
