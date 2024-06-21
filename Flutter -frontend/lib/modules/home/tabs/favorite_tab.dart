import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/modules/home/home.dart';
import 'package:hero/modules/publish_ad/publish_ad.dart';
import 'package:hero/modules/publish_ad/widgets/card_custom_ad.dart';
import 'package:hero/shared/constants/colors.dart';
import 'package:hero/theme/theme_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteTab extends GetView<PublishAdController> {
  @override
  Widget build(BuildContext context) {
    
    var homeController = Get.find<HomeController>();
    //homeController.getRooms(1);
    if (homeController.userLogued()) {
      controller.getLikedPosts();
    } else {
      if (controller.likedProducts.length > 0) controller.likedProducts.clear();
    }
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('label2_nav'.tr, style: TextStyle(fontSize: 21.sp, color: Colors.white)),
          backgroundColor: ColorConstants.principalColor,
          //brightness: Brightness.dark,
        ),
        body: Obx(
          () => controller.likedProducts.length == 0
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        color: ColorConstants.principalColor,
                        size: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text('no_favorites'.tr,
                            textAlign: TextAlign.center,
                            style: ThemeConfig.title1),
                      ),
                    ],
                  ),
                )
              : ListView(
                  physics: BouncingScrollPhysics(),
                  children: controller.likedProducts
                      .map((post) => CardCustomAd(post))
                      .toList()),
        ));
  }
}
