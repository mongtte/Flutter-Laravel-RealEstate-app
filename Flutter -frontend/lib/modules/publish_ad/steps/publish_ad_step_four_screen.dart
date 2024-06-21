// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hero/api/api.dart';
import 'package:hero/lang/translation_service.dart';
import 'package:hero/modules/publish_ad/publish_ad_controller.dart';
import 'package:hero/modules/publish_ad/widgets/dropdown_button_form.dart';
import 'package:hero/modules/publish_ad/widgets/publish_ad_app_bar.dart';
import 'package:hero/modules/publish_ad/widgets/select_image.dart';
import 'package:hero/modules/registry/widgets/custom_radio_button.dart';
//import 'package:hero/modules/registry/widgets/custom_radio_button.dart';
import 'package:hero/routes/routes.dart';
//import 'package:hero/shared/constants/colors.dart';
import 'package:hero/shared/shared.dart';
import 'package:hero/theme/theme_data.dart';

class PublishAdStepFourScreen extends GetView<PublishAdController> {
  String lang = TranslationService.locale.toString();
  @override
  Widget build(BuildContext context) {
    return PublishAdAppBar(
      body: _bodyBuilder(),
    );
  }

  _bodyBuilder() {
    int i = 0;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 60),
          child: ListView(
            children: [
              TitlePrincipalAds('paid_option'.tr),
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: 20,
              ),
              RadioButtonForm(
                options: paymentList,
                onChanged: (value) {
                  i = paymentList.indexOf(value!);
                  print(i);
                  switch (i) {
                    case 0:
                      controller.price = 0;
                      controller.period = "Free";
                      break;
                    case 1:
                      controller.price =
                          double.parse(controller.priceList[0]['aday_price']);
                      controller.period = "A day";
                      break;
                    case 2:
                      controller.price = double.parse(
                          controller.priceList[0]['oneweek_price']);
                      controller.period = "A week";
                      break;
                    case 3:
                      controller.price = double.parse(
                          controller.priceList[0]['onemonth_price']);
                      controller.period = "A month";
                      break;
                    case 4:
                      controller.price = double.parse(
                          controller.priceList[0]['twomonths_price']);
                      controller.period = "Two months";
                      break;
                    default:
                      controller.price = 0;
                  }
                  print(controller.price);
                },
                defaultOption: paymentList[0],
                optionHeight: 40,
                textStyle: ThemeConfig.bodyText1
                    .override(color: Colors.black, fontSize: 16),
                buttonPosition: RadioButtonPosition.left,
                direction: Axis.vertical,
                radioButtonColor: ColorConstants.principalColor,
                inactiveRadioButtonColor: Color(0x8A000000),
                toggleable: true,
                horizontalAlignment: WrapAlignment.spaceBetween,
                verticalAlignment: WrapCrossAlignment.start,
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  child: Container(
                    height: 50,
                    width: SizeConfig().screenWidth * .45,
                    child: ButtonNotFilledSecundary(
                      lang.substring(0, 3) == "it_"
                          ? "Indietro"
                          : lang.substring(0, 3) == "en_"
                              ? "Go back"
                              : "Volver",
                    ),
                  ),
                  onTap: () {
                    controller.backStep('back');
                  }),
              InkWell(
                  child: Container(
                    height: 50,
                    width: SizeConfig().screenWidth * .45,
                    child: ButtonSecundary(
                      lang.substring(0, 3) == "it_"
                          ? "Avanti"
                          : lang.substring(0, 3) == "en_"
                              ? "Continue"
                              : "Continuar",
                    ),
                  ),
                  onTap: () {
                    Get.toNamed(Routes.HOME + Routes.PAYMENT);
                  })
            ],
          ),
        ),
      ],
    );
  }
}
