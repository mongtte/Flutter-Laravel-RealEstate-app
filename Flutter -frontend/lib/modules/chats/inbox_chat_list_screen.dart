import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:hero/modules/chats/widgets/send_chat.dart';
import 'package:hero/modules/home/home.dart';
import 'package:hero/shared/constants/constants.dart';
import 'package:hero/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InboxChatListScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    controller.showBadge = false.obs;
    controller.isTap = false;
    if (controller.userLogued()) {
      controller.getRooms(2);
    }

    return Obx(() => controller.roomsChats.length == 0 ||
            !controller.userLogued()
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border,
                  color: Colors.transparent,
                  size: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text('no_messages'.tr,
                      textAlign: TextAlign.center, style: ThemeConfig.title1),
                ),
              ],
            ),
          )
        : ListView(
            children: controller.roomsChats.map((roomChat) {
              return InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(
                    width: .5,
                    color: Colors.grey.shade400,
                  )),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 16, right: 16),
                        child: Container(
                            width: 60,
                            height: 60,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: roomChat.product != null
                                ? CachedNetworkImage(
                                    imageUrl:
                                        roomChat.product!.multimedia!.first.url,
                                    fit: BoxFit.cover)
                                : Container(
                                    child: Icon(
                                      Icons.thumb_down_off_alt_rounded,
                                      color: ColorConstants.darkGray,
                                      size: 30,
                                    ),
                                  )),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                roomChat.post!.nameLastname!.capitalize!,
                                style: ThemeConfig.subtitle1.override(
                                  color: Color(0xFF15212B),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  roomChat.product != null
                                      ? roomChat.product!.title.length > 16
                                          ? '${roomChat.product!.title.substring(0, 16)}...'
                                          : roomChat.product!.title.capitalize!
                                      : 'ad_not_available'.tr,
                                  style: ThemeConfig.subtitle1.override(
                                    color: Color(0xFF15212B),
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),                            
                          ],
                        ),
                      ),
                      for (int i = 0; i < controller.newMsg.length; i++)
                        if (controller.newMsg[i] == roomChat.id)
                          Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: controller.isTap == false
                                      ? Colors.red
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ))
                    ],
                  ),
                ),
                onTap: () {
                  controller.isTap = true;
                  controller.newMsg = List.filled(100, 0);
                  Get.to(() => SendChat(roomChat: roomChat));
                },
              );
            }).toList(),
          ));
  }
}
