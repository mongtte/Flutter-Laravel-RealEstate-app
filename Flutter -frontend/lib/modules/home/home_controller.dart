//import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:math';
// import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hero/api/api.dart';
import 'package:hero/models/chats/chats.dart';
import 'package:hero/models/chats/rooms_chats.dart';
import 'package:hero/models/models.dart';
import 'package:hero/models/multimedia.dart';
import 'package:hero/models/products/products.dart';
import 'package:hero/models/response/users_response.dart';
import 'package:hero/modules/chats/widgets/send_chat.dart';
import 'package:hero/modules/home/home.dart';
//import 'package:hero/modules/publish_ad/publish_ad.dart';
import 'package:hero/routes/app_pages.dart';
import 'package:hero/shared/shared.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final ApiRepository apiRepository;
  HomeController({required this.apiRepository});

  var currentTab = MainTabs.home.obs;
  var users = Rxn<UsersResponse>();
  var userStrapi = Rxn<UserStrapi>();
  var roomsChats = RxList<RoomsChats>();
  var actualChat = Rxn<Chats>();
  var actualRoom = Rxn<RoomsChats>();
  var imagesToUpload = <XFile>[].obs;
  RxBool showBadge = false.obs;
  bool get isShowBadge => showBadge.value;
  List<int> chatCount = List.filled(100, 0);
  List<Widget> scrollCards = [];
  List<int> newMsg = List.filled(100, 0);
  bool isTap = false;

  late MainTab mainTab;
  late FavoriteTab discoverTab;
  late CreateAdsTab resourceTab;
  late InboxTab inboxTab;
  late MeTab meTab;
  var storage = Get.find<SharedPreferences>();

  //var logeado = false.obs;

  //EDITAR PERFIL (CONTROLADORES)

  GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var city = TextEditingController();
  var birthDay = "".obs;

  @override
  void onInit() async {
    super.onInit();

    mainTab = MainTab();
    userLogued();
    discoverTab = FavoriteTab();
    resourceTab = CreateAdsTab();
    inboxTab = InboxTab();
    meTab = MeTab();
  }

  bool userLogued() {
    //print('Exist token ${storage.getString(StorageConstants.token)}');
    print("======== TOKEN ========");
    print("${storage.getString(StorageConstants.token)}");
    if (storage.getString(StorageConstants.token) != null) {
      print("USER LOGUED: ${this.userStrapi}");
      if (this.userStrapi.value == null) {
        loadUser();
      }

      //this.logeado.value = true;
      return true;
    } else {
      //this.logeado.value = false;
      return false;
    }
  }

  Future<void> loadUser() async {
    var token = storage.getString(StorageConstants.token);
    this.userStrapi.value = await apiRepository.getUser(token!);
    // getRooms();
  }

  Future<void> editProfile() async {
    Map<String, dynamic> newUser = {
      "email": this.emailController.text,
      "nameLastname": this.nameController.text,
      "birthday": this.birthDay.value,
      "currentLocation": this.city.text
    };
    showLoading();
    final userUpdated = await apiRepository.updateUserProfile(
        newUser, this.userStrapi.value!.id!);
    Get.back();
    this.userStrapi.value = userUpdated;
    Get.snackbar("Profile updated", "Your information has been updated",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorConstants.principalColor);
  }

  showLoading() {
    Get.defaultDialog(
        title: "Caricamento in corso...",
        titleStyle: Get.textTheme.subtitle1,
        content: CircularProgressIndicator(),
        barrierDismissible: false);
  }

  void signout() {
    var prefs = Get.find<SharedPreferences>();
    prefs.clear();
    // NavigatorHelper.popLastScreens(popCount: 1);
    this.userStrapi.value = null;
    Get.toNamed(Routes.HOME + Routes.REGISTER);
  }

  void switchTab(index) {
    var tab = _getCurrentTab(index);
    currentTab.value = tab;
  }

  int getCurrentIndex(MainTabs tab) {
    switch (tab) {
      case MainTabs.home:
        return 0;
      case MainTabs.favorite:
        return 1;
      case MainTabs.create_ads:
        return 2;
      case MainTabs.inbox:
        return 3;
      case MainTabs.me:
        return 4;
      default:
        return 0;
    }
  }

  MainTabs _getCurrentTab(int index) {
    switch (index) {
      case 0:
        return MainTabs.home;
      case 1:
        return MainTabs.favorite;
      case 2:
        return MainTabs.create_ads;
      case 3:
        return MainTabs.inbox;
      case 4:
        return MainTabs.me;
      default:
        return MainTabs.home;
    }
  }

  /*showSear(EnumCategoryList enumCategoryList) {
    String path = '';
    switch (enumCategoryList) {
      case EnumCategoryList.none:
        path = Routes.FURNITURE;
        break;
      case EnumCategoryList.furniture:
        path = Routes.FURNITURE;
        break;
      case EnumCategoryList.activity:
        path = Routes.ACTIVITY;
        break;
      case EnumCategoryList.franchise:
        path = Routes.FRANCHISE;
        break;
      case EnumCategoryList.supplier:
        path = Routes.SUPPLIER;
        break;
      case EnumCategoryList.consultant:
        path = Routes.CONSULTANT;
        break;
      case EnumCategoryList.entrepreneur:
        path = Routes.ENTREPRENEUR;
        break;
    }
    var controllerPublishAd = Get.find<PublishAdController>();
    controllerPublishAd.setCategory(enumCategoryList);
    controllerPublishAd.setSubCategory(EnumSubCategoryList.none);
    controllerPublishAd.setTypeAdcategory(EnumTypeAdList.none);
    controllerPublishAd.peopleType = 'Selezionare:';
    controllerPublishAd.statusProduct = 'Selezionare:';
    controllerPublishAd
        .getPostAd()
        .then((value) => Get.toNamed(Routes.HOME + Routes.LIST_ADS + path));
  }*/

  void getRooms(int index) async {
    await apiRepository
        .getRooms(this.userStrapi.value!.id!)
        .then((rooms) async {
      if (rooms != null) {
        for (var i = 0; i < rooms.length; i++) {
          await getChat(rooms[i].id!).then((value) {
            print("22222222222222222-----------${value}");
            return rooms[i].chats = value;
          });
        }
        rooms.sort((a, b) => a.updatedAt!.compareTo(b.updatedAt!));
        this.roomsChats.value = rooms;
        //this.roomsChats.refresh();
      }
      print("22222222222222222-----------5555");
    });
    // if (index == 1) {
    //   for (int i = 0; i < roomsChats.length; i++) {
    //     getDocumentDataRealtime("ChatRoom${roomsChats[i].id}");
    //   }
    // }
  }

  Future<List<Map<String, dynamic>>> getDocumentData(
      String collectionName) async {
    //await Firebase.initializeApp();
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection(collectionName).get();
    List<Map<String, dynamic>> documentData = [];
    for (DocumentSnapshot doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      documentData.add(data);
    }
    return documentData;
  }

  // getDocumentDataRealtime(String collectionName) {
  //   FirebaseFirestore.instance
  //       .collection(collectionName)
  //       .snapshots()
  //       .listen((snapshot) {
  //     int chat_count = 0;
  //     for (DocumentSnapshot doc in snapshot.docs) {
  //       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //       if (data['user'] != userStrapi.value!.id) chat_count++;
  //     }
  //     if (chat_count > chatCount) {
  //       showBadge = true.obs;
  //       chatCount = chat_count;
  //     }
  //     print(
  //         "111111111111111-------${isShowBadge}---------${chatCount}---------${chat_count}");
  //   });
  // }

  // void docContent(String collectionName) async {
  //   List<Map<String, dynamic>> data = await getDocumentData(collectionName);
  //   print('Document data:');
  //   for (Map<String, dynamic> doc in data) {
  //     if (doc['user'] != userStrapi.value!.id) chat_count++;
  //   }
  //   if (chat_count > chatCount) {
  //     showBadge = true;
  //     chatCount = chat_count;
  //   } else {
  //     showBadge = false;
  //   }
  // }

  // void getRoom() async {
  //   if (userLogued()) {
  //     getRooms(2);
  //     print(roomsChats.length);
  //     for (int i = 0; i < roomsChats.length; i++) {
  //       getDocumentDataRealtime("ChatRoom${roomsChats[i].id}");
  //     }
  //   }
  // }

  Future<List<Chats>> getChat(int id) async {
    return (await apiRepository.getChat(id))!;
  }

  Future<void> setChat(Chats chat) async {
    this.actualChat.value = chat;
  }

  Future<Chats> sendMessage(String message, int roomId,
      {String type = 'text'}) async {
    return (await apiRepository.sendMessage(Chats(
        message: message,
        type: type,
        user: userStrapi.value!,
        roomId: roomId)))!;
  }

  Future<void> sendMultipleMultimediaMessage(int roomId) async {
    imagesToUpload.forEach((element) async {
      await sendMessage('image', roomId, type: 'image').then((chat) async {
        var imageUploaded = await apiRepository.uploadImage(File(element.path),
            'chats', 'multimedia', chat.id!, DateTime.now().toString());
        print(imageUploaded!.url);
      });
    });
  }

  Future<Multimedia> sendMultimediaMessage(File file, int chatId) async {
    print("================------------------${file}+++++++++++++++${chatId}");
    return (await apiRepository.uploadImage(
        file, 'chats', 'multimedia', chatId, DateTime.now().toString()))!;
  }

  Future<RoomsChats> createRoom(Products product) async {
    print("+++++++++++++++1111111111111111");
    return (await apiRepository.createRoom(RoomsChats(
        product: product, post: product.user!, user: this.userStrapi.value!)))!;
    //Get.to(() => SendChat(roomChat: roomChat));
  }

  void setActualRoom(Products product) async {
    var existChat = false;
    await apiRepository
        .getRooms(this.userStrapi.value!.id!)
        .then((rooms) async {
      if (rooms != null) {
        for (var i = 0; i < rooms.length; i++) {
          await getChat(rooms[i].id!).then((value) {
            print("22222222222222222-----------${value}");
            return rooms[i].chats = value;
          });
        }
        rooms.sort((a, b) => a.updatedAt!.compareTo(b.updatedAt!));
        this.roomsChats.value = rooms;
        //this.roomsChats.refresh();
      }
      print("22222222222222222-----------44444");
    });
    print("11111111111111111111111-------${this.roomsChats.toJson()}");
    for (var room in this.roomsChats) {
      var user = (room.user!.id == this.userStrapi.value!.id &&
          room.product!.id == product.id);
      // room.usersRoom!
      //     .firstWhereOrNull((users) => users.id == this.userStrapi.value!.id);
      if (user != false) {
        existChat = true;
        this.actualRoom.value = room;
      }
    }
    print(existChat);
    if (!existChat) {
      this.actualRoom.value = RoomsChats(
        product: product,
        post: product.user!,
        user: this.userStrapi.value!,
      );
    }
    print("+++++++++++++++++++++++++${this.actualRoom.value!}");
    Get.to(() => SendChat(roomChat: this.actualRoom.value!));
  }
}
