
import 'package:admin_pannel_monotor/models/timezone.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';


class TimeZoneController extends GetxController{


    final List<TimezoneItem> timezones = [
    TimezoneItem("Member's time zone", 'PDT: America - Los Angeles'),
    TimezoneItem("My time zone", 'PDT: America - Los Angeles'),
    TimezoneItem("SoftSnip", 'AWST: Australia - Perth'),
  ];

  Rx<TimezoneItem> selected = Rx<TimezoneItem>(
    TimezoneItem("Member's time zone", 'PDT: America - Los Angeles')
  );

  void setTimezone (TimezoneItem item){
    selected.value = item;
  }

}