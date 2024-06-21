import 'package:flutter/material.dart';
import 'package:hero/modules/auth/auth.dart';
import 'package:hero/modules/forgot-password/forgot-password-binding.dart';
import 'package:hero/modules/forgot-password/forgot-password.dart';
import 'package:hero/modules/home/home.dart';
import 'package:hero/modules/publish_ad/edit_ad_screen.dart';
import 'package:hero/modules/publish_ad/publish_ad.dart';
import 'package:hero/modules/publish_ad/steps/publish_ad_step_four_screen.dart';
import 'package:hero/modules/publish_ad/steps/publish_ad_step_one_screen.dart';
import 'package:hero/modules/registry/login_screen_widget.dart';
import 'package:hero/modules/registry/register_login_screen_widget.dart';
import 'package:hero/modules/modules.dart';
import 'package:get/get.dart';
import 'package:hero/modules/me/cards/payment_screen.dart';
import 'package:hero/shared/shared.dart';
part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(name: Routes.SPLASH, page: () => SplashScreen(), bindings: [
      SplashBinding(),
      HomeBinding(),
      PublishAdBinding(),
    ]),
    GetPage(
        name: Routes.HOME,
        page: () => CommonWidget.getScreenSizeFontFixed(HomeScreen()),
        bindings: [
          HomeBinding(),
          PublishAdBinding()
        ],
        children: [
          GetPage(
              name: Routes.CREATE_AD_STEP_ONE,
              page: () => CommonWidget.getScreenSizeFontFixed(
                  PublishAdStepOneScreen())),
          GetPage(
              name: Routes.CREATE_AD_STEP_TWO,
              binding: AuthBinding(),
              page: () => CommonWidget.getScreenSizeFontFixed(
                  PublishAdStepTwoScreen())),
          GetPage(
              name: Routes.CREATE_AD_STEP_THREE,
              page: () => CommonWidget.getScreenSizeFontFixed(
                  PublishAdStepThreeScreen())),
          GetPage(
              name: Routes.CREATE_AD_STEP_FOUR,
              page: () => CommonWidget.getScreenSizeFontFixed(
                  PublishAdStepFourScreen())),
          GetPage(
              name: Routes.PAYMENT,
              page: () => CommonWidget.getScreenSizeFontFixed(PaymentScreen())),
          GetPage(
              name: Routes.LIST_ADS + Routes.FURNITURE,
              page: () => CommonWidget.getScreenSizeFontFixed(ListAdScreen())),
          GetPage(
              name: Routes.LIST_ADS + Routes.ACTIVITY,
              page: () => CommonWidget.getScreenSizeFontFixed(ListAdScreen())),
          GetPage(
              name: Routes.LIST_ADS + Routes.FRANCHISE,
              page: () => CommonWidget.getScreenSizeFontFixed(ListAdScreen())),
          GetPage(
              name: Routes.LIST_ADS + Routes.SUPPLIER,
              page: () => CommonWidget.getScreenSizeFontFixed(ListAdScreen())),
          GetPage(
              name: Routes.LIST_ADS + Routes.CONSULTANT,
              page: () => CommonWidget.getScreenSizeFontFixed(ListAdScreen())),
          GetPage(
              name: Routes.LIST_ADS + Routes.ENTREPRENEUR,
              page: () => CommonWidget.getScreenSizeFontFixed(ListAdScreen())),
          GetPage(
              name: Routes.LIST_ADS + Routes.ENTREPRENEUR,
              page: () => CommonWidget.getScreenSizeFontFixed(ListAdScreen())),
          GetPage(
              name: Routes.EDIT_AD,
              page: () => CommonWidget.getScreenSizeFontFixed(EditAdScreen())),
          GetPage(
              name: Routes.SHOW_AD,
              page: () => CommonWidget.getScreenSizeFontFixed(ShowAdScreen(
                    color: Colors.red,
                  ))),
        ]),
    GetPage(
        name: Routes.LOGIN,
        binding: AuthBinding(),
        page: () => CommonWidget.getScreenSizeFontFixed(LoginScreenWidget()),
        children: [
          GetPage(
              binding: AuthBinding(),
              name: Routes.REGISTER,
              page: () => RegisterLoginScreenWidget()),
        ]),
    GetPage(
      name: Routes.FORGOTPASSWORD,
      binding: ForgotPasswordBinding(),
      page: () => CommonWidget.getScreenSizeFontFixed(ForgotPasswordPage()),
    ),
  ];
}
