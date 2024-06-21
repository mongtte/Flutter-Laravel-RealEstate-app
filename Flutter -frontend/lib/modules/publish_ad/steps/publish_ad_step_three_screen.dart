import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/lang/translation_service.dart';
import 'package:hero/modules/publish_ad/publish_ad_controller.dart';
import 'package:hero/modules/publish_ad/widgets/publish_ad_app_bar.dart';
import 'package:hero/modules/publish_ad/widgets/select_image.dart';
import 'package:hero/shared/shared.dart';
import 'package:hero/theme/theme_data.dart';
import 'package:hero/routes/routes.dart';

class PublishAdStepThreeScreen extends GetView<PublishAdController> {
  @override
  Widget build(BuildContext context) {
    String local = TranslationService.locale.toString();

    return PublishAdAppBar(
        body: Stack(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 60),
          child: ListView(
            children: [
              Align(
                alignment: Alignment.center,
                child: TitlePrincipalAds(
                  local.substring(0, 3) == "it_"
                      ? "Conferma il tuo annuncio"
                      : local.substring(0, 3) == "en_"
                          ? "Confirm your ad"
                          : "Confirma tu anuncio",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TitlePrincipalAds(local.substring(0, 3) == "it_"
                  ? "Titolo dell\'annuncio"
                  : local.substring(0, 3) == "en_"
                      ? "Ad title"
                      : "Título del anuncio"),
              Text(
                controller.controllerTitle.text,
                style: ThemeConfig.bodyText1,
              ),
              SizedBox(
                height: 20,
              ),
              TitlePrincipalAds(local.substring(0, 3) == "it_"
                  ? "Testo dell\'annuncio"
                  : local.substring(0, 3) == "en_"
                      ? "Ad description"
                      : "Descripción del anuncio"),
              Text(
                controller.controllerDescription.text,
                style: ThemeConfig.bodyText1,
              ),
              SizedBox(
                height: 20,
              ),
              TitlePrincipalAds("adtype_ad".tr),
              Text(
                controller.getActualTypeAd(),
                style: ThemeConfig.bodyText1,
              ),
              SizedBox(
                height: 20,
              ),
              TitlePrincipalAds(
                local.substring(0, 3) == "it_"
                    ? "Telefono"
                    : local.substring(0, 3) == "en_"
                        ? "Phone number"
                        : "Número telefónico",
              ),
              Text(
                controller.controllerPhone.text,
                style: ThemeConfig.bodyText1,
              ),
              SizedBox(
                height: 20,
              ),
              TitlePrincipalAds('peopletype_ad'.tr),
              Text(
                controller.currenPeopleTypeStr.tr,
                style: ThemeConfig.bodyText1,
              ),
              SizedBox(
                height: 20,
              ),
              TitlePrincipalAds(
                local.substring(0, 3) == "it_"
                    ? "Comune"
                    : local.substring(0, 3) == "en_"
                        ? "Location"
                        : "Ubicación",
              ),
              Text(
                controller.controllerCity.text,
                style: ThemeConfig.bodyText1,
              ),
              SizedBox(
                height: 20,
              ),
              TitlePrincipalAds(
                local.substring(0, 3) == "it_"
                    ? "Prezzo"
                    : local.substring(0, 3) == "en_"
                        ? "Price"
                        : "Precio",
              ),
              Text(
                controller.controllerPrice.text + ' ' + 'coin'.tr,
                style: ThemeConfig.bodyText1,
              ),
              SizedBox(
                height: 20,
              ),
              if (controller.publishAdModel.value.currentCategory ==
                  EnumCategoryList.furniture)
                TitlePrincipalAds(
                  local.substring(0, 3) == "it_"
                      ? "Condizione"
                      : local.substring(0, 3) == "en_"
                          ? "Condition"
                          : "Condición",
                ),
              if (controller.publishAdModel.value.currentCategory ==
                  EnumCategoryList.furniture)
                Text(
                  controller.currentCondizioneStr.tr,
                  style: ThemeConfig.bodyText1,
                ),
              if (controller.publishAdModel.value.currentCategory ==
                  EnumCategoryList.furniture)
                SizedBox(
                  height: 20,
                ),
              TitlePrincipalAds(
                local.substring(0, 3) == "it_"
                    ? "Immagini"
                    : local.substring(0, 3) == "en_"
                        ? "Images"
                        : "Imágenes",
              ),
              SelectImage()
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
                      local.substring(0, 3) == "it_"
                          ? "Indietro"
                          : local.substring(0, 3) == "en_"
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
                    local.substring(0, 3) == "it_"
                        ? "Avanti"
                        : local.substring(0, 3) == "en_"
                            ? "Continue"
                            : "Continuar",
                  ),
                ),
                onTap: () {
                  if (controller.imageCount != 0) {
                    // controller
                    //     .nexStep(Routes.HOME + Routes.CREATE_AD_STEP_FOUR);
                    controller.postAd(context);
                  } else {
                    CommonWidget.showError(
                      local.substring(0, 3) == "it_"
                          ? "Seleziona una immagini"
                          : local.substring(0, 3) == "en_"
                              ? "Select an image"
                              : "Selecciona una imágen",
                    );
                  }
                },
              )
            ],
          ),
        ),
      ],
    ));
  }
}
