import 'package:hero/modules/publish_ad/publish_ad.dart';
import 'package:hero/routes/routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();
    var postAdController = Get.find<PublishAdController>();
    print("LOADING DATA!!!");
    postAdController.getPostAdHome().then((value) async {
      await postAdController.getAllCategories();
      await Future.delayed(Duration(milliseconds: 1000));
      Get.toNamed(Routes.HOME);
    });
  }
}
