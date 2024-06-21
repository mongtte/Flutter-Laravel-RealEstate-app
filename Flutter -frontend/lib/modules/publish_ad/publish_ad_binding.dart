import 'package:get/get.dart';
import 'package:hero/modules/home/home.dart';

import 'publish_ad.dart';

class PublishAdBinding extends Bindings {
  @override
  void dependencies() {
    var homeController = Get.find<HomeController>();
    Get.lazyPut<PublishAdController>(() => PublishAdController(
        apiRepository: Get.find(), userStrapi: homeController.userStrapi));
  }
}
