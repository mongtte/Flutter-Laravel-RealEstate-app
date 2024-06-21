// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/modules/publish_ad/publish_ad_controller.dart';
import 'package:hero/modules/publish_ad/widgets/card_custom_ad.dart';
import 'package:hero/theme/theme_data.dart';

class PostAdFilterProducts extends GetView<PublishAdController> {
  Color color;
  PostAdFilterProducts({this.color = Colors.red});
  @override
  Widget build(BuildContext context) {
    print(
        "====FILTERPRODUCTS LENGTH================= ${controller.filtersProducts.length}");

    return Obx(
      () => controller.filtersProducts.length == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text('no_ad'.tr,
                        textAlign: TextAlign.center, style: ThemeConfig.title1),
                  ),
                  Icon(
                    Icons.desktop_access_disabled_outlined,
                    color: color,
                    size: 100,
                  ),
                ],
              ),
            )
          : Column(
              children: controller.filtersProducts
                  .map<Widget>((post) => CardCustomAd(
                        post,
                        priceColor: color,
                      ))
                  .toList()),
    );
  }
}
