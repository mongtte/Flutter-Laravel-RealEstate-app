// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/lang/translation_service.dart';
import 'package:hero/models/models.dart';
import 'package:hero/models/subcategory.dart';
import 'package:hero/modules/home/home_controller.dart';
import 'package:hero/modules/publish_ad/widgets/dropdown_button_form.dart';
//import 'package:hero/modules/publish_ad/widgets/dropdown_google_places.dart';
//import 'package:hero/modules/publish_ad/widgets/postAd.dart';
import 'package:hero/modules/publish_ad/widgets/postAdFiltersProducts.dart';
import 'package:hero/routes/app_pages.dart';
//import 'package:hero/modules/registry/widgets/custom_radio_button.dart';
import 'package:hero/shared/constants/colors.dart';
import 'package:hero/shared/shared.dart';
import 'package:hero/theme/theme.dart';
import 'package:hero/modules/registry/widgets/custom_radio_button.dart';

import 'publish_ad.dart';

class ListAdScreen extends GetView<PublishAdController> {
  bool? conCategoria = true;
  String? filter;
  int? index;

  ListAdScreen({this.conCategoria, this.filter, this.index});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final homeController = Get.find<HomeController>();
        //controller.currentCat.value = Category();
        // controller.currentCatStr = "";
        // controller.setCategory(EnumCategoryList.none);
        // controller.getPostAdHome().then((value) {
        controller.controllerSearch.clear();
        Get.toNamed(Routes.HOME);
        // });
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      InkWell(
                          child: Icon(
                            Icons.arrow_back,
                            color: ColorConstants.darkGray,
                            size: 26,
                          ),
                          onTap: () {
                            // controller.currentCatStr = "";
                            // controller.currentCat.value = Category();
                            // controller.setCategory(EnumCategoryList.none);
                            controller.controllerSearch.clear();
                            Get.toNamed(Routes.HOME);
                          }),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Card(
                          color: Colors.white,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.search,
                                color: ColorConstants.darkGray,
                                size: 26,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: TextFormField(
                                    controller: controller.controllerSearch,
                                    style: ThemeConfig.bodyText1.override(
                                      color: Color(0xFF3C4858),
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    decoration: InputDecoration(
                                        labelText: 'search_anything'.tr,
                                        alignLabelWithHint: true,
                                        labelStyle:
                                            ThemeConfig.bodyText1.override(
                                          color: Color(0xFFB4B4B4),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        border: InputBorder.none,
                                        isDense: true),
                                    onChanged: (text) {
                                      if (text.length > 1) {
                                        index == 1
                                            ? controller.getPostAdFilter(1)
                                            : controller.getPostAdFilter(2);
                                      } else if (text.length == 0) {
                                        index == 1
                                            ? controller.getPostAdFilter(1)
                                            : controller
                                                .getPostAdToFilterScreen(
                                                    2,
                                                    controller.getActualTypeAd(
                                                        index: 1));
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Spacer(),
                      InkWell(
                        child: Obx(
                          () => Container(
                              width: 90,
                              child: index != 1
                                  ? ButtonSecundary('filter'.tr,
                                      color: controller.currentCat.value.color)
                                  : ButtonSecundary('filter'.tr,
                                      color:
                                          controller.currentCat.value.color ??
                                              Color(0xffFA4B00))),
                        ),
                        onTap: () async {
                          //TODO: CONSULTAR SUBCATEGORIAS.
                          if (this.conCategoria == false) {
                            showCategories(context);
                            print(
                                "Done!!!-----------${controller.currentCat.value.color!}");
                          } else {
                            final subCategoriesFilters =
                                await controller.getSubCategoriesByCategory();
                            print(
                                "Done!!!-----------${controller.currentCat.value.color!}");
                            print(subCategoriesFilters);
                            showFullModalInfo(context, subCategoriesFilters);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(children: [
                    PostAdFilterProducts(
                        color: controller.currentCat.value.color == null
                            ? ColorConstants.principalColor
                            : controller.currentCat.value.color!),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showCategories(BuildContext context) {
    print("from showCategories ${controller.currentCatStr}");

    return showModalBottomSheet(
        context: context,
        builder: (ctx) {
          String locale = TranslationService.locale.toString();
          return Column(
            children: [
              SizedBox(
                height: 15,
              ),
              TitlePrincipalAds(locale.substring(0, 3) == "it_"
                  ? 'Seleziona una categoria'
                  : locale.substring(0, 3) == "en_"
                      ? "Select a category"
                      : "Selecciona una categoría"),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: controller.allCategories.length,
                    itemBuilder: (BuildContext context, int index) {
                      Category category = controller.allCategories[index];
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ListTile(
                          onTap: () async {
                            controller.currentCat.value = category;
                            controller.currentCatStr = category.nameEs!;
                            controller.publishAdModel.value
                                .currentCategory = controller.currentCatStr ==
                                    "MUEBLES"
                                ? EnumCategoryList.furniture
                                : controller.currentCatStr == "ACTIVIDAD"
                                    ? EnumCategoryList.activity
                                    : controller.currentCatStr == "FRANQUICIA"
                                        ? EnumCategoryList.franchise
                                        : controller.currentCatStr ==
                                                "PROVEEDOR"
                                            ? EnumCategoryList.supplier
                                            : controller.currentCatStr ==
                                                    "ASESOR"
                                                ? EnumCategoryList.consultant
                                                : controller.currentCatStr ==
                                                        "EMPRENDEDOR"
                                                    ? EnumCategoryList
                                                        .entrepreneur
                                                    : EnumCategoryList
                                                        .furniture;
                            Navigator.pop(context);
                            final subCategoriesFilters =
                                await controller.getSubCategoriesByCategory();

                            showFullModalInfo(context, subCategoriesFilters);
                          },
                          leading: CircleAvatar(
                            backgroundColor: category.color,
                            child: Icon(category.icon, color: Colors.white),
                          ),
                          title: Text(locale.substring(0, 3) == "it_"
                              ? category.nameIt!
                              : locale.substring(0, 3) == "en_"
                                  ? category.nameEn!
                                  : category.nameEs!),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          );
        });
  }

  Future<void> showFullModalInfo(
      BuildContext context, List<String> subCategoriesFilters) async {
    final controller = Get.find<PublishAdController>();
    String lang = TranslationService.locale.toString();
    controller.setCurrentPeopleType();
    controller.setCurrentAdType();
    controller.currentSubCatStr = "";
    controller.currenPeopleTypeStr = "";
    controller.currentAdTypeStr = "";
    controller.controllerPrice.text = "";
    controller.controllerSearch.text = "";
    controller.controllerPriceMax.text = "";

    print(
        "currentPeopleType from showfullModal ${controller.currenPeopleTypeStr} ");
    print("currentAdType from showFullModal ${controller.currentAdTypeStr}");

    await Get.dialog(
      WillPopScope(
        onWillPop: () async {
          controller.currentSubCatStr = "";
          controller.currenPeopleTypeStr = "";
          controller.currentAdTypeStr = "";
          controller.controllerPrice.text = "";
          controller.controllerPriceMax.text = "";
          controller.publishAdModel.value.currenTypeAd = EnumTypeAdList.none;
          Get.to(() => ListAdScreen());
          return true;
        },
        child: AlertDialog(
            title: Text('filter'.tr,
                textScaleFactor: 1,
                style: ThemeConfig.title2.override(
                    color: ColorConstants.principalColor,
                    fontWeight: FontWeight.bold)),
            insetPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            content: Container(
              height: SizeConfig().screenHeight,
              width: SizeConfig().screenWidth,
              child: Stack(children: [
                Container(
                  padding: EdgeInsets.only(bottom: 60),
                  child: ListView(
                    children: [
                      TitlePrincipalAds('write_anything'.tr),
                      TextFormField(
                        controller: controller.controllerSearch,
                        keyboardType: TextInputType.text,
                        style: ThemeConfig.bodyText1.override(
                          color: Color(0xFF3C4858),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        decoration: InputDecoration(
                            labelText: 'write_anything'.tr,
                            labelStyle: ThemeConfig.bodyText1.override(
                              color: Color(0xFFB4B4B4),
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                            border: OutlineInputBorder(),
                            isDense: true,
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 0.7)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFB4B4B4), width: 0.7))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TitlePrincipalAds("adtype_ad".tr),

                      // DropDownButtonFormAdType(
                      //   listOptions: controller.getListAdType(),
                      //   actualValue: controller.getListAdType()[0],
                      //   type: EnumTypeList.typePerson,
                      // ),

                      RadioButtonForm(
                        options: controller.getTypeAdList(),
                        onChanged: (value) {
                          controller.setTypeAdcategory(
                              getEnumTypeAdFromString(value!),
                              next: false);
                          print(value);
                        },
                        defaultOption:
                            controller.publishAdModel.value.currenTypeAd ==
                                    EnumTypeAdList.none
                                ? controller.getTypeAdList()[0]
                                : controller.getActualTypeAd(),
                        optionHeight: 25,
                        textStyle: ThemeConfig.bodyText1
                            .override(color: Colors.black, fontSize: 16),
                        buttonPosition: RadioButtonPosition.left,
                        direction:
                            controller.publishAdModel.value.currentCategory ==
                                        EnumCategoryList.supplier ||
                                    controller.publishAdModel.value
                                            .currentCategory ==
                                        EnumCategoryList.consultant ||
                                    controller.publishAdModel.value
                                            .currentCategory ==
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
                      TitlePrincipalAds('subcategory_ad'.tr),
                      DropDownButtonForm(
                        listOptions: subCategoriesFilters,
                        actualValue: subCategoriesFilters.isNotEmpty
                            ? subCategoriesFilters[0]
                            : "Selezionare: ",
                        type: EnumTypeList.subCategory,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TitlePrincipalAds('peopletype_ad'.tr),
                      DropDownButtonFormPeopleType(
                        listOptions: controller.getListPeopleType(),
                        actualValue: controller.getListPeopleType()[0],
                        type: EnumTypeList.typePerson,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (controller.publishAdModel.value.currentCategory ==
                          EnumCategoryList.furniture)
                        TitlePrincipalAds('condition_ad'.tr),
                      if (controller.publishAdModel.value.currentCategory ==
                          EnumCategoryList.furniture)
                        DropDownButtonFormCondizione(
                          listOptions: controller.getListCondition(),
                          actualValue: controller.getListCondition()[0],
                          type: EnumTypeList.statusProduct,
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      // TitlePrincipalAds('Comune'),
                      // DropDownGooglePlaces(),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      TitlePrincipalAds('money_range'.tr),
                      Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller: controller.controllerPrice,
                              keyboardType: TextInputType.number,
                              style: ThemeConfig.bodyText1.override(
                                color: Color(0xFF3C4858),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              decoration: InputDecoration(
                                  labelText: '0 ' + 'coin'.tr,
                                  labelStyle: ThemeConfig.bodyText1.override(
                                    color: Color(0xFFB4B4B4),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 0.7)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFB4B4B4),
                                          width: 0.7))),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: TextFormField(
                              controller: controller.controllerPriceMax,
                              keyboardType: TextInputType.number,
                              style: ThemeConfig.bodyText1.override(
                                color: Color(0xFF3C4858),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              decoration: InputDecoration(
                                  labelText: '100 ' + 'coin'.tr,
                                  labelStyle: ThemeConfig.bodyText1.override(
                                    color: Color(0xFFB4B4B4),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 0.7)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFB4B4B4),
                                          width: 0.7))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                      child: Container(
                        height: 50,
                        child: ButtonSecundary('apply'.tr,
                            color: controller.currentCat.value.color),
                      ),
                      onTap: () {
                        print(
                            "ffffffffffffff---------${controller.currentAdTypeStr}");
                        print(
                            "ffffffffffffff---------${controller.currenPeopleTypeStr}");
                        print(
                            "ffffffffffffff---------${controller.controllerSearch.text}");
                        print(
                            "ffffffffffffff---------${controller.controllerPrice}");
                        // if (controller.controllerSearch.text != "" &&
                        //     controller.currentSubCatStr !=
                        //         ("Select".tr + ":") &&
                        //     controller.currenPeopleTypeStr !=
                        //         ("Select".tr + ":") &&
                        //     controller.currentCondizioneStr !=
                        //         ("Select".tr + ":") &&
                        //     controller.controllerPrice.text != '' &&
                        //     controller.controllerPriceMax.text != '' &&
                        //     int.parse(controller.controllerPrice.text) <
                        //         int.parse(controller.controllerPriceMax.text)) {
                        Get.back();
                        controller.getPostAdFilter(2).then((value) {});
                        // }
                        // else {
                        //   CommonWidget.showError(lang.substring(0, 3) == "it_"
                        //       ? "Conferma le condizioni del filtro."
                        //       : lang.substring(0, 3) == "en_"
                        //           ? "Please confirm filter condition."
                        //           : "Confirme la condición del filtro.");
                        // }
                      }),
                )
              ]),
            )),
      ),
      barrierDismissible: true,
    );
  }
}
