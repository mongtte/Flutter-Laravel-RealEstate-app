// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:hero/models/products/products.dart';
import 'package:hero/modules/publish_ad/publish_ad.dart';
import 'package:hero/modules/publish_ad/widgets/card_custom_ad.dart';
import 'package:hero/theme/theme.dart';

class PostAd extends GetView<PublishAdController> {
  Color color;
  PostAd({this.color = Colors.red});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.allProducts.length == 0
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
              children: controller.allProducts
                  .map<Widget>((post) => CardCustomAd(
                        post,
                        priceColor: color,
                      ))
                  .toList()),
    );
  }
}
