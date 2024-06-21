// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hero/lang/translation_service.dart';
import 'package:hero/models/prices/prices.dart';
import 'package:hero/models/products/products.dart';
import 'package:hero/modules/home/edit_profile.dart';
import 'package:hero/modules/home/home.dart';
import 'package:hero/modules/me/me.dart';
//import 'package:hero/modules/publish_ad/edit_ad_screen.dart';
import 'package:hero/modules/publish_ad/publish_ad.dart';
import 'package:hero/modules/registry/enter_login_screen_widget.dart';
import 'package:get/get.dart';
import 'package:hero/modules/registry/widgets/button_continue_widget.dart';
import 'package:hero/routes/app_pages.dart';
import 'package:hero/shared/catalogs/list_enums.dart';
import 'package:hero/shared/utils/common_widget.dart';
//import 'package:hero/shared/utils/focus.dart';
import 'package:hero/shared/utils/size_config.dart';
import 'package:hero/shared/widgets/checkout.dart';
import 'package:hero/shared/widgets/custom_widgets.dart';
import 'package:hero/theme/theme.dart';
import 'package:hero/shared/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MeTab extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    //controller.getRooms(1);
    return Scaffold(
        appBar: AppBar(
          title: Text('my_account'.tr,
              style: TextStyle(fontSize: 21.sp, color: Colors.white)),
          backgroundColor: ColorConstants.principalColor,
          //brightness: Brightness.dark,
          automaticallyImplyLeading: false,
          actions: [
            if (controller.userLogued())
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.to(() => EditProfile());
                      },
                      icon: Icon(Icons.edit, size: 20.sp)),
                  IconButton(
                      onPressed: () {
                        CommonWidget.showModalAlert('sign_alert2'.tr, context)
                            .then((value) {
                          if (value == true) {
                            controller.signout();
                          }
                        });
                      },
                      icon: Icon(Icons.logout_outlined, size: 20.sp))
                ],
              )
          ],
        ),
        body: controller.userLogued()
            ? ProfileAuthenticated() //Center(child: Text("autenticado"))
            : EnterLoginScreenWidget() //Center(child: Text("no autenticado")) ,
        );
  }
}

class ProfileAuthenticated extends GetView<HomeController> {
  ProfileAuthenticated({Key? key}) : super(key: key);
  var controllerPublishAd = Get.find<PublishAdController>();

  @override
  Widget build(BuildContext context) {
    String local = TranslationService.locale.toString();

    controllerPublishAd.setCategory(EnumCategoryList.none);
    if (controller.userLogued()) {
      controllerPublishAd.getMyPostListAd();
      print(controller.userStrapi.value!);
    }

    return Obx(() => ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                  border: Border.all(
                width: .5,
                color: Colors.yellow,
              )),
              child: InkWell(
                child: Row(
                  children: [
                    if (controller.userLogued())
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: ColorConstants.lightGray),
                        child: Center(
                            child: Obx(
                          () => Text(
                            controller.userStrapi.value?.nameLastname
                                    .toString()[0]
                                    .toUpperCase() ??
                                "",
                            style: ThemeConfig.bodyText1.override(
                              color: ColorConstants.titleSecundary,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                      ),
                    SizedBox(width: 10),
                    if (controller.userLogued())
                      Obx(() {
                        return Text(
                          controller.userStrapi.value!.nameLastname.toString(),
                          style: ThemeConfig.bodyText1.override(
                            color: ColorConstants.titlePrincipal,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      })
                  ],
                ),
              ),
            ),
            if (controller.userLogued())
              Obx(() => controllerPublishAd.myProducts.length == 0
                  ? Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: Image.asset(
                            'assets/images/icon_create_ad.PNG',
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          local.substring(0, 3) == "it_"
                              ? "Non hai ancora inserito annunci"
                              : local.substring(0, 3) == "en_"
                                  ? "You have not published any ads"
                                  : "No haz publicado ningún anuncio",
                          textAlign: TextAlign.center,
                          style: ThemeConfig.bodyText1.override(
                            color: ColorConstants.titlePrincipal,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: 250,
                          child: InkWell(
                            onTap: () => controller.switchTab(controller
                                .getCurrentIndex(MainTabs.create_ads)),
                            child: ButtonContinueWidget(
                                labelButton: local.substring(0, 3) == "it_"
                                    ? "Inserisci Annuncio"
                                    : local.substring(0, 3) == "en_"
                                        ? "Publish ad"
                                        : "Publicar anuncio",
                                fontSize: 20),
                          ),
                        )
                      ],
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            local.substring(0, 3) == "it_"
                                ? "Annunci Pubblicati"
                                : local.substring(0, 3) == "en_"
                                    ? "Published Ads"
                                    : "Anuncios publicados",
                            textAlign: TextAlign.center,
                            style: ThemeConfig.bodyText1.override(
                              color: ColorConstants.principalColor,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Column(
                          children: _buildAdsList(
                              controllerPublishAd.myProducts, context),
                        ),
                      ],
                    ))
          ],
        ));
  }

  _buildAdsList(List<Products> myProducts, BuildContext context) {
    String local = TranslationService.locale.toString();

    return myProducts.map<Widget>((product) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(
          width: .5,
          color: Colors.grey.shade400,
        )),
        child: Row(
          children: [
            Card(
                color: Colors.grey.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Colors.grey.shade300,
                    width: .8,
                  ),
                ),
                child: product.status == "published"
                    ? Container(
                        height: 50,
                        width: 60,
                        child: product.multimedia == null
                            ? Center(
                                child: SvgPicture.asset(
                                'assets/svgs/icon_inbox.svg',
                                color: Colors.grey.shade400,
                                width: 30,
                              ))
                            : CachedNetworkImage(
                                imageUrl: product.multimedia!.first.url,
                                fit: BoxFit.cover),
                      )
                    : ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Colors.grey,
                          BlendMode.saturation,
                        ),
                        child: Container(
                          height: 50,
                          width: 60,
                          child: product.multimedia == null
                              ? Center(
                                  child: SvgPicture.asset(
                                  'assets/svgs/icon_inbox.svg',
                                  color: Colors.grey.shade400,
                                  width: 30,
                                ))
                              : CachedNetworkImage(
                                  imageUrl: product.multimedia?.first.url ??
                                      "https://bitsofco.de/content/images/2018/12/broken-1.png",
                                  fit: BoxFit.cover),
                        ),
                      )),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: InkWell(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    product.title,
                    style: ThemeConfig.title3,
                  ),
                ),
                onTap: () {
                  controllerPublishAd.setActualProduct(product);
                  controllerPublishAd.setCurrentProduct(product);
                  controllerPublishAd.currentCat.value =
                      product.subCategory!.category!;
                  controllerPublishAd.currentCatStr =
                      product.subCategory!.category!.nameEs!;
                  Get.to(() => ShowAdScreen(
                        color: Colors.red,
                      ));
                },
              ),
            ),
            if (product.publishedAt == false)
              Text(
                  local.substring(0, 3) == "it_"
                      ? "In revisione"
                      : local.substring(0, 3) == "en_"
                          ? "Under review"
                          : "En revisión",
                  style: ThemeConfig.title3
                      .copyWith(fontSize: 15, fontWeight: FontWeight.bold)),
            // if (product.publishedAt == true && product.status == "published")
            //   IconButton(
            //       onPressed: () async {
            //         final adController = Get.find<PublishAdController>();
            //         final prices = await adController.getPricesList();

            //         showPricesDialog(context, prices, product);
            //       },
            //       icon: Icon(Icons.arrow_circle_up, color: Colors.blue)),
            if (product.publishedAt == true)
              InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(
                      Icons.edit,
                      color: ColorConstants.titleSecundary,
                      size: 25,
                    ),
                  ),
                  onTap: () async {
                    controllerPublishAd.currentCat.value =
                        product.subCategory!.category!;
                    controllerPublishAd.currentCatStr =
                        product.subCategory!.category!.nameEs!;
                    List<String> subcategoryList =
                        await controllerPublishAd.getSubCategoriesByCategory();
                    controllerPublishAd.setActualProduct(product);
                    Get.toNamed(Routes.HOME + Routes.EDIT_AD,
                        arguments: subcategoryList);
                  }),
            if (product.publishedAt == true)
              InkWell(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: product.status != 'draft'
                          ? Icon(
                              Icons.pause,
                              color: ColorConstants.darkGray,
                              size: 25,
                            )
                          : Icon(
                              Icons.play_arrow_sharp,
                              color: ColorConstants.principalColor,
                              size: 25,
                            )),
                  onTap: () {
                    product.status != 'draft'
                        ? CommonWidget.showModalInfo(
                                local.substring(0, 3) == "it_"
                                    ? "Sei sicuro di mettere in pausa il tuo annuncio?"
                                    : local.substring(0, 3) == "en_"
                                        ? "Are you sure you want to pause this ad?"
                                        : "¿Estás seguro que deseas pausar este anuncio?",
                                hasCancel: true)
                            .then((onOK) {
                            if (onOK) {
                              controllerPublishAd.disabledProduct(product);
                              //TODO: ACTUALIZAR PRODUCTOS Y HOME
                              /*Future.delayed(Duration(seconds: 2), () {
                               controllerPublishAd.getAllPostAd();
                            });*/
                            }
                          })
                        : CommonWidget.showModalInfo(
                                local.substring(0, 3) == "it_"
                                    ? "Sei sicuro di pubblicare il tuo annuncio?"
                                    : local.substring(0, 3) == "en_"
                                        ? "Are you sure you want to publish this ad?"
                                        : "¿Estás seguro que deseas publicar este anuncio?",
                                hasCancel: true)
                            .then((onOK) {
                            if (onOK) {
                              controllerPublishAd.publishProduct(product);
                              /*Future.delayed(Duration(seconds: 2), () {
                               controllerPublishAd.getAllPostAd();
                            });*/
                            }
                          });
                  }),
            if (product.publishedAt == true)
              InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 25,
                    ),
                  ),
                  onTap: () {
                    CommonWidget.showModalInfo(
                            local.substring(0, 3) == "it_"
                                ? "Sei sicuro di eliminare definitivamente il tuo annuncio?"
                                : local.substring(0, 3) == "en_"
                                    ? "Are you sure you want to delete this ad?"
                                    : "¿Estás seguro que deseas eliminar este anuncio?",
                            hasCancel: true)
                        .then((onOK) {
                      if (onOK) {
                        controllerPublishAd.removeProduct(product);
                      }
                    });
                  })
          ],
        ),
      );
    }).toList();
  }

  Future<void> showPricesDialog(
      BuildContext context, Prices prices, Products product) async {
    String local = TranslationService.locale.toString();

    await Get.dialog(
      WillPopScope(
        onWillPop: () async {
          print("Back!!");
          return true;
        },
        child: AlertDialog(
            title: Center(
              child: Text('Upgrade Prices',
                  textScaleFactor: 1,
                  style: ThemeConfig.title2.override(
                      color: ColorConstants.principalColor,
                      fontWeight: FontWeight.bold)),
            ),
            insetPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            content: Container(
              height: SizeConfig().screenHeight,
              width: SizeConfig().screenWidth,
              child: Stack(children: [
                Container(
                  padding: EdgeInsets.only(bottom: 60),
                  child: ListView(
                    children: [
                      TitlePrincipalAds(local.substring(0, 3) == "it_"
                          ? "Primo Pacchetto"
                          : local.substring(0, 3) == "en_"
                              ? "1rst Pack"
                              : "1er paquete"),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 90,
                        child: TextButton(
                            onPressed: () async {
                              final url = await controllerPublishAd.getCheckout(
                                  1, product);
                              Get.to(() => Checkout(
                                    callback: (endpoint) {
                                      Get.back();
                                      Get.back();
                                      controllerPublishAd
                                          .confirmCheckout(endpoint);
                                    },
                                    url: url,
                                  ));
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: ColorConstants.principalColor,
                            ),
                            child: Text(
                              local.substring(0, 3) == "it_"
                                  ? " Posiziona il tuo annuncio all'inizio, ogni ${prices.firstOptionDays} giorni per ${prices.firstOptionDuration} giorni / Costo: ${prices.firstOptionPrice} euro "
                                  : local.substring(0, 3) == "en_"
                                      ? "Position your ad at the beginning, every ${prices.firstOptionDays} days for ${prices.firstOptionDuration} days / Cost: ${prices.firstOptionPrice} euros "
                                      : "Posiciona tu anuncio al principio, cada ${prices.firstOptionDays} días durante ${prices.firstOptionDuration} días / Costo: ${prices.firstOptionPrice} euros",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.0.sp),
                            )),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TitlePrincipalAds(local.substring(0, 3) == "it_"
                          ? "Secondo Pacchetto"
                          : local.substring(0, 3) == "en_"
                              ? "2nd Pack"
                              : "2do Paquete"),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 90,
                        child: TextButton(
                            onPressed: () async {
                              final url = await controllerPublishAd.getCheckout(
                                  2, product);
                              Get.to(() => Checkout(
                                    callback: (endpoint) {
                                      Get.back();
                                      Get.back();
                                      controllerPublishAd
                                          .confirmCheckout(endpoint);
                                    },
                                    url: url,
                                  ));
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: ColorConstants.principalColor),
                            child: Text(
                              local.substring(0, 3) == "it_"
                                  ? " Posiziona il tuo annuncio all'inizio, ogni ${prices.secondOptionDays} giorni per ${prices.secondOptionDuration} giorni / Costo: ${prices.secondOptionPrice} euro "
                                  : local.substring(0, 3) == "en_"
                                      ? "Position your ad at the beginning, every ${prices.secondOptionDays} days for ${prices.secondOptionDuration} days / Cost: ${prices.secondOptionPrice} euros "
                                      : "Posiciona tu anuncio al principio, cada ${prices.secondOptionDays} días durante ${prices.secondOptionDuration} días / Costo: ${prices.secondOptionPrice} euros",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.0.sp),
                            )),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TitlePrincipalAds(local.substring(0, 3) == "it_"
                          ? "Terzo Pacchetto"
                          : local.substring(0, 3) == "en_"
                              ? "3rd Pack"
                              : "3er Paquete"),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 90,
                        child: TextButton(
                            onPressed: () async {
                              final url = await controllerPublishAd.getCheckout(
                                  3, product);
                              Get.to(() => Checkout(
                                    callback: (endpoint) {
                                      Get.back();
                                      Get.back();
                                      controllerPublishAd
                                          .confirmCheckout(endpoint);
                                    },
                                    url: url,
                                  ));
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: ColorConstants.principalColor),
                            child: Text(
                              local.substring(0, 3) == "it_"
                                  ? " Posiziona il tuo annuncio ${prices.thirdOptionDays} volta al giorno per ${prices.thirdOptionDuration} giorni / Costo: ${prices.thirdOptionPrice} euro "
                                  : local.substring(0, 3) == "en_"
                                      ? "Position your ad ${prices.thirdOptionDays} time a day  for ${prices.thirdOptionDuration} days / Cost: ${prices.thirdOptionPrice} euros"
                                      : "Posiciona tu anuncio ${prices.thirdOptionDays} vez al día durante ${prices.thirdOptionDuration} días / Costo: ${prices.thirdOptionPrice} euros",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.0.sp),
                            )),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
                /*Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                      child: Container(
                        height: 50,
                        child: ButtonSecundary('Applica',
                            color: controller.currentCat.value.color),
                      ),
                      onTap: () {
                        Get.back();
                       
                      }),
                )*/
              ]),
            )),
      ),
      barrierDismissible: true,
    );
  }
}
