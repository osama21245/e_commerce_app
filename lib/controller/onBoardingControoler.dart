import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:woocommerce_app/core/constant/routesname.dart';
import 'package:woocommerce_app/data/datasource/static/static.dart';

import '../core/constant/services/services.dart';

abstract class onBoardingController extends GetxController {
  next();

  getCurrentPage(int page);
}

class onBoardingControllerImp extends onBoardingController {
  PageController? pagecontroller;
  int? Currentpage = 0;
  MyServices myservises = Get.find();

  @override
  getCurrentPage(int page) {
    Currentpage = page;
    update();
  }

  @override
  next() {
    Currentpage = (Currentpage! + 1);
    pagecontroller?.animateToPage(Currentpage!,
        duration: Duration(milliseconds: 900), curve: Curves.easeInOut);
    if (Currentpage! > onBoardingList.length - 1) {
      myservises.sharedPreferences.setString("step", "1");
      Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  void onInit() {
    pagecontroller = PageController();
    super.onInit();
  }
}
