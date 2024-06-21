// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
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
import 'package:image_picker/image_picker.dart';

class PublishAdStepOneScreen extends GetView<PublishAdController> {
  String lang = TranslationService.locale.toString();

  @override
  Widget build(BuildContext context) {
    return PublishAdAppBar(
      body: _bodyBuilder(
          Get.arguments == null ? controller.defaultList : Get.arguments),
    );
  }

  _bodyBuilder(
    List<String> subCategories,
  ) {
    print("CurrentCatStr from Step 1 ${controller.currentCatStr}");

    List<String>? defaultList = [
      "SubCategory1",
      "SubCategory2",
      "SubCategory3",
      "SubCategory4"
    ];

    /* //=======================PEOPLETYPE===============================
    List<String> itListPeopleType = ['Privato', 'Partita IVA', 'Azienda'];
    List<String> enListPeopleType = ["Private", "IVA", "Agency"];
    List<String> esListPeopleType = ["Privado", "IVA", "Agencia"];

    //=======================ADTYPE===================================
    List<String> buyListIt = ['Vendo', 'Compro', 'Affitto'];
    List<String> proveedorListIt = [
      'Sono Fornitore',
      'Cerco Fornitore',
    ];
    List<String> asesorListIt = [
      'Sono Consulente',
      'Cerco Consulente',
    ];
    List<String> emprendedorListIt = [
      'Sono Imprenditore',
      'Cerco Imprenditore',
    ];

    List<String> buyListEn = ['Sell', 'Buy', 'Rent'];
    List<String> proveedorListEn = [
      'I am a supplier',
      'Searching a supplier',
    ];
    List<String> asesorListEn = [
      'I am an adviser',
      'Searching an adviser',
    ];
    List<String> emprendedorListEn = [
      'I am entrepreneur',
      'Searching an entrepreneur',
    ];

    List<String> buyListEs = ['Vendo', 'Compro', 'Rento'];
    List<String> proveedorListEs = [
      'Soy proveedor',
      'Busco proveedor',
    ];
    List<String> asesorListEs = [
      'Soy asesor',
      'Busco asesor',
    ];
    List<String> emprendedorListEs = [
      'Soy emprendedor',
      'Busco emprendedor',
    ];*/
    return WillPopScope(
        onWillPop: () async {
          //controller.currentCat.value = Category();
          // controller.currentCatStr = "";
          // controller.setCategory(EnumCategoryList.none);
          // controller.getPostAdHome().then((value) {
          Get.toNamed(Routes.HOME);
          // });
          return true;
        },
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 60),
              child: ListView(
                children: [
                  TitlePrincipalAds('adtype_ad'.tr),
                  // DropDownButtonFormAdType(
                  //   listOptions: controller.getListAdType(),
                  //   actualValue: controller.publishAdModel.value.currenTypeAd ==
                  //           EnumTypeAdList.sell
                  //       ? controller.getListAdType()[0]
                  //       : controller.publishAdModel.value.currenTypeAd ==
                  //               EnumTypeAdList.buy
                  //           ? controller.getListAdType()[1]
                  //           : controller.publishAdModel.value.currenTypeAd ==
                  //                   EnumTypeAdList.supplier
                  //               ? controller.getListAdType()[0]
                  //               : controller.publishAdModel.value.currenTypeAd ==
                  //                       EnumTypeAdList.search_supplier
                  //                   ? controller.getListAdType()[1]
                  //                   : controller.publishAdModel.value
                  //                               .currenTypeAd ==
                  //                           EnumTypeAdList.consultant
                  //                       ? controller.getListAdType()[0]
                  //                       : controller.publishAdModel.value
                  //                                   .currenTypeAd ==
                  //                               EnumTypeAdList.search_consultant
                  //                           ? controller.getListAdType()[1]
                  //                           : controller.publishAdModel.value
                  //                                       .currenTypeAd ==
                  //                                   EnumTypeAdList.entrepreneur
                  //                               ? controller.getListAdType()[0]
                  //                               : controller.publishAdModel.value
                  //                                           .currenTypeAd ==
                  //                                       EnumTypeAdList
                  //                                           .search_entrepreneur
                  //                                   ? controller.getListAdType()[1]
                  //                                   : controller.getListAdType()[2],
                  //   type: EnumTypeList.typePerson,
                  // ),
                  RadioButtonForm(
                    options: controller.getTypeAdList(),
                    onChanged: (value) {
                      controller.setTypeAdcategory(
                          getEnumTypeAdFromString(value!),
                          next: false);
                    },
                    defaultOption: controller.getActualTypeAd(),
                    optionHeight: 25,
                    textStyle: ThemeConfig.bodyText1
                        .override(color: Colors.black, fontSize: 16),
                    buttonPosition: RadioButtonPosition.left,
                    direction: controller
                                    .publishAdModel.value.currentCategory ==
                                EnumCategoryList.supplier ||
                            controller.publishAdModel.value.currentCategory ==
                                EnumCategoryList.consultant ||
                            controller.publishAdModel.value.currentCategory ==
                                EnumCategoryList.entrepreneur
                        ? Axis.vertical
                        : Axis.horizontal,
                    radioButtonColor: ColorConstants.principalColor,
                    inactiveRadioButtonColor: Color(0x8A000000),
                    toggleable: false,
                    horizontalAlignment: WrapAlignment.spaceBetween,
                    verticalAlignment: WrapCrossAlignment.start,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TitlePrincipalAds(
                    lang.substring(0, 3) == "it_"
                        ? "Sottocategoria"
                        : lang.substring(0, 3) == "en_"
                            ? "Subcategory"
                            : "Subcategoría",
                  ),
                  DropDownButtonForm(
                    listOptions: subCategories.isEmpty
                        ? [
                            "Sottocategoria 1",
                            "Sottocategoria 2",
                            "Sottocategoria 3",
                            "Sottocategoria 4"
                          ]
                        : subCategories,
                    actualValue: subCategories.isNotEmpty
                        ? subCategories[0]
                        : defaultList[0],
                    type: EnumTypeList.subCategory,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TitlePrincipalAds(
                    lang.substring(0, 3) == "it_"
                        ? "Immagini"
                        : lang.substring(0, 3) == "en_"
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
                          lang.substring(0, 3) == "it_"
                              ? "Indietro"
                              : lang.substring(0, 3) == "en_"
                                  ? "Go back"
                                  : "Volver",
                        ),
                      ),
                      onTap: () {
                        CommonWidget.showModalInfo(
                                lang.substring(0, 3) == "it_"
                                    ? "Sei sicuro di volver abbandonare I\'inserimento"
                                    : lang.substring(0, 3) == "en_"
                                        ? "Are you sure you want to leave the post?"
                                        : "¿Estás seguro de que quieres dejar la publicación?",
                                hasCancel: true)
                            .then((onOK) {
                          if (onOK) {
                            controller.cleanControllers();
                            Get.toNamed(Routes.HOME);
                          }
                        });
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
                        if (controller.imageCount != 0 &&
                            controller.currentSubCatStr !=
                                ('Select'.tr + ":")) {
                          controller
                              .nexStep(Routes.HOME + Routes.CREATE_AD_STEP_TWO);
                        } else if (controller.imageCount == 0) {
                          CommonWidget.showError(
                            lang.substring(0, 3) == "it_"
                                ? "Seleziona una immagini"
                                : lang.substring(0, 3) == "en_"
                                    ? "Select an image"
                                    : "Selecciona una imágen",
                          );
                        } else {
                          {
                            CommonWidget.showError(
                              lang.substring(0, 3) == "it_"
                                  ? "Seleziona una sottocategoria"
                                  : lang.substring(0, 3) == "en_"
                                      ? "Select a subcategory"
                                      : "Selecciona una subcategoría",
                            );
                          }
                        }
                      })
                ],
              ),
            ),
          ],
        ));
  }
}
