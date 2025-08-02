import 'package:admin_pannel_monotor/controller/my_controller.dart';
import 'package:admin_pannel_monotor/helpers/utils/my_utils.dart';
import 'package:admin_pannel_monotor/views/time_sheets/daily_timesheet.dart';
import 'package:flutter/material.dart';
class ContactsController extends MyController {
  //List<Contacts> contacts = [];
  DataTableSource? data;

  ContactsController();

  List<String> dummyTexts =
      List.generate(12, (index) => MyTextUtils.getDummyText(60));

  @override
  void onInit() {
    super.onInit();
    // Contacts.dummyList.then((value) {
    //   contacts = value.sublist(0, 20);
    //   data = ContactsData(contacts);
    //   update();
    // });
  }
}
