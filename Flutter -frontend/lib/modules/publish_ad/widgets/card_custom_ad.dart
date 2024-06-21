import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hero/models/models.dart';
import 'package:hero/models/products/products.dart';
import 'package:hero/modules/home/home.dart';
import 'package:hero/modules/publish_ad/publish_ad.dart';
//import 'package:hero/routes/routes.dart';
import 'package:hero/shared/constants/colors.dart';
import 'package:hero/theme/theme.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardCustomAd extends StatefulWidget {
  final Products product;
  final Color priceColor;
  CardCustomAd(this.product, {this.priceColor = Colors.red});

  @override
  _CardCustomAdState createState() => _CardCustomAdState();
}

class _CardCustomAdState extends State<CardCustomAd> {
  var controller = Get.find<PublishAdController>();
  var homeController = Get.find<HomeController>();

  //bool isLIked = false;

  @override
  void initState() {
    print("INIT!");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Likes? like;

    if (homeController.userLogued()) {
      if (widget.product.likes != null && widget.product.likes!.length > 0) {
        for (var likeProd in widget.product.likes!) {
          if (likeProd.userId == controller.userStrapi.value!.id) {
            like = likeProd;
          }
        }
      }
    }
    bool favoriteIsActive = like != null;

    print("===widget.product likes===== ${widget.product.likes}");

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                          child: Card(
                              color: Colors.grey.shade50,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: Colors.grey.shade300,
                                  width: .8,
                                ),
                              ),
                              child: Container(
                                height: 110,
                                width: 150,
                                child: widget.product.multimedia == null
                                    ? Center(
                                        child: SvgPicture.asset(
                                        'assets/svgs/icon_inbox.svg',
                                        color: Colors.grey.shade400,
                                        width: 60,
                                      ))
                                    : CachedNetworkImage(
                                        imageUrl: widget
                                            .product.multimedia!.first.url,
                                        fit: BoxFit.cover),
                              )),
                          onTap: () {
                            //widget.product.user = controller.userStrapi.value;
                            controller.setActualProduct(widget.product);
                            controller.setCurrentProduct(widget.product);
                            Get.to(() => ShowAdScreen(
                                  color: widget.priceColor,
                                ));
                          }),
                      SizedBox(width: 5),
                      Expanded(
                        child: InkWell(
                            child: Container(
                              //color: Colors.red,
                              height: 110,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.product.title.length > 25
                                          ? '${widget.product.title.substring(0, 25)}...'
                                          : widget.product.title,
                                      style: ThemeConfig.bodyText1.override(
                                          color: ColorConstants.titlePrincipal,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        widget.product.description.length > 15
                                            ? '${widget.product.description.substring(0, 15)}...'
                                            : widget.product.description,
                                        style: ThemeConfig.bodyText1.override(
                                            color:
                                                ColorConstants.titleSecundary,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                        widget.product.price
                                                .toString()
                                                .split(".")[0] +
                                            'coin'.tr,
                                        style: ThemeConfig.bodyText1.override(
                                            color: widget.priceColor,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              //widget.product.user = controller.userStrapi.value;
                              controller.setCurrentProduct(widget.product);
                              controller.setActualProduct(widget.product);
                              print(widget.product.user);
                              Get.to(() => ShowAdScreen(
                                    color: widget.priceColor,
                                  ));
                            }),
                      ),
                      // if(widget.product.user != null && homeController.userLogued() && controller.userStrapi.value!.id != widget.product.user!.id)

                      if (homeController.userLogued())
                        InkWell(
                          child: favoriteIsActive
                              ? Icon(Icons.favorite,
                                  color: Colors.red, size: 25.sp)
                              : Icon(Icons.favorite_border,
                                  color: ColorConstants.darkGray, size: 25.sp),
                          onTap: () async {
                            if (!favoriteIsActive) {
                              await controller
                                  .addFavorite(widget.product)
                                  .then((value) {
                                print("VALUE:  $value");
                                widget.product.likes = value!.likes;
                              });
                            } else {
                              await controller
                                  .removeFavorite(like!.id!, widget.product.id!)
                                  .then((value) =>
                                      widget.product.likes = value!.likes);
                            }
                            setState(() {
                              favoriteIsActive = !favoriteIsActive;
                            });
                          },
                        ),
                    ],
                  )
                ],
              )),
          Container(
              height: 10, color: ColorConstants.lightScaffoldBackgroundColor)
        ],
      ),
    );
  }
}
