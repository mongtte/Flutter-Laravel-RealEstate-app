import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/modules/publish_ad/publish_ad_screen.dart';
import 'package:hero/shared/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateAdsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('label3_nav'.tr, style: TextStyle(fontSize: 21.sp, color: Colors.white)),
          backgroundColor: ColorConstants.principalColor,
          //brightness: Brightness.dark,
        ),
        body: PublishAdScreen());
  }
}
