import 'package:get/get.dart';
//import 'package:hero/modules/publish_ad/publish_ad_controller.dart';

import 'home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    // Get.delete<AuthController>();
    Get.put<HomeController>(HomeController(apiRepository: Get.find()));
    // var homeController = Get.find<HomeController>();
    // Get.lazyPut<PublishAdController>(
    //     () => PublishAdController(apiRepository: Get.find(), userStrapi: homeController.userStrapi));
  }
}
