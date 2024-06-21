import 'package:flutter/material.dart';
import 'package:hero/modules/home/home.dart';
import 'package:hero/modules/home/tabs/tabs.dart';
import 'package:hero/shared/shared.dart';
import 'package:badges/badges.dart' as badges;
import 'dart:async';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.currentTab.value != MainTabs.home) {
          controller.switchTab(0);
        }
        return false;
      },
      child: Obx(() => _buildWidget()),
    );
  }

  Widget _buildWidget() {
    return Scaffold(
      body: Center(
        child: _buildContent(controller.currentTab.value),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          _buildNavigationBarItem("tab_1".tr, Icons.home,
              MainTabs.home == controller.currentTab.value),
          _buildNavigationBarItem("tab_2".tr, Icons.favorite_border_rounded,
              MainTabs.favorite == controller.currentTab.value),
          _buildNavigationBarItem("tab_3".tr, Icons.add_box_outlined,
              MainTabs.create_ads == controller.currentTab.value),
          BottomNavigationBarItem(
            icon: Obx(
              () => badges.Badge(
                badgeContent: Text(''),
                showBadge: controller.isShowBadge,
                child: Icon(Icons.message_outlined,
                    color: MainTabs.inbox == controller.currentTab.value
                        ? ColorConstants.titlePrincipal
                        : ColorConstants.darkGray),
              ),
            ),
            label: "tab_4".tr,
          ),
          _buildNavigationBarItem("tab_5".tr, Icons.manage_accounts_outlined,
              MainTabs.me == controller.currentTab.value)
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: controller.getCurrentIndex(controller.currentTab.value),
        unselectedItemColor: ColorConstants.darkGray,
        selectedItemColor: ColorConstants.titlePrincipal,
        selectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 13,
        ),
        onTap: (index) => controller.switchTab(index),
      ),
    );
  }

  Widget _buildContent(MainTabs tab) {
    switch (tab) {
      case MainTabs.home:
        //   if (controller.userLogued()) {
        //   controller.getRooms(2);
        //   for (int i = 0; i < controller.roomsChats.length; i++) {
        //     FirebaseFirestore.instance
        //         .collection("ChatRoom${controller.roomsChats[i].id}")
        //         .snapshots()
        //         .listen((snapshot) {
        //       int chat_count = 0;
        //       for (DocumentSnapshot doc in snapshot.docs) {
        //         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        //         if (data['user'] != controller.userStrapi.value!.id) chat_count++;
        //       }
        //       if (chat_count > controller.chatCount[i]) {
        //         controller.showBadge = true.obs;
        //         controller.newMsg[i] = controller.roomsChats[i].id!;
        //         controller.isTap = false;
        //         controller.chatCount[i] = chat_count;
        //       }
        //     });
        //     print("----------------------------${controller.newMsg[i]}");
        //   }
        //   print("1111111111111111111-${controller.showBadge}");
        // }
        return controller.mainTab;
      case MainTabs.favorite:
        return controller.discoverTab;
      case MainTabs.create_ads:
        return controller.resourceTab;
      case MainTabs.inbox:
        return controller.inboxTab;
      case MainTabs.me:
        return controller.meTab;
      default:
        return controller.mainTab;
    }
  }

  // BottomNavigationBarItem _buildNavigationBarItem1(
  //     String label, IconData icon, bool activated, bool badge) {
  //   return BottomNavigationBarItem(
  //     icon: badges.Badge(
  //       badgeContent: Text(''),
  //       showBadge: badge,
  //       child: Icon(icon,
  //           color: activated
  //               ? ColorConstants.titlePrincipal
  //               : ColorConstants.darkGray),
  //     ),
  //     label: label,
  //   );
  // }
  BottomNavigationBarItem _buildNavigationBarItem(
      String label, IconData icon, bool activated) {
    return BottomNavigationBarItem(
      icon: Icon(icon,
          color: activated
              ? ColorConstants.titlePrincipal
              : ColorConstants.darkGray),
      label: label,
    );
  }
}
