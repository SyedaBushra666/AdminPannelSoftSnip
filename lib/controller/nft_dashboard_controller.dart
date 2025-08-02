

import 'package:admin_pannel_monotor/controller/my_controller.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text_utils.dart';

class NFTDashboardController extends MyController {
  List<String> dummyTexts =
      List.generate(12, (index) => MyTextUtils.getDummyText(60));

  //List<NFTDashboardModel> nftDashboards = [];

  @override
  void onInit() {
    super.onInit();
   // NFTDashboardModel.dummyList.then((value) {
     // nftDashboards = value.sublist(0, 4);
    //  update();

    //}
    //);
  }
}
