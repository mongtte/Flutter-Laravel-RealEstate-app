// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, unused_local_variable

import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/lang/translation_service.dart';
import 'package:hero/models/subcategory.dart';
import 'package:hero/modules/publish_ad/publish_ad.dart';
import 'package:hero/shared/shared.dart';
import 'package:hero/modules/home/home.dart';
import 'package:hero/shared/widgets/widgets.dart';
import 'package:hero/modules/publish_ad/widgets/type_ad_list.dart';

import 'package:hero/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainTab extends GetView<HomeController> {
  String iconChair = "Icons.chair";

  @override
  Widget build(BuildContext context) {
    //controller.getRooms(1);
    //print(ColorConstants.furnitureColor.value);
    final adController = Get.find<PublishAdController>();

    /* if (controller.userLogued()) {
      Future.delayed(Duration(seconds: 2), () {
        adController.getRecentlyProducts();
      });
    }*/

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 110),
            child: ListView(
              children: [
                buildGridView(context),
              ],
            ),
          ),
          CustomAppBar(),
        ],
      ),
    );
  }

  Widget buildGridView(context) {
    final adController = Get.find<PublishAdController>();
    final ScrollController _controller = ScrollController();
    final ScrollController _controller1 = ScrollController();
    RxInt _currentIndex = 0.obs;
    late ScrollController _scrollController = ScrollController();
    int _itemCount = 30;
    final cardArticle = ['find_your_business'];
    Timer? _timer;
    double count = 1;
    _timer = Timer.periodic(
      Duration(seconds: 5),
      (timer) {
        if (_controller.hasClients) {
          double maxScroll = _controller.position.maxScrollExtent;
          double currentScroll = _controller.position.pixels;
          if (currentScroll >= maxScroll) {
            _controller.animateTo(0,
                duration: Duration(seconds: 1), curve: Curves.ease);
          } else {
            _controller.animateTo(
              currentScroll + 100,
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
            );
          }
        }
      },
    );
    Function? _showPicker(
        BuildContext context, EnumCategoryList currentCategory) {
      adController.setCategory(currentCategory);
      adController.publishAdModel.refresh();
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return TypeAdList(1);
          }).whenComplete(() {
        // adController.getPostAdToFilterScreen(2).then((value) {
        //   Get.to(() => ListAdScreen());
        // });
        adController.setCategory(EnumCategoryList.none);
        adController.publishAdModel.refresh();
      });
    }

    /*if (controller.userLogued()) {
      Future.delayed(Duration(seconds: 2), () {
        adController.getRecentlyProducts();
      });
    }*/
    // final ScrollController _controller = ScrollController();
    // _controller.animateTo(
    //   _controller.position.maxScrollExtent,
    //   duration: Duration(milliseconds: 500),
    //   curve: Curves.fastOutSlowIn,
    // );
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(color: ColorConstants.principalColor),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
                alignment: Alignment.center,
                child:
                    TitlePrincipal('find_your_business', color: Colors.white))),
        Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Align(
              alignment: Alignment.center,
              child: TitleSecundary('what_looking_one',
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.principalColor),
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Container(
            width: Get.width,
            height: 100.h,
            //color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children:
                    List.generate(adController.allCategories.length, (index) {
                  Category cat = adController.allCategories[index];
                  String? local = TranslationService.locale.toString();
                  return cat.type == "buy"
                      ? CardCategory(
                          local.substring(0, 3) == "en_"
                              ? cat.nameEn!
                              : local.substring(0, 3) == "it_"
                                  ? cat.nameIt!
                                  : cat.nameEs!,
                          cat.icon!,
                          cat.color!, onTap: () {
                          print(cat.nameEn);
                          adController.currentCat.value = cat;
                          //print(adController.currentCat.value.nameEs);
                          adController.currentCatStr = cat.nameEn!;
                          _showPicker(
                              context,
                              cat.nameEs == "MUEBLES"
                                  ? EnumCategoryList.furniture
                                  : cat.nameEs == "ACTIVIDAD"
                                      ? EnumCategoryList.activity
                                      : cat.nameEs == "FRANQUICIA"
                                          ? EnumCategoryList.franchise
                                          : EnumCategoryList.furniture);
                        })
                      : SizedBox();
                }),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.center,
            child: TitleSecundary(
              'what_looking_two',
              fontWeight: FontWeight.w600,
              color: ColorConstants.principalColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Container(
            width: Get.width,
            height: 100.h,
            //color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children:
                    List.generate(adController.allCategories.length, (index) {
                  Category cat = adController.allCategories[index];
                  String? local = TranslationService.locale.toString();

                  return cat.type == "business"
                      ? CardCategory(
                          local.substring(0, 3) == "en_"
                              ? cat.nameEn!
                              : local.substring(0, 3) == "it_"
                                  ? cat.nameIt!
                                  : cat.nameEs!,
                          cat.icon!,
                          cat.color!, onTap: () {
                          print(local.substring(0, 3));
                          adController.currentCat.value = cat;
                          print(adController.currentCat.value.nameEs);
                          adController.currentCatStr = cat.nameEs!;
                          _showPicker(
                              context,
                              cat.nameEs == "PROVEEDOR"
                                  ? EnumCategoryList.supplier
                                  : cat.nameEs == "ASESOR"
                                      ? EnumCategoryList.consultant
                                      : cat.nameEs == "EMPRENDEDOR"
                                          ? EnumCategoryList.entrepreneur
                                          : EnumCategoryList.furniture);
                        })
                      : SizedBox();
                }),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'keep_searching'.tr,
                textAlign: TextAlign.left,
                style: ThemeConfig.bodyText1.override(
                  color: ColorConstants.titlePrincipal,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                  child: ButtonSecundary('view_all'),
                  onTap: () {
                    adController.currentCatStr = "";
                    adController.getPostAdToFilterScreen(1, "").then((value) {
                      Get.to(
                        () => ListAdScreen(
                          index: 1,
                          conCategoria: false,
                        ),
                      );
                    });
                  })
            ],
          ),
        ),
        Obx(() {
          var postAdController = Get.find<PublishAdController>();
          final cards = getListAll();
          if (cards.length == 1) {
            controller.scrollCards = [];
            controller.scrollCards = cards;
          } else if (cards.length == 2) {
            controller.scrollCards = [];
            controller.scrollCards.add(cards[0]);
            controller.scrollCards.add(cards[1]);
          } else {
            controller.scrollCards = [];
            for (int i = 0; i < cards.length * 20; i++) {
              controller.scrollCards.add(cards[i % cards.length]);
            }
          }

          return postAdController.postReady.value == true
              ? SizedBox(
                  height: 230.h,
                  child: ListView.builder(
                    itemCount: controller.scrollCards.length,
                    scrollDirection: Axis.horizontal,
                    controller: _controller,
                    itemBuilder: (BuildContext context, int index) {
                      return controller.scrollCards[index];
                    },
                  ),
                )
              : Center(child: SizedBox());
        }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'ad_view_early'.tr,
              textAlign: TextAlign.left,
              style: ThemeConfig.bodyText1.override(
                color: ColorConstants.titlePrincipal,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // if (controller.userLogued())
        FutureBuilder(
            future: adController.getRecentlyProducts(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                print("000000000000000");
                return SizedBox();
              } else {
                return recentlyProds();
              }
            }),
        //recentlyProds(),
        // if (!controller.userLogued())
        //   /*Center(
        //     child: Text(
        //       'You need to be logged in',
        //       textAlign: TextAlign.center,
        //       style: ThemeConfig.bodyText1.override(
        //         fontSize: 20,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //   ),*/
        //   SizedBox(
        //     height: 20.h,
        //   ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
          child: _cardCreateAd(),
        ),
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }

  recentlyProds() {
    final products = getListRecently();
    final ScrollController _controller = ScrollController();
    Timer? _timer;
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_controller.hasClients) {
        double maxScroll = _controller.position.maxScrollExtent;
        double currentScroll = _controller.position.pixels;

        if (maxScroll - currentScroll <= 1) {
          _controller.jumpTo(0);
        } else {
          _controller.animateTo(
            maxScroll,
            duration: Duration(seconds: 1),
            curve: Curves.ease,
          );
        }
      }
    });

    if (products.isEmpty) {
      return SizedBox();
    } else {
      return Obx(() {
        var postAdController = Get.find<PublishAdController>();
        return postAdController.postReady.value == true ||
                postAdController.productsRecentlyReady.value == true
            ? SizedBox(
                height: 230.h,
                child: ListView.builder(
                  itemCount: products.length,
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  itemBuilder: (BuildContext context, int index) {
                    return products[index];
                  },
                ),
              )
            //Carousel(getListRecently() )
            : Center(child: CircularProgressIndicator());
      });
    }
  }

  _cardCreateAd() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: InkWell(
        child: ButtonSecundary('place_ad'),
        onTap: () => controller
            .switchTab(controller.getCurrentIndex(MainTabs.create_ads)),
      ),
    );
  }

  List<Widget> getListAll() {
    var postAdController = Get.find<PublishAdController>();
    print(postAdController.allProducts.length);
    // return postAdController.allProducts.length > 0
    //     ? postAdController.allProducts.map<Widget>((product) {
    //         if (product.slug != "0") {
    //           return InkWell(
    //             child: CardItemAd(
    //                 product.title,
    //                 product.description,
    //                 product.price.round().toString(),
    //                 product.multimedia![0].url),
    //             onTap: () async {
    //               print(product.toJson());
    //               postAdController.setCurrentProduct(product);
    //               postAdController.setActualProduct(product);
    //               postAdController.currentCat.value =
    //                   product.subCategory!.category!;
    //               postAdController.currentCatStr = product.subCategory!.nameEs!;
    //               print(
    //                   "currentCatStr showAd ${postAdController.currentCatStr}");
    //               await postAdController.addToRecentlyProducts(product.id!);

    //               Get.to(() => ShowAdScreen(
    //                     color: Colors.red,
    //                   ));
    //             },
    //           );
    //         } else
    //           return SizedBox();
    //       }).toList()
    //     : [
    //         Center(
    //             child: CircularProgressIndicator(
    //           color: ColorConstants.darkGray,
    //         ))
    //       ];
    List<Widget> enableProduct = [];
    if (postAdController.allProducts.length > 0) {
      for (int i = 0; i < postAdController.allProducts.length; i++) {
        if (postAdController.allProducts[i].slug != "0") {
          enableProduct.add(InkWell(
            child: CardItemAd(
                postAdController.allProducts[i].title,
                postAdController.allProducts[i].description,
                postAdController.allProducts[i].price.round().toString(),
                postAdController.allProducts[i].multimedia![0].url),
            onTap: () async {
              print(postAdController.allProducts[i].toJson());
              postAdController
                  .setCurrentProduct(postAdController.allProducts[i]);
              postAdController
                  .setActualProduct(postAdController.allProducts[i]);
              postAdController.currentCat.value =
                  postAdController.allProducts[i].subCategory!.category!;
              postAdController.currentCatStr =
                  postAdController.allProducts[i].subCategory!.nameEs!;
              print("currentCatStr showAd ${postAdController.currentCatStr}");
              await postAdController
                  .addToRecentlyProducts(postAdController.allProducts[i].id!);

              Get.to(() => ShowAdScreen(
                    color: Colors.red,
                  ));
            },
          ));
        }
      }
    }
    return enableProduct;
  }

  List<Widget> getListRecently() {
    var postAdController = Get.find<PublishAdController>();
    postAdController.getRecentlyProducts();
    return postAdController.recentlyProducts.length > 0
        ? postAdController.recentlyProducts.map<Widget>((product) {
            return InkWell(
              child: CardItemAd(product.title, product.description,
                  product.price.toString(), product.multimedia![0].url),
              onTap: () async {
                postAdController.setCurrentProduct(product);
                postAdController.setActualProduct(product);
                postAdController.currentCat.value =
                    product.subCategory!.category!;
                postAdController.currentCatStr =
                    product.subCategory!.category!.nameEs!;
                print("currentCatStr showAd ${postAdController.currentCatStr}");
                await postAdController.addToRecentlyProducts(product.id!);
                Get.to(() => ShowAdScreen(color: Colors.red));
              },
            );
          }).toList()
        : [];
  }
}
