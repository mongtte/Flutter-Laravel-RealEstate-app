// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/lang/translation_service.dart';
import 'package:hero/models/likes.dart';
import 'package:hero/models/multimedia.dart';
//import 'package:hero/models/products/products.dart';
import 'package:hero/modules/home/home.dart';
//import 'package:hero/modules/publish_ad/edit_ad_screen.dart';
import 'package:hero/modules/publish_ad/publish_ad.dart';
import 'package:hero/modules/publish_ad/show_multiple_images.dart';
import 'package:hero/routes/app_pages.dart';
import 'package:hero/shared/constants/colors.dart';
import 'package:hero/shared/shared.dart';

import 'package:hero/theme/theme.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowAdScreen extends StatefulWidget {
  Color? color;
  ShowAdScreen({this.color});

  @override
  State<ShowAdScreen> createState() => _ShowAdScreenState();
}

class _ShowAdScreenState extends State<ShowAdScreen> {
  @override
  void initState() {
    var controller = Get.find<PublishAdController>();
    super.initState();
  }

  Widget build(BuildContext context) {
    var homeController = Get.find<HomeController>();
    var controller = Get.find<PublishAdController>();
    String local = TranslationService.locale.toString();
    timeago.setLocaleMessages(
        'it',
        local.substring(0, 3) == "it_"
            ? timeago.ItMessages()
            : local.substring(0, 3) == "en_"
                ? timeago.EnMessages()
                : timeago.EsMessages());

    Likes? like;

    if (homeController.userLogued()) {
      print("${controller.actualProduct?.toJson()}");
      if (controller.actualProduct?.likes != null &&
          controller.actualProduct!.likes!.length > 0) {
        for (var likeProd in controller.actualProduct!.likes!) {
          if (likeProd.userId == controller.userStrapi.value!.id) {
            like = likeProd;
          }
        }
      }
    }
    bool favoriteIsActive = (like != null);

    print(
        "======LIKES CURRENT PRODUCT====== ${controller.actualProduct?.likes}");
    return WillPopScope(
      onWillPop: () async {
        controller.cleanControllerOnly();
        Get.back();
        Get.toNamed(Routes.HOME);
        //homeController.switchTab(0);

        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: ListView(
                  children: [
                    _buildImages(controller.multimediaProduct),
                    SizedBox(
                      height: 20.h,
                    ),
                    /* InkWell(
                        child: favoriteIsActive
                            ? Icon(Icons.favorite, color: Colors.red, size: 25.sp)
                            : Icon(Icons.favorite_border,
                                color: ColorConstants.darkGray, size: 25.sp),
                        onTap: () async {
                          if (!favoriteIsActive) {
                           
                            await controller
                                .addFavorite(controller.actualProduct!)
                                .then((value) {
                              print("VALUE:  $value");
                              controller.actualProduct!.likes = value!.likes;
                            });
                          } else {
                            await controller
                                .removeFavorite(like!.id!, controller.actualProduct!.id!)
                                .then((value) =>
                                    controller.actualProduct!.likes = value!.likes);
                          }
                          setState(() {
                            favoriteIsActive = !favoriteIsActive;
                          });
                        },
                      ),*/
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    timeago.format(
                                        DateTime.parse(
                                            DateFormat('yyyy-MM-dd HH:mm:ss')
                                                .format(controller
                                                    .actualProduct!
                                                    .createdAt!)),
                                        locale: 'it'),
                                    style: ThemeConfig.subtitle2
                                        .override(fontSize: 14),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    DateFormat('HH:mm').format(
                                        controller.actualProduct!.createdAt!),
                                    style: ThemeConfig.subtitle2
                                        .override(fontSize: 14),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'ID: ',
                                    style: ThemeConfig.subtitle2
                                        .override(fontSize: 14),
                                  ),
                                  Text(
                                    controller.actualProduct!.id.toString(),
                                    style: ThemeConfig.subtitle2
                                        .override(fontSize: 14),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(controller.controllerTitle.text.capitalize!,
                              textAlign: TextAlign.left,
                              style: ThemeConfig.title1),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: ColorConstants.darkGray,
                              ),
                              SizedBox(width: 5),
                              Flexible(
                                child: Text(controller.city,
                                    textAlign: TextAlign.left,
                                    style: ThemeConfig.subtitle1),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                              controller.actualProduct!.price
                                      .toString()
                                      .split(".")[0] +
                                  ' ' +
                                  'coin'.tr,
                              textAlign: TextAlign.left,
                              style: ThemeConfig.title1.override(
                                  color: widget.color,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(height: 20),
                          Text('autor_ad'.tr,
                              textAlign: TextAlign.left,
                              style: ThemeConfig.bodyText1.override(
                                fontSize: 16.sp,
                                color: ColorConstants.darkGray,
                              )),
                          Text(
                              controller
                                  .currentproduct.value.user!.nameLastname!,
                              textAlign: TextAlign.left,
                              style: ThemeConfig.bodyText1),
                          SizedBox(height: 5),
                          Text('subcategory_ad'.tr,
                              textAlign: TextAlign.left,
                              style: ThemeConfig.bodyText1.override(
                                fontSize: 16.sp,
                                color: ColorConstants.darkGray,
                              )),
                          Obx(
                            () => Text(
                                controller.currentproduct.value.subCategory!
                                    .nameEn!.tr,
                                textAlign: TextAlign.left,
                                style: ThemeConfig.bodyText1),
                          ),
                          SizedBox(height: 5),
                          Text('adtype_ad'.tr,
                              textAlign: TextAlign.left,
                              style: ThemeConfig.bodyText1.override(
                                fontSize: 16.sp,
                                color: ColorConstants.darkGray,
                              )),
                          Obx(
                            () => Text(
                                controller.currentproduct.value.adType.tr,
                                textAlign: TextAlign.left,
                                style: ThemeConfig.bodyText1),
                          ),
                          SizedBox(height: 5),
                          Text('peopletype_ad'.tr,
                              textAlign: TextAlign.left,
                              style: ThemeConfig.bodyText1.override(
                                fontSize: 16.sp,
                                color: ColorConstants.darkGray,
                              )),
                          Obx(
                            () => Text(
                                controller.currentproduct.value.peopleType.tr,
                                textAlign: TextAlign.left,
                                style: ThemeConfig.bodyText1),
                          ),
                          SizedBox(height: 5),
                          if (controller.publishAdModel.value.currentCategory ==
                              EnumCategoryList.furniture)
                            Text('condition_ad'.tr,
                                textAlign: TextAlign.left,
                                style: ThemeConfig.bodyText1.override(
                                  fontSize: 16.sp,
                                  color: ColorConstants.darkGray,
                                )),
                          if (controller.publishAdModel.value.currentCategory ==
                              EnumCategoryList.furniture)
                            Text(controller.actualProduct!.statusProduct.tr,
                                textAlign: TextAlign.left,
                                style: ThemeConfig.bodyText1),
                          if (controller.publishAdModel.value.currentCategory ==
                              EnumCategoryList.furniture)
                            SizedBox(height: 5),
                          Text(
                            'description_ad'.tr,
                            textAlign: TextAlign.left,
                            style: ThemeConfig.bodyText1.override(
                              fontSize: 16.sp,
                              color: ColorConstants.darkGray,
                            ),
                          ),
                          Text(controller.controllerDescription.text,
                              textAlign: TextAlign.left,
                              style: ThemeConfig.bodyText1),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    InkWell(
                      child: Card(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 6),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                      ),
                      onTap: () {
                        controller.cleanControllerOnly();
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (controller.actualProduct!.phoneNumber != 0)
                        InkWell(
                          child: Container(
                            height: 50,
                            width: 50,
                            child: ButtonNotFilledSecundary('',
                                icon: Icon(
                                  Icons.call,
                                  color: widget.color,
                                  size: 22,
                                )),
                          ),
                          onTap: () => CommonWidget.previewFilew(
                              'tel:${controller.actualProduct!.phoneNumber}'),
                        ),
                      SizedBox(
                        width: 10,
                      ),
                      if (homeController.userLogued())
                        InkWell(
                            child: Container(
                              height: 50,
                              width: 50,
                              child: ButtonNotFilledSecundary(
                                '',
                                icon: favoriteIsActive
                                    ? Icon(Icons.favorite,
                                        color: Colors.red, size: 22.sp)
                                    : Icon(Icons.favorite_border,
                                        color: ColorConstants.darkGray,
                                        size: 22.sp),
                              ),
                            ),
                            onTap: () async {
                              if (!favoriteIsActive) {
                                await controller
                                    .addFavorite(controller.actualProduct!)
                                    .then((value) {
                                  controller.actualProduct!.likes =
                                      value!.likes;
                                });
                              } else {
                                await controller
                                    .removeFavorite(like!.id!,
                                        controller.actualProduct!.id!)
                                    .then((value) => controller
                                        .actualProduct!.likes = value!.likes);
                              }
                              setState(() {
                                favoriteIsActive = !favoriteIsActive;
                              });
                            }),
                      SizedBox(
                        width: 10,
                      ),
                      if (controller.actualProduct!.phoneNumber != 0)
                        SizedBox(width: 10),
                      controller.userStrapi.value != null &&
                              (controller.actualProduct!.user!.id ==
                                  controller.userStrapi.value!.id) &&
                              controller.actualProduct!.publishedAt != false
                          ? Expanded(
                              child: InkWell(
                                child: Container(
                                  height: 50,
                                  child: ButtonSecundary('edit_ad'.tr,
                                      color: widget.color,
                                      icon: Icon(
                                        Icons.edit,
                                        size: 20,
                                      )),
                                ),
                                onTap: () async {
                                  List<String> subcategoryList =
                                      await controller
                                          .getSubCategoriesByCategory();

                                  controller.setActualProduct(
                                      controller.actualProduct!);
                                  Get.toNamed(Routes.HOME + Routes.EDIT_AD,
                                      arguments: subcategoryList);
                                },
                              ),
                            )
                          : Expanded(
                              child: InkWell(
                                  child: Container(
                                    height: 50,
                                    child: ButtonSecundary('contact_ad'.tr,
                                        color: widget.color,
                                        icon: Icon(
                                          Icons.textsms_outlined,
                                          size: 20,
                                        )),
                                  ),
                                  onTap: () async {
                                    if (controller.userStrapi.value != null) {
                                      homeController.setActualRoom(
                                          controller.actualProduct!);
                                    } else {
                                      CommonWidget.showInfo(local.substring(
                                                  0, 3) ==
                                              "it_"
                                          ? "Devi prima registrarti"
                                          : local.substring(0, 3) == "en_"
                                              ? "You need to be registered"
                                              : "Debes registrarte primero");
                                    }
                                  }),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildImages(List<Multimedia> multimedia) {
    return CarouselSlider(
        options: CarouselOptions(
          height: SizeConfig().screenHeight / 3,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: false,
          autoPlay: false,
          reverse: false,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
        ),
        items: multimedia.map((e) {
          int index = multimedia.indexOf(e) + 1;
          return Stack(children: [
            InkWell(
                child: Container(
                  width: SizeConfig().screenWidth,
                  child: CachedNetworkImage(
                      imageUrl: e.url, fit: BoxFit.fitHeight),
                ),
                //TODO: CAMBIAR COMO SE MUESTRA LA IMG
                onTap: () => Get.to(() => ShowMultipleImages(multimedia))),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Card(
                  color: Colors.transparent,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                    child: Text(
                      '$index/${multimedia.length}',
                      style:
                          ThemeConfig.bodyText1.override(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ]);
        }).toList());
  }

  _showModalCarousel(List<Multimedia> multimedia, int id) {
    return CommonWidget.showModalListImages(Container(
      width: SizeConfig().screenWidth,
      child: CarouselSlider(
          options: CarouselOptions(
            height: 400,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: false,
            autoPlay: false,
            reverse: false,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: false,
            scrollDirection: Axis.horizontal,
          ),
          items: multimedia.map((e) {
            int index = multimedia.indexOf(e) + 1;
            return Stack(children: [
              Center(
                // height: 300,
                child: CachedNetworkImage(imageUrl: e.url, fit: BoxFit.fill),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Card(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 20),
                      child: Text(
                        '$index/${multimedia.length}',
                        style:
                            ThemeConfig.bodyText1.override(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ]);
          }).toList()),
    ));
  }
}




















  /*class ShowAdScreen2 extends GetView<PublishAdController> {
  var homeController = Get.find<HomeController>();
  var controller = Get.find<PublishAdController>();
  Color color;
  ShowAdScreen(this.color);
  @override
  Widget build(BuildContext context) {
    String locale = TranslationService.locale.toString();
    timeago.setLocaleMessages('it',  local.substring(0,3) == "it_" ? timeago.ItMessages() : local.substring(0,3) == "en_"  ? timeago.EnMessages() : timeago.EsMessages()  );
  //LIKES CODIGO================


   Likes? like;
    

    if (homeController.userLogued()) {
      if (controller.actualProduct?.likes != null && controller.actualProduct!.likes!.length > 0) {
  
        for (var likeProd in controller.actualProduct!.likes!) {
          if (likeProd.userId == controller.userStrapi.value!.id) {
            like = likeProd;
          }
        }
      }
    }
    bool favoriteIsActive = like != null;




   print("======LIKES CURRENT PRODUCT====== ${ controller.actualProduct?.likes }");


    return WillPopScope(
      onWillPop: () async {
        controller.cleanControllerOnly();
        Get.back();
        Get.toNamed(Routes.HOME);
        //homeController.switchTab(0);
        
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: ListView(
                  children: [
                    _buildImages(controller.multimediaProduct),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    timeago.format(
                                        DateTime.parse(
                                            DateFormat('yyyy-MM-dd HH:mm:ss')
                                                .format(controller
                                                    .actualProduct!
                                                    .createdAt!)),
                                        locale: 'it'),
                                    style: ThemeConfig.subtitle2
                                        .override(fontSize: 14),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    DateFormat('HH:mm').format(
                                        controller.actualProduct!.createdAt!),
                                    style: ThemeConfig.subtitle2
                                        .override(fontSize: 14),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'ID: ',
                                    style: ThemeConfig.subtitle2
                                        .override(fontSize: 14),
                                  ),
                                  Text(
                                    controller.actualProduct!.id.toString(),
                                    style: ThemeConfig.subtitle2
                                        .override(fontSize: 14),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(controller.controllerTitle.text.capitalize!,
                              textAlign: TextAlign.left,
                              style: ThemeConfig.title1),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: ColorConstants.darkGray,
                              ),
                              SizedBox(width: 5),
                              Flexible(
                                child: Text(controller.city,
                                    textAlign: TextAlign.left,
                                    style: ThemeConfig.subtitle1),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                              controller.actualProduct!.price
                                      .toString()
                                      .split(".")[0] +
                                  ' ' +
                                  'coin'.tr,
                              textAlign: TextAlign.left,
                              style: ThemeConfig.title1.override(
                                  color: color, fontWeight: FontWeight.w600)),
                          SizedBox(height: 20),
                          Text('autor_ad'.tr,
                              textAlign: TextAlign.left,
                              style: ThemeConfig.bodyText1.override(
                                fontSize: 16.sp,
                                color: ColorConstants.darkGray,
                              )),
                          Text(
                              controller
                                  .currentproduct.value.user!.nameLastname!,
                              textAlign: TextAlign.left,
                              style: ThemeConfig.bodyText1),
                          SizedBox(height: 5),
                          Text('subcategory_ad'.tr,
                              textAlign: TextAlign.left,
                              style: ThemeConfig.bodyText1.override(
                                fontSize: 16.sp,
                                color: ColorConstants.darkGray,
                              )),
                          Obx(
                            () => Text(
                                controller.currentproduct.value.subCategory!.nameEn!.tr,
                                textAlign: TextAlign.left,
                                style: ThemeConfig.bodyText1),
                          ),
                          SizedBox(height: 5),
                          Text('adtype_ad'.tr,
                              textAlign: TextAlign.left,
                              style: ThemeConfig.bodyText1.override(
                                fontSize: 16.sp,
                                color: ColorConstants.darkGray,
                              )),
                          Obx(
                            () => Text(controller.currentproduct.value.adType.tr,
                                textAlign: TextAlign.left,
                                style: ThemeConfig.bodyText1),
                          ),
                          SizedBox(height: 5),
                          Text('peopletype_ad'.tr,
                              textAlign: TextAlign.left,
                              style: ThemeConfig.bodyText1.override(
                                fontSize: 16.sp,
                                color: ColorConstants.darkGray,
                              )),
                          Obx(
                            () => Text(
                                controller.currentproduct.value.peopleType.tr,
                                textAlign: TextAlign.left,
                                style: ThemeConfig.bodyText1),
                          ),
                          SizedBox(height: 5),
                          if (controller.publishAdModel.value.currentCategory ==
                              EnumCategoryList.furniture)
                            Text('condition_ad'.tr,
                                textAlign: TextAlign.left,
                                style: ThemeConfig.bodyText1.override(
                                  fontSize: 16.sp,
                                  color: ColorConstants.darkGray,
                                )),
                          if (controller.publishAdModel.value.currentCategory ==
                              EnumCategoryList.furniture)
                            Text(controller.actualProduct!.statusProduct.tr,
                                textAlign: TextAlign.left,
                                style: ThemeConfig.bodyText1),
                          if (controller.publishAdModel.value.currentCategory ==
                              EnumCategoryList.furniture)
                            SizedBox(height: 5),
                          Text('description_ad'.tr,
                              textAlign: TextAlign.left,
                              style: ThemeConfig.bodyText1.override(
                                fontSize: 16.sp,
                                color: ColorConstants.darkGray,
                              ),
                              ),
                          Text(controller.controllerDescription.text,
                              textAlign: TextAlign.left,
                              style: ThemeConfig.bodyText1),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    InkWell(
                      child: Card(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 6),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                      ),
                      onTap: () {
                        controller.cleanControllerOnly();
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (controller.actualProduct!.phoneNumber != 0)
                        InkWell(
                          child: Container(
                            height: 50,
                            width: 50,
                            child: ButtonNotFilledSecundary('',
                                icon: Icon(
                                  Icons.call,
                                  color: color,
                                  size: 22,
                                )),
                          ),
                          onTap: () => CommonWidget.previewFilew(
                              'tel:${controller.actualProduct!.phoneNumber}'),
                        ),
                      if (controller.actualProduct!.phoneNumber != 0)
                        SizedBox(width: 10),
                      controller.userStrapi.value != null &&
                              (controller.actualProduct!.user!.id ==
                                  controller.userStrapi.value!.id) && controller.actualProduct!.publishedAt != false
                          ? Expanded(
                              child: InkWell(
                                child: Container(
                                  height: 50,
                                  child: ButtonSecundary('edit_ad'.tr,
                                      color: color,
                                      icon: Icon(
                                        Icons.edit,
                                        size: 20,
                                      )),
                                ),
                                onTap: () async {
                                  List<String> subcategoryList =
                                      await controller
                                          .getSubCategoriesByCategory();

                                  controller.setActualProduct(
                                      controller.actualProduct!);
                                  Get.toNamed(Routes.HOME + Routes.EDIT_AD,
                                      arguments: subcategoryList);
                                },
                              ),
                            )
                          : Expanded(
                              child: InkWell(
                                  child: Container(
                                    height: 50,
                                    child: ButtonSecundary('contact_ad'.tr,
                                        color: color,
                                        icon: Icon(
                                          Icons.textsms_outlined,
                                          size: 20,
                                        )),
                                  ),
                                  onTap: () {
                                    if (controller.userStrapi.value != null) {
                                      homeController.setActualRoom(
                                          controller.actualProduct!);
                                    } else {
                                      CommonWidget.showInfo(   local.substring(0,3) == "it_" ? "Devi prima registrarti" : local.substring(0,3) == "en_"  ? "You need to be registered" : "Debes registrarte primero");
                                    }
                                  }),
                            )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildImages(List<Multimedia> multimedia) {
    return CarouselSlider(
        options: CarouselOptions(
          height: SizeConfig().screenHeight / 3,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: false,
          autoPlay: false,
          reverse: false,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
        ),
        items: multimedia.map((e) {
          int index = multimedia.indexOf(e) + 1;
          return Stack(children: [
            InkWell(
                child: Container(
                  width: SizeConfig().screenWidth,
                  child: CachedNetworkImage(
                      imageUrl: e.url, fit: BoxFit.fitHeight),
                ),
                //TODO: CAMBIAR COMO SE MUESTRA LA IMG
                onTap: () => Get.to(() => ShowMultipleImages(multimedia))),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Card(
                  color: Colors.transparent,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                    child: Text(
                      '$index/${multimedia.length}',
                      style:
                          ThemeConfig.bodyText1.override(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ]);
        }).toList());
  }

  _showModalCarousel(List<Multimedia> multimedia, int id) {
    return CommonWidget.showModalListImages(Container(
      width: SizeConfig().screenWidth,
      child: CarouselSlider(
          options: CarouselOptions(
            height: 400,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: false,
            autoPlay: false,
            reverse: false,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: false,
            scrollDirection: Axis.horizontal,
          ),
          items: multimedia.map((e) {
            int index = multimedia.indexOf(e) + 1;
            return Stack(children: [
              Center(
                // height: 300,
                child: CachedNetworkImage(imageUrl: e.url, fit: BoxFit.fill),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Card(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 20),
                      child: Text(
                        '$index/${multimedia.length}',
                        style:
                            ThemeConfig.bodyText1.override(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ]);
          }).toList()),
    ));
  }
}*/
