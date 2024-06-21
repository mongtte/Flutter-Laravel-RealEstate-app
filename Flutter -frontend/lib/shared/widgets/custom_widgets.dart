import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hero/shared/constants/constants.dart';
import 'package:hero/theme/theme.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TitlePrincipal(String title, {Color? color} ) {
  return Container(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(
      title.tr,
      textAlign: TextAlign.center,
      textScaleFactor: 1,
      style: ThemeConfig.bodyText1.override(
        color: color ?? ColorConstants.titlePrincipal,
        fontSize: 19.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

TitlePrincipalAds(String title, {Color? color}) {
  return Container(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(
      title.tr,
      textAlign: TextAlign.left,
      textScaleFactor: 1,
      style: ThemeConfig.bodyText1.override(
        color: color ?? ColorConstants.titlePrincipal,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

PaymentField(TextEditingController controller) {
  return Padding(
    padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 5),
    child: TextFormField(
      controller: controller,
      validator: (val) {
        if (val!.isEmpty) {
          return 'require_insert'.tr;
        }
        return null;
      },
      style: ThemeConfig.bodyText2.override(
        color: Color(0xFF3C4858),
        fontSize: 15,
        fontWeight: FontWeight.normal,
      ),
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          isDense: true,
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 0.7)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFB4B4B4), width: 0.7))),
    ),
  );
}

TitleSecundary(String title, {Color? color, FontWeight? fontWeight}) {
  return Text(
    title.tr,
    textAlign: TextAlign.center,
    style: ThemeConfig.bodyText1.override(
        color: color ?? ColorConstants.titleSecundary,
        fontSize: 15.sp,
        fontWeight: fontWeight ?? FontWeight.normal),
  );
}

ButtonNotFilledSecundary(String title, {Icon? icon}) {
  return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            width: 1,
            color: ColorConstants.darkGray,
          ),
          color: Colors.white),
      child: Container(
          padding: EdgeInsets.all(8),
          child: icon == null
              ? Center(
                  child: Text(title.tr,
                      textScaleFactor: 1,
                      style: ThemeConfig.bodyText1.override(
                          color: ColorConstants.titleSecundary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)))
              : icon));
}

ButtonSecundary(String title, {Color? color, Icon? icon}) {
  return Card(
      color: color ?? Color(0xffFA4B00),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      shadowColor: null,
      child: Container(
          padding: EdgeInsets.all(8),
          child: icon == null
              ? Center(
                  child: Text(title.tr,
                      textScaleFactor: 1,
                      style: ThemeConfig.bodyText1.override(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon,
                    SizedBox(width: 5),
                    Text(title.tr,
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        style: ThemeConfig.bodyText1.override(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600)),
                  ],
                )));
}

Carousel(List<Widget> listWidget,
    {double height = 270,
    bool enableInfiniteScroll = true,
    bool autoPlay = false}) {
  return CarouselSlider(
      options: CarouselOptions(
        height: 280.h,
        viewportFraction: .45,
        initialPage: 0,
        enableInfiniteScroll: enableInfiniteScroll,
        autoPlay: autoPlay,
        reverse: false,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: false,
        scrollDirection: Axis.horizontal,
      ),
      items: listWidget
      // items: [1, 2, 3, 4, 5].map((i) {
      //   return Builder(
      //     builder: (BuildContext context) {
      //       return CardItemAd(
      //           'Motociclo $i',
      //           'Trezzan... (MI)',
      //           '20',
      //           i == 1
      //               ? ''
      //               : 'https://global.yamaha-motor.com/business/mc/img/index_key_002_sp.jpg');
      //     },
      //   );
      // }).toList(),
      );
}

CardItemAd(String title, String description, String price, String imageUrl) {
  var priceSplit = price.split(".")[0];

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: SizedBox(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
            height: 270,
            width: 190.w, //TODO: Delete on tablet
            //color: Colors.red,
            padding: EdgeInsets.all(8),
            child: Column(
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
                    child: Container(
                      height: 110,
                      width: 150,
                      child: imageUrl == ''
                          ? Center(
                              child: SvgPicture.asset(
                              'assets/svgs/icon_inbox.svg',
                              color: Colors.grey.shade400,
                              width: 60,
                            ))
                          : CachedNetworkImage(
                              imageUrl: imageUrl, fit: BoxFit.cover),
                    )),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title.length > 23 ? '${title.substring(0, 23)}...' : title,
                    style: ThemeConfig.bodyText1.override(
                        color: ColorConstants.titlePrincipal,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      description.length > 10 ? description : description,
                      overflow: TextOverflow.ellipsis,
                      style: ThemeConfig.title2.override(
                          color: ColorConstants.titleSecundary,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(priceSplit + 'coin'.tr,
                        style: ThemeConfig.bodyText1.override(
                            color: Colors.red,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            )),
      ),
    ),
  );
}

CardCategory(String title, IconData icon, Color cardColor,
    {VoidCallback? onTap, bool isSelected = true}) {
  return Expanded(
    child: Container(
      width: 125,
      height: 75.h,
      margin: EdgeInsets.symmetric(horizontal: 6),
      child: InkWell(
        child: Card(
          color: isSelected ? cardColor : cardColor,
          child: Container(
            height: 85,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                      child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      icon,
                      color: isSelected ? cardColor : cardColor,
                      size: 18.sp,
                    ),
                  )),
                ),
                SizedBox(height: 10),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      title,
                      style: ThemeConfig.bodyText1.override(
                        color: Colors.white,
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            )),
          ),
        ),
        onTap: onTap,
      ),
    ),
  );
}
