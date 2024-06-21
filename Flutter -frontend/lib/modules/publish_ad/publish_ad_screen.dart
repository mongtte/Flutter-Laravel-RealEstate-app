import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:hero/modules/home/home.dart';
import 'package:hero/routes/app_pages.dart';
import 'package:hero/shared/constants/colors.dart';
import 'package:hero/shared/shared.dart';
import 'package:hero/theme/theme.dart';
import 'publish_ad.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PublishAdScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    //controller.getRooms(1);
    return controller.userLogued()
        ? PublishAdStepZeroScreen()
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.report_gmailerrorred_outlined,
                  color: ColorConstants.principalColor,
                  size: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('should_register1'.tr, style: ThemeConfig.title1),
                    SizedBox(
                      width: 2.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.LOGIN);
                      },
                      child: Text("should_register2".tr,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.sp,
                              decoration: TextDecoration.underline)),
                    )
                  ],
                ),
              ],
            ),
          );
  }
}
