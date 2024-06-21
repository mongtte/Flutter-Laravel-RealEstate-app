import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/lang/translation_service.dart';
import 'package:hero/modules/publish_ad/publish_ad.dart';
import 'package:hero/modules/publish_ad/publish_ad_controller.dart';
import 'package:hero/routes/app_pages.dart';
import 'package:hero/shared/catalogs/list_enums.dart';
import 'package:hero/shared/shared.dart';
import 'package:hero/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TypeAdList extends GetView<PublishAdController> {
  int index;
  TypeAdList(this.index);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: CommonWidget.getScreenSizeFontFixed(
      Container(
        child: new Wrap(children: itemsForTypeCategory(context)),
      ),
    ));
  }

  List<Widget> itemsForTypeCategory(BuildContext context) {
    String local = TranslationService.locale.toString();
    return [
      Container(
        height: 40,
        color: controller.currentCat.value.color,
        child: Center(
            child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: index == 1
                  ? Text(
                      local.substring(0, 3) == "it_"
                          ? "${controller.currentCat.value.nameIt} "
                          : local.substring(0, 3) == "en_"
                              ? "${controller.currentCat.value.nameEn}"
                              : "${controller.currentCat.value.nameEs}",
                      style: ThemeConfig.title1
                          .override(color: Colors.white, fontSize: 18.sp),
                    )
                  : Text(
                      local.substring(0, 3) == "it_"
                          ? "PUBBLICARE IN ${controller.currentCat.value.nameIt} "
                          : local.substring(0, 3) == "en_"
                              ? "PUBLISH IN ${controller.currentCat.value.nameEn}"
                              : "PUBLICAR EN ${controller.currentCat.value.nameEs}",
                      style: ThemeConfig.title1
                          .override(color: Colors.white, fontSize: 18.sp),
                    )),
        )),
      ),
      if (controller.validateSellBuy())
        ListTile(
            leading: new Icon(Icons.sell, size: 25),
            title: new Text(index == 1 ? 'find_sell'.tr : 'sell'.tr,
                style: ThemeConfig.subtitle1.override(
                  color: Colors.black,
                )),
            onTap: () async {
              controller.setTypeAdcategory(EnumTypeAdList.sell);
              //CARGAR SUBCATEGORIAS============================
              final subCategoriesOptions =
                  await controller.getSubCategoriesByCategory();
              if (index == 1) {
                controller.getPostAdToFilterScreen(2, 'Sell').then((value) {
                  Get.to(() => ListAdScreen(
                        filter: 'sell'.tr,
                      ));
                });
              } else
                controller.nexStep(Routes.HOME + Routes.CREATE_AD_STEP_ONE,
                    options: subCategoriesOptions);
            }),
      if (controller.validateRent())
        ListTile(
            leading: new Icon(Icons.add_business_sharp, size: 25),
            title: new Text(index == 1 ? 'find_rent2'.tr : 'rent2'.tr,
                style: ThemeConfig.subtitle1.override(
                  color: Colors.black,
                )),
            onTap: () async {
              //CARGAR SUBCATEGORIAS============================
              controller.setTypeAdcategory(EnumTypeAdList.rent2);
              final subCategoriesOptions =
                  await controller.getSubCategoriesByCategory();
              if (index == 1) {
                controller.getPostAdToFilterScreen(2, 'Noleggio').then((value) {
                  Get.to(() => ListAdScreen(
                        filter: 'rent'.tr,
                      ));
                });
              } else
                controller.nexStep(Routes.HOME + Routes.CREATE_AD_STEP_ONE,
                    options: subCategoriesOptions);
            }),
      if (controller.validateRent2())
        ListTile(
            leading: new Icon(Icons.add_business_sharp, size: 25),
            title: new Text(index == 1 ? 'find_rent'.tr : 'rent'.tr,
                style: ThemeConfig.subtitle1.override(
                  color: Colors.black,
                )),
            onTap: () async {
              //CARGAR SUBCATEGORIAS============================
              controller.setTypeAdcategory(EnumTypeAdList.rent);
              final subCategoriesOptions =
                  await controller.getSubCategoriesByCategory();
              if (index == 1) {
                controller.getPostAdToFilterScreen(2, 'Rent').then((value) {
                  Get.to(() => ListAdScreen(
                        filter: 'rent2'.tr,
                      ));
                });
              } else
                controller.nexStep(Routes.HOME + Routes.CREATE_AD_STEP_ONE,
                    options: subCategoriesOptions);
            }),
      if (controller.validateSellBuy())
        ListTile(
            leading: const Icon(Icons.attach_money, size: 25),
            title: new Text(index == 1 ? 'find_buy'.tr : 'buy'.tr,
                style: ThemeConfig.subtitle1.override(
                  color: Colors.black,
                )),
            onTap: () async {
              //CARGAR SUBCATEGORIAS============================
              controller.setTypeAdcategory(EnumTypeAdList.buy);
              final subCategoriesOptions =
                  await controller.getSubCategoriesByCategory();
              if (index == 1) {
                controller.getPostAdToFilterScreen(2, 'Buy').then((value) {
                  Get.to(() => ListAdScreen(
                        filter: 'buy'.tr,
                      ));
                });
              } else
                controller.nexStep(Routes.HOME + Routes.CREATE_AD_STEP_ONE,
                    options: subCategoriesOptions);
            }),
      if (controller.validateFurniture())
        ListTile(
            leading: new Icon(Icons.search, size: 25),
            title: new Text(
                local.substring(0, 3) == "it_"
                    ? "Cerca Fornitore"
                    : local.substring(0, 3) == "en_"
                        ? "Searching a supplier"
                        : "Busco proveedor",
                style: ThemeConfig.subtitle1.override(
                  color: Colors.black,
                )),
            onTap: () async {
              //CARGAR SUBCATEGORIAS============================
              controller.setTypeAdcategory(EnumTypeAdList.search_supplier);
              final subCategoriesOptions =
                  await controller.getSubCategoriesByCategory();
              if (index == 1) {
                controller
                    .getPostAdToFilterScreen(2, 'Searching a supplier')
                    .then((value) {
                  Get.to(() => ListAdScreen(
                        filter: local.substring(0, 3) == "it_"
                            ? "Cerca Fornitore"
                            : local.substring(0, 3) == "en_"
                                ? "Searching a supplier"
                                : "Busco proveedor",
                      ));
                });
              } else
                controller.nexStep(Routes.HOME + Routes.CREATE_AD_STEP_ONE,
                    options: subCategoriesOptions);
            }),
      if (controller.validateFurniture())
        ListTile(
            leading: new Icon(Icons.local_shipping, size: 25),
            title: new Text(
                local.substring(0, 3) == "it_"
                    ? "Sono Fornitore"
                    : local.substring(0, 3) == "en_"
                        ? "I am a supplier"
                        : "Soy proveedor",
                style: ThemeConfig.subtitle1.override(
                  color: Colors.black,
                )),
            onTap: () async {
              //CARGAR SUBCATEGORIAS============================
              controller.setTypeAdcategory(EnumTypeAdList.supplier);
              final subCategoriesOptions =
                  await controller.getSubCategoriesByCategory();
              if (index == 1) {
                controller
                    .getPostAdToFilterScreen(2, 'I am a supplier')
                    .then((value) {
                  Get.to(() => ListAdScreen(
                        filter: local.substring(0, 3) == "it_"
                            ? "Sono Fornitore"
                            : local.substring(0, 3) == "en_"
                                ? "I am a supplier"
                                : "Soy proveedor",
                      ));
                });
              } else
                controller.nexStep(Routes.HOME + Routes.CREATE_AD_STEP_ONE,
                    options: subCategoriesOptions);
            }),
      if (controller.validateConsultant())
        ListTile(
            leading: new Icon(Icons.search, size: 25),
            title: new Text(
                local.substring(0, 3) == "it_"
                    ? "Cerca Consulente"
                    : local.substring(0, 3) == "en_"
                        ? "Searching an adviser"
                        : "Busco asesor",
                style: ThemeConfig.subtitle1.override(
                  color: Colors.black,
                )),
            onTap: () async {
              //CARGAR SUBCATEGORIAS============================
              controller.setTypeAdcategory(EnumTypeAdList.search_consultant);
              final subCategoriesOptions =
                  await controller.getSubCategoriesByCategory();
              if (index == 1) {
                controller
                    .getPostAdToFilterScreen(2, 'Searching an adviser')
                    .then((value) {
                  Get.to(() => ListAdScreen(
                        filter: local.substring(0, 3) == "it_"
                            ? "Cerca Consulente"
                            : local.substring(0, 3) == "en_"
                                ? "Searching an adviser"
                                : "Busco asesor",
                      ));
                });
              } else
                controller.nexStep(Routes.HOME + Routes.CREATE_AD_STEP_ONE,
                    options: subCategoriesOptions);
            }),
      if (controller.validateConsultant())
        ListTile(
            leading: new Icon(Icons.business_center, size: 25),
            title: new Text(
                local.substring(0, 3) == "it_"
                    ? "Sono Consulente"
                    : local.substring(0, 3) == "en_"
                        ? "I am an adviser"
                        : "Soy asesor",
                style: ThemeConfig.subtitle1.override(
                  color: Colors.black,
                )),
            onTap: () async {
              //CARGAR SUBCATEGORIAS============================
              controller.setTypeAdcategory(EnumTypeAdList.consultant);
              final subCategoriesOptions =
                  await controller.getSubCategoriesByCategory();
              if (index == 1) {
                controller
                    .getPostAdToFilterScreen(2, 'I am an adviser')
                    .then((value) {
                  Get.to(() => ListAdScreen(
                        filter: local.substring(0, 3) == "it_"
                            ? "Sono Consulente"
                            : local.substring(0, 3) == "en_"
                                ? "I am an adviser"
                                : "Soy asesor",
                      ));
                });
              } else
                controller.nexStep(Routes.HOME + Routes.CREATE_AD_STEP_ONE,
                    options: subCategoriesOptions);
            }),
      if (controller.validateEntrepreneur())
        ListTile(
            leading: new Icon(Icons.search, size: 25),
            title: new Text(
                local.substring(0, 3) == "it_"
                    ? "Cerca Imprenditore"
                    : local.substring(0, 3) == "en_"
                        ? "Searching an entrepreneur"
                        : "Busco emprendedor",
                style: ThemeConfig.subtitle1.override(
                  color: Colors.black,
                )),
            onTap: () async {
              //CARGAR SUBCATEGORIAS============================
              controller.setTypeAdcategory(EnumTypeAdList.search_entrepreneur);
              final subCategoriesOptions =
                  await controller.getSubCategoriesByCategory();
              if (index == 1) {
                controller
                    .getPostAdToFilterScreen(2, 'Searching an entrepreneur')
                    .then((value) {
                  Get.to(() => ListAdScreen(
                        filter: local.substring(0, 3) == "it_"
                            ? "Cerca Imprenditor"
                            : local.substring(0, 3) == "en_"
                                ? "Searching an entrepreneur"
                                : "Busco emprendedor",
                      ));
                });
              } else
                controller.nexStep(Routes.HOME + Routes.CREATE_AD_STEP_ONE,
                    options: subCategoriesOptions);
            }),
      if (controller.validateEntrepreneur())
        ListTile(
            leading: new Icon(Icons.monetization_on, size: 25),
            title: new Text(
                local.substring(0, 3) == "it_"
                    ? "Sono Imprenditore"
                    : local.substring(0, 3) == "en_"
                        ? "I am entrepreneur"
                        : "Soy emprendedor",
                style: ThemeConfig.subtitle1.override(
                  color: Colors.black,
                )),
            onTap: () async {
              //CARGAR SUBCATEGORIAS============================
              controller.setTypeAdcategory(EnumTypeAdList.entrepreneur);
              final subCategoriesOptions =
                  await controller.getSubCategoriesByCategory();
              if (index == 1) {
                controller
                    .getPostAdToFilterScreen(2, 'I am an entrepreneur')
                    .then((value) {
                  Get.to(() => ListAdScreen(
                        filter: local.substring(0, 3) == "it_"
                            ? "Sono Imprenditore"
                            : local.substring(0, 3) == "en_"
                                ? "I am an entrepreneur"
                                : "Soy emprendedor",
                      ));
                });
              } else
                controller.nexStep(Routes.HOME + Routes.CREATE_AD_STEP_ONE,
                    options: subCategoriesOptions);
            }),
    ];
  }
}
