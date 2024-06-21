import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/lang/translation_service.dart';
import 'package:hero/modules/home/home.dart';
import 'package:hero/shared/constants/colors.dart';
import 'package:hero/shared/shared.dart';
import 'package:hero/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Me extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    String local = TranslationService.locale.toString();

    return CommonWidget.getScreenSizeFontFixed(
      Scaffold(
        appBar: AppBar(
          title: Text(
            local.substring(0, 3) == "it_"
                ? "Impostazioni"
                : local.substring(0, 3) == "en_"
                    ? "Settings"
                    : "Ajustes",
            style: TextStyle(color: ColorConstants.white, fontSize: 20.sp),
          ),
          backgroundColor: ColorConstants.principalColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, size: 20, color: ColorConstants.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          iconTheme: IconThemeData(color: ColorConstants.titlePrincipal),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                  child: Text(
                    local.substring(0, 3) == "it_"
                        ? "Log out"
                        : local.substring(0, 3) == "en_"
                            ? "Log out"
                            : "Cerrar sesión",
                    style: ThemeConfig.bodyText1.override(
                      color: ColorConstants.titlePrincipal,
                      fontSize: 24,
                      // fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    controller.signout();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
