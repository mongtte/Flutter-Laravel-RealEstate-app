// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/api/api.dart';
import 'package:hero/lang/lang.dart';
import 'package:hero/models/models.dart';
import 'package:hero/models/multimedia.dart';
import 'package:hero/models/prices/prices.dart';
import 'package:hero/models/products/products.dart';
import 'package:hero/models/publish_ad_model.dart';
import 'package:hero/models/subcategory.dart';
import 'package:hero/modules/me/cards/after_payment.dart';
import 'package:hero/modules/publish_ad/steps/publish_ad_step_four_screen.dart';
import 'package:hero/routes/app_pages.dart';
import 'package:hero/shared/catalogs/list_enums.dart';
import 'package:hero/shared/constants/constants.dart';
import 'package:hero/shared/shared.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'steps/steps_tabs.dart';

class PublishAdController extends GetxController {
  final ApiRepository apiRepository;
  var actualStep = 0.obs;
  var userStrapi = Rxn<UserStrapi>();

  Rx<PublishAdModel> publishAdModel = PublishAdModel(
          currentCategory: EnumCategoryList.none,
          currenTypeAd: EnumTypeAdList.none,
          currentSubCategory: EnumSubCategoryList.none)
      .obs;
  //PRODUCTS===========
  RxList<Products> allProducts = RxList<Products>();
  RxList<Products> filtersProducts = RxList<Products>([]);
  RxList<Products> recentlyProducts = RxList<Products>();
  RxList<Products> likedProducts = RxList<Products>();
  RxList<Products> myProducts = RxList<Products>();
  List<String> defaultList = [];
  int imageCount = 0;
  int productId = 0;

  var imagesToUpload = List<XFile>.filled(6, XFile('')).obs;
  var controllerTitle = TextEditingController();
  var controllerDescription = TextEditingController();
  var controllerPrice = TextEditingController();
  var controllerNewCategoria = TextEditingController();
  var controllerPriceMax = TextEditingController();
  var controllerSearch = TextEditingController();
  var controllerPhone = TextEditingController();
  var controllerBusinessName = TextEditingController();
  var controllerVatNumber = TextEditingController();
  var controllerTaxId = TextEditingController();
  var controllerAddress = TextEditingController();
  var controllerCommon = TextEditingController();
  var controllerProvince = TextEditingController();
  var controllerPostal = TextEditingController();
  var controllerPEC = TextEditingController();
  var controllerTelephone = TextEditingController();
  var controllerFax = TextEditingController();
  var controllerReferent = TextEditingController();
  var controllerCity = TextEditingController();

  Rx<bool> postReady = false.obs;
  String peopleType = '';
  String statusProduct = '';
  String city = '';
  int idProduct = 0;
  List<Multimedia> multimediaProduct = [];
  UserStrapi? userProduct;
  Products? actualProduct;
  var prices = Prices().obs;

  //NUEVA IMPLEMENTACION
  var currentCategoria = "".obs;
  var currentSubcategoria = "".obs;

  var currentSubCat = SubCategory().obs;
  var currentCat = Category().obs;
  String currentCatStr = "";
  String currentSubCatStr = "";
  String currenPeopleTypeStr = "";
  String currentCondizioneStr = "1";
  String currentAdTypeStr = "";
  List<dynamic> priceList = [];
  double price = 0;
  String period = "free";

  var allCategories = RxList<Category>([]);

  var categoriesReady = false.obs;

  var productsRecentlyReady = false.obs;

  PublishAdController({required this.apiRepository, required this.userStrapi});

  @override
  void onInit() async {
    super.onInit();
    getPostAdHome();
    //getRecentlyProducts();
  }
  // void dispose() {
  //   super.dispose();

  // }

  bool isActualCategory(EnumCategoryList category) {
    return publishAdModel.value.currentCategory == EnumCategoryList.none
        ? true
        : publishAdModel.value.currentCategory == category;
  }

  void setCategory(EnumCategoryList currentCategory) {
    publishAdModel.value.currentCategory = currentCategory;
  }

  void setTypeAdcategory(EnumTypeAdList typeAd, {bool next = true}) {
    publishAdModel.value.currenTypeAd = typeAd;
  }

  void setSubCategory(EnumSubCategoryList subCategory) {
    publishAdModel.value.currentSubCategory = subCategory;
    publishAdModel.refresh();
  }

  bool validateFurniture() {
    return publishAdModel.value.currentCategory == EnumCategoryList.supplier;
  }

  bool validateConsultant() {
    return publishAdModel.value.currentCategory == EnumCategoryList.consultant;
  }

  bool validateEntrepreneur() {
    return publishAdModel.value.currentCategory ==
        EnumCategoryList.entrepreneur;
  }

  bool validateSellBuy() {
    return publishAdModel.value.currentCategory == EnumCategoryList.furniture ||
        publishAdModel.value.currentCategory == EnumCategoryList.activity ||
        publishAdModel.value.currentCategory == EnumCategoryList.franchise;
  }

  bool validateRent() {
    return publishAdModel.value.currentCategory == EnumCategoryList.furniture;
  }

  bool validateRent2() {
    return publishAdModel.value.currentCategory == EnumCategoryList.activity ||
        publishAdModel.value.currentCategory == EnumCategoryList.franchise;
  }

  List<String> getCategoryList() {
    return [
      'furniture'.tr,
      'activity'.tr,
      'franchise'.tr,
      'supplier'.tr,
      'adviser'.tr,
      'entrepreneur'.tr,
    ];
  }

  List<String> getSubCategoryList() {
    switch (publishAdModel.value.currentCategory) {
      case EnumCategoryList.furniture:
        return furnitureSubCategoryList;
      case EnumCategoryList.activity:
      case EnumCategoryList.franchise:
        return activitySubCategoryList;
      case EnumCategoryList.supplier:
        return supplierSubCategoryList;
      case EnumCategoryList.consultant:
        return consultantSubCategoryList;
      case EnumCategoryList.entrepreneur:
        return entrepreneurSubCategoryList;
      default:
        return ['Selezionare:'];
    }
  }

  Color getCardCategoryColor() {
    switch (publishAdModel.value.currentCategory) {
      case EnumCategoryList.furniture:
        return ColorConstants.furnitureColor;
      case EnumCategoryList.activity:
        return ColorConstants.activityColor;
      case EnumCategoryList.franchise:
        return ColorConstants.franchiseColor;
      case EnumCategoryList.supplier:
        return ColorConstants.supplierColor;
      case EnumCategoryList.consultant:
        return ColorConstants.consultantColor;
      case EnumCategoryList.entrepreneur:
        return ColorConstants.entrepreneurColor;
      default:
        return ColorConstants.darkGray;
    }
  }

  String getActualCateogry() {
    switch (publishAdModel.value.currentCategory) {
      case EnumCategoryList.furniture:
        return 'MUEBLES';
      case EnumCategoryList.activity:
        return 'ACTIVIDAD';
      case EnumCategoryList.franchise:
        return 'FRANQUICIA';
      case EnumCategoryList.supplier:
        return 'PROVEEDOR';
      case EnumCategoryList.consultant:
        return 'ASESOR';
      case EnumCategoryList.entrepreneur:
        return 'EMPRENDEDOR';
      default:
        return '';
    }
  }

  List<String> getTypeAdList() {
    switch (publishAdModel.value.currentCategory) {
      case EnumCategoryList.furniture:
        return furnitureAdList;
      case EnumCategoryList.activity:
      case EnumCategoryList.franchise:
        return activityAdList;
      case EnumCategoryList.supplier:
        return supplierAdList;
      case EnumCategoryList.consultant:
        return consultantAdList;
      case EnumCategoryList.entrepreneur:
        return entrepreneurAdList;
      default:
        return ['option'];
    }
  }

  nexStep(String page, {List<String>? options}) {
    actualStep++;

    Get.toNamed(page, arguments: options);
  }

  backStep(String page) {
    actualStep--;

    if (page == 'back') {
      Get.back();
    } else {
      Get.toNamed(
        page,
      );
    }
  }

  Widget getActualStep() {
    switch (_getCurrentTab(actualStep.value)) {
      case StepsTabs.zero:
        return PublishAdStepZeroScreen();
      case StepsTabs.one:
        return PublishAdStepOneScreen();
      case StepsTabs.two:
        return PublishAdStepTwoScreen();
      case StepsTabs.three:
        return PublishAdStepThreeScreen();
      default:
        return PublishAdStepZeroScreen();
    }
  }

  StepsTabs _getCurrentTab(int index) {
    switch (index) {
      case 0:
        return StepsTabs.zero;
      case 1:
        return StepsTabs.one;
      case 2:
        return StepsTabs.two;
      case 3:
        return StepsTabs.three;
      default:
        return StepsTabs.zero;
    }
  }

  String getActualTypeAd({int? index = 2}) {
    print("3333333333333----------------${publishAdModel.value.currenTypeAd}");
    if (index == 2)
      return getStringTypeAdPublish(publishAdModel.value.currenTypeAd);
    else
      return getStringTypeAd(publishAdModel.value.currenTypeAd);
  }

  String getActualSubCategory() {
    return getStringSubCategoryFromEnum(
        publishAdModel.value.currentSubCategory);
  }

  void itemUpdate(EnumTypeList type, dynamic value) {
    switch (type) {
      case EnumTypeList.category:
        publishAdModel.value.currentCategory = getEnumCategoryFromString(value);
        break;
      case EnumTypeList.subCategory:
        publishAdModel.value.currentSubCategory =
            getEnumSubCategoryFromString(value);
        break;
      case EnumTypeList.typePerson:
        this.peopleType = value;
        break;
      case EnumTypeList.statusProduct:
        this.statusProduct = value;
        break;
      case EnumTypeList.none:
      // TODO: Handle this case.
      case EnumTypeList.typeAd:
      // TODO: Handle this case.
    }
  }

  void setPrice(double price) {
    price = price;
  }

  Future<SubCategory> getSubCatToPost(String nameSubCat) async {
    String locale = TranslationService.locale.toString();

    final subCats =
        await apiRepository.getSubCategoriesForPost(nameSubCat, locale);

    return subCats[0];
  }

  Future<Prices> getPricesList() async {
    final prices = await apiRepository.getPrices();
    return prices;
  }

  Future<bool> postAgency() async {
    final normal = await apiRepository.postAgency(
      controllerBusinessName.toString(),
      controllerVatNumber.toString(),
      controllerTaxId.toString(),
      controllerAddress.toString(),
      controllerCommon.toString(),
      controllerProvince.toString(),
      controllerPostal.toString(),
      controllerPEC.toString(),
      controllerTelephone.toString(),
      controllerFax.toString(),
      controllerReferent.toString(),
    );
    return normal;
  }

  Future<String> getCheckout(int option, Products product) async {
    return await apiRepository.getUrlCheckout(option, product.id!);
  }

  Future<SnackbarController> confirmCheckout(String endpoint) async {
    final response = await apiRepository.confirmCheckout(endpoint);
    if (!response)
      return Get.rawSnackbar(
          title: "Error",
          message:
              "No se pudo procesar la compra, comuniquese con el administrador.");

    return Get.rawSnackbar(
        title: "Exito",
        message: "Su producto estara siendo posicionado entre los primeros.");
  }

  Future<void> postAd(BuildContext context) async {
    // print(controllerTitle.text);
    // print(controllerDescription.text);
    // print(city);
    // print(this.currentSubCatStr);
    // print(controllerPrice.text);
    // print(this.currenPeopleTypeStr);
    // print(controllerPhone.text);
    // print(this.currentCondizioneStr);
    // print(this.currentAdTypeStr);
    // print(getActualCateogry());
    // //print(await getSubCatToPost(this.currentSubCatStr));
    // print(this.userStrapi.value);
    String locale = TranslationService.locale.toString();
    Timer? _timer;

    AppFocus.unfocus(context);
    var newPost = await apiRepository.publishAd(Products(
        title: controllerTitle.text,
        description: controllerDescription.text,
        city: controllerCity.text,
        currency: 'dollar',
        peopleType: this.currenPeopleTypeStr,
        price: double.parse(controllerPrice.text),
        slug: this.period,
        phoneNumber: controllerPhone.text.isNotEmpty
            ? int.parse(controllerPhone.text)
            : 0,
        statusProduct: this.currentCondizioneStr,
        status: 'published',
        adType: this.getActualTypeAd(index: 1),
        category: getActualCateogry(),
        subCategory: await getSubCatToPost(this.currentSubCatStr),
        user: this.userStrapi.value));
    imagesToUpload.forEach((element) async {
      if (element.path != '') {
        var imageUploaded = await apiRepository.uploadImage(File(element.path),
            'product', element.path, newPost!, DateTime.now().toString());
      }
    });

    if (newPost != "" && newPost != null) {
      CommonWidget.showModalInfo('confirm alert'.tr, title: '')
          .then((value) {});
      productId = newPost;
      _timer = Timer.periodic(Duration(seconds: 60), (timer) async {
        var confirm = await apiRepository.getConfirm(newPost);
        if (confirm == "cancel") {
          _timer!.cancel();
          CommonWidget.showModalInfo('confirmerror alert'.tr, title: '');
        } else if (confirm == "true") {
          _timer!.cancel();
          priceList = await apiRepository.getPrice();
          CommonWidget.showModalInfo('ad_revision2'.tr,
                  title: 'ad_revision1'.tr)
              .then((value) {
            getPostAdHomeAll().then((value) {
              Get.to(() => PublishAdStepFourScreen());
            });
          });
        }
      });
    }
    // CommonWidget.showModalInfo('ad_revision2'.tr, title: 'ad_revision1'.tr)
    //     .then((value) {
    //   getPostAdHomeAll().then((value) {
    //     Get.to(() => AfterPayment());
    //   });
    // });
  }

  clearData() {
    this.currentCat.value = Category();
    this.currentSubCatStr = "";
    this.currenPeopleTypeStr = "";
    this.currentCondizioneStr = "";
  }

  void cleanControllers() {
    controllerDescription.clear();
    controllerPrice.clear();
    controllerTitle.clear();
    controllerPhone.clear();
    this.publishAdModel.value.currentCategory = EnumCategoryList.none;
    this.publishAdModel.value.currenTypeAd = EnumTypeAdList.none;
    this.publishAdModel.value.currentSubCategory = EnumSubCategoryList.none;
    this.peopleType = '';
    this.statusProduct = '';
    this.city = '';
    this.actualStep.value = 0;
    this.imagesToUpload = List<XFile>.filled(6, XFile('')).obs;
  }

  void cleanControllerOnly() {
    controllerDescription.clear();
    controllerPrice.clear();
    controllerTitle.clear();
    controllerPhone.clear();
    this.peopleType = 'Selezionare:';
    this.statusProduct = 'Selezionare:';
    this.publishAdModel.value.currentSubCategory = EnumSubCategoryList.none;
    this.city = '';
  }

  Future<void> getAllCategories() async {
    categoriesReady.value = false;
    this.allCategories.value = (await apiRepository.getAllCategories());
    //this.allCategories.value = [];

    this.allCategories.refresh();
    categoriesReady.value = true;
  }

  Future<List<String>> getSubCategoriesByCategory() async {
    if (this.currentCat.value.id == null) return [];
    print("7777777777777777777--------------${currentCat.value.nameEs}");

    final subCategories = await apiRepository
        .getSubCategoriesByCategory(this.currentCat.value.nameEs!);
    List<String> subCategoriesFiltersList = [];
    subCategoriesFiltersList.add('Select'.tr + ":");
    subCategories.forEach((subCat) {
      String locale = TranslationService.locale.toString();
      switch (locale.substring(0, 3)) {
        case "en_":
          {
            subCategoriesFiltersList.add(subCat.nameEn!);
          }
          break;
        case "it_":
          {
            subCategoriesFiltersList.add(subCat.nameIt!);
          }
          break;
        case "es_":
          {
            subCategoriesFiltersList.add(subCat.nameEs!);
          }
          break;
        default:
          {
            subCategoriesFiltersList.add(subCat.nameEn!);
          }
      }
    });
    return subCategoriesFiltersList;
  }

  /*RxList<SubCategory> subCategoriesToPost = RxList<SubCategory>([]);

  Future<List<String>> getSubCategoriesToPost() async {
    final subCategories = await apiRepository.getSubCategoriesByCategory(this.currentCat.value.nameEs!);

    return [];
  }*/

  setCurrentPeopleType() {
    String lang = TranslationService.locale.toString();

    this.currenPeopleTypeStr = lang.substring(0, 3) == "it_"
        ? itListPeopleType[0]
        : lang.substring(0, 3) == "en_"
            ? enListPeopleType[0]
            : lang == "es_ES"
                ? esListPeopleType[0]
                : enListPeopleType[0];
  }

  setCurrentAdType() {
    String lang = TranslationService.locale.toString();
    switch (lang) {
      case "it_IT":
        this.currentCatStr == "MUEBLES"
            ? this.currentAdTypeStr = buyListIt[0]
            : this.currentCatStr == "ASESOR"
                ? this.currentAdTypeStr = asesorListIt[0]
                : this.currentCatStr == "ACTIVIDAD"
                    ? this.currentAdTypeStr = buyListIt[0]
                    : this.currentCatStr == "FRANQUICIA"
                        ? this.currentAdTypeStr = buyListIt[0]
                        : this.currentCatStr == "PROVEEDOR"
                            ? this.currentAdTypeStr = proveedorListIt[0]
                            : this.currentCatStr == "EMPRENDEDOR"
                                ? this.currentAdTypeStr = emprendedorListIt[0]
                                : this.currentAdTypeStr = buyListIt[0];

        break;
      case "es_ES":
        this.currentCatStr == "MUEBLES"
            ? this.currentAdTypeStr = buyListEs[0]
            : this.currentCatStr == "ASESOR"
                ? this.currentAdTypeStr = asesorListEs[0]
                : this.currentCatStr == "ACTIVIDAD"
                    ? this.currentAdTypeStr = buyListEs[0]
                    : this.currentCatStr == "FRANQUICIA"
                        ? this.currentAdTypeStr = buyListEs[0]
                        : this.currentCatStr == "PROVEEDOR"
                            ? this.currentAdTypeStr = proveedorListEs[0]
                            : this.currentCatStr == "EMPRENDEDOR"
                                ? this.currentAdTypeStr = emprendedorListEs[0]
                                : this.currentAdTypeStr = buyListEs[0];

        break;
      case "en_US":
        this.currentCatStr == "MUEBLES"
            ? this.currentAdTypeStr = buyListEn[0]
            : this.currentCatStr == "ASESOR"
                ? this.currentAdTypeStr = asesorListEn[0]
                : this.currentCatStr == "ACTIVIDAD"
                    ? this.currentAdTypeStr = buyListEn[0]
                    : this.currentCatStr == "FRANQUICIA"
                        ? this.currentAdTypeStr = buyListEn[0]
                        : this.currentCatStr == "PROVEEDOR"
                            ? this.currentAdTypeStr = proveedorListEn[0]
                            : this.currentCatStr == "EMPRENDEDOR"
                                ? this.currentAdTypeStr = emprendedorListEn[0]
                                : this.currentAdTypeStr = buyListEn[0];

        break;
      default:
        this.currentCatStr == "MUEBLES"
            ? this.currentAdTypeStr = buyListEn[0]
            : this.currentCatStr == "ASESOR"
                ? this.currentAdTypeStr = asesorListEn[0]
                : this.currentCatStr == "ACTIVIDAD"
                    ? this.currentAdTypeStr = buyListEn[0]
                    : this.currentCatStr == "FRANQUICIA"
                        ? this.currentAdTypeStr = buyListEn[0]
                        : this.currentCatStr == "PROVEEDOR"
                            ? this.currentAdTypeStr = proveedorListEn[0]
                            : this.currentCatStr == "EMPRENDEDOR"
                                ? this.currentAdTypeStr = emprendedorListEn[0]
                                : this.currentAdTypeStr = buyListEn[0];
    }
  }

  List<String> getListPeopleType() {
    String lang = TranslationService.locale.toString();
    List<String> list = [];
    switch (lang) {
      case "it_IT":
        list = itListPeopleType;
        break;
      case "en_US":
        list = enListPeopleType;
        break;
      case "es_ES":
        list = esListPeopleType;
        break;
      case "es_US":
        list = esListPeopleType;
        break;
      default:
        list = enListPeopleType;
    }
    return enListPeopleType;
  }

  List<String> getListCondition() {
    String lang = TranslationService.locale.toString();
    List<String> list = [];

    /* switch (lang) {
      case "it_IT":
        list = itListCondition;
        break;
      case "en_US":
        list = enListCondition;
        break;
      case "es_ES":
        list = esListCondition;
        break;
         case "es_US":
        list = esListCondition;
        break;
      default:
        list = enListCondition;
    }*/
    return enListCondition;
  }

  List<String> getListAdType() {
    String lang = TranslationService.locale.toString();
    List<String> list = [];

    this.currentCatStr == "MUEBLES"
        ? list = mueblesListEn
        : this.currentCatStr == "ASESOR"
            ? list = asesorListEn
            : this.currentCatStr == "ACTIVIDAD"
                ? list = buyListEn
                : this.currentCatStr == "FRANQUICIA"
                    ? list = buyListEn
                    : this.currentCatStr == "PROVEEDOR"
                        ? list = proveedorListEn
                        : this.currentCatStr == "EMPRENDEDOR"
                            ? list = emprendedorListEn
                            : this.currentCatStr == "FURNITURE"
                                ? list = mueblesListEn
                                : this.currentCatStr == "ADVISER"
                                    ? list = asesorListEn
                                    : this.currentCatStr == "ACTIVITY"
                                        ? list = buyListEn
                                        : this.currentCatStr == "FRANCHISE"
                                            ? list = buyListEn
                                            : this.currentCatStr == "PROVIDER"
                                                ? list = proveedorListEn
                                                : this.currentCatStr ==
                                                        "ENTREPRENEUR"
                                                    ? list = emprendedorListEn
                                                    : list = buyListEn;

    /* switch (lang) {
      case "it_IT":
        this.currentCatStr == "MUEBLES"
            ? list = mueblesListIt
            : this.currentCatStr == "ASESOR"
                ? list = asesorListIt
                : this.currentCatStr == "ACTIVIDAD"
                    ? list = buyListIt
                    : this.currentCatStr == "FRANQUICIA"
                        ? list = buyListIt
                        : this.currentCatStr == "PROVEEDOR"
                            ? list = proveedorListIt
                            : this.currentCatStr == "EMPRENDEDOR"
                                ? list = emprendedorListIt
                                : list = buyListIt;

        break;
      case "es_ES":
        this.currentCatStr == "MUEBLES"
            ? list = mueblesListEs
            : this.currentCatStr == "ASESOR"
                ? list = asesorListEs
                : this.currentCatStr == "ACTIVIDAD"
                    ? list = buyListEs
                    : this.currentCatStr == "FRANQUICIA"
                        ? list = buyListEs
                        : this.currentCatStr == "PROVEEDOR"
                            ? list = proveedorListEs
                            : this.currentCatStr == "EMPRENDEDOR"
                                ? list = emprendedorListEs
                                : list = buyListEs;

        break;
        case "es_US":
        this.currentCatStr == "MUEBLES"
            ? list = mueblesListEs
            : this.currentCatStr == "ASESOR"
                ? list = asesorListEs
                : this.currentCatStr == "ACTIVIDAD"
                    ? list = buyListEs
                    : this.currentCatStr == "FRANQUICIA"
                        ? list = buyListEs
                        : this.currentCatStr == "PROVEEDOR"
                            ? list = proveedorListEs
                            : this.currentCatStr == "EMPRENDEDOR"
                                ? list = emprendedorListEs
                                : list = buyListEs;

        break;
      case "en_US":
        this.currentCatStr == "MUEBLES"
            ? list = mueblesListEn
            : this.currentCatStr == "ASESOR"
                ? list = asesorListEn
                : this.currentCatStr == "ACTIVIDAD"
                    ? list = buyListEn
                    : this.currentCatStr == "FRANQUICIA"
                        ? list = buyListEn
                        : this.currentCatStr == "PROVEEDOR"
                            ? list = proveedorListEn
                            : this.currentCatStr == "EMPRENDEDOR"
                                ? list = emprendedorListEn
                                : list = buyListEn;

        break;
      default:
        this.currentCatStr == "MUEBLES"
            ? list = buyListEn
            : this.currentCatStr == "ASESOR"
                ? list = asesorListEn
                : this.currentCatStr == "ACTIVIDAD"
                    ? list = buyListEn
                    : this.currentCatStr == "FRANQUICIA"
                        ? list = buyListEn
                        : this.currentCatStr == "PROVEEDOR"
                            ? list = proveedorListEn
                            : this.currentCatStr == "EMPRENDEDOR"
                                ? list = emprendedorListEn
                                : list = buyListEn;
    }*/
    return list;
  }

  Future<void> refreshProducts() async {
    String category = "";

    postReady.value = false;

    final products = await apiRepository.getPosts(category: category);

    if (products != null) {
      this.allProducts.value = products;
      this.allProducts.refresh();
      postReady.value = true;
    }

    /*this.allProducts.value = (await apiRepository.getPosts(category: category))!;
    this.allProducts.refresh();
    postReady.value = true;*/
  }

  Future<void> getPostAdHome() async {
    String category = this.currentCat.value.nameEs ?? "";

    postReady.value = false;

    final products = await apiRepository.getPosts(category: category);
    postReady.value = true;
    if (products != null) {
      this.allProducts.value = products;
      //this.allProducts.refresh();
    }

    /*this.allProducts.value = (await apiRepository.getPosts(category: category)  )!;
    this.allProducts.refresh();*/
  }

  Future<void> getPostAdHomeAll() async {
    String category = "";

    postReady.value = false;

    final products = await apiRepository.getPosts(category: category);
    postReady.value = true;
    if (products != null) {
      this.allProducts.value = products;
      //this.allProducts.refresh();
    }

    /*this.allProducts.value = (await apiRepository.getPosts(category: category)  )!;
    this.allProducts.refresh();*/
  }

  Future<void> getPostAdToFilterScreen(int id, String filter) async {
    String category = currentCat.value.nameEs ?? "";
    if (id == 1) category = "";
    print("=============CATEGORY ================= $category");

    //postReady.value = false;

    this.filtersProducts.value =
        (await apiRepository.getPosts(category: category, filter: filter))!;
    //this.filtersProducts.refresh();
    //postReady.value = true;
  }

  Future<bool> getRecentlyProducts() async {
    productsRecentlyReady.value = false;

    final productsRecent =
        await apiRepository.getRecentlyProducts(this.userStrapi.value!.id!);

    var isOkay = false;

    if (productsRecent != null) {
      this.recentlyProducts.value = productsRecent;
      //this.recentlyProducts.refresh();
      productsRecentlyReady.value = true;
      isOkay = true;
    }
    return isOkay;

    /* this.recentlyProducts.value = (await apiRepository.getRecentlyProducts(this.userStrapi.value!.id!))!;
    this.recentlyProducts.refresh();
    productsRecentlyReady.value = true;
    return true;*/
  }

  Future<String> confirmPayment(int id, String period) async {
    return (await apiRepository.getConfirmPayment(id, period));
  }

  Future<bool> addToRecentlyProducts(int productId) async {
    bool result = false;
    if (this.userStrapi.value != null)
      result = (await apiRepository.addToRecentlyProducts(
          this.userStrapi.value!.id!, productId))!;
    return result;
  }

  /*Future<void> getAllPostAd() async {
   /* String cat = getActualCateogry();
    print('category: ' + cat);
    postReady.value = false;
    this.allProducts.value = (await apiRepository.getAllPosts(category: cat))!;
    this.allProducts.refresh();
    postReady.value = true;*/
  }*/

  /* void getPostListAd(EnumCategoryList enumCategoryList) {
    this.allProducts.clear();
    setCategory(enumCategoryList);
    getPostAd();
  }*/

  Future<void> getAllPostDraftPublished() async {
    postReady.value = false;

    final products = await apiRepository.getAllPostsDraftPublished();

    if (products != null) {
      this.allProducts.value = products;
      this.allProducts.refresh();
      postReady.value = true;
    }

    /*this.allProducts.value = (await apiRepository.getAllPostsDraftPublished()  )!;
    this.allProducts.refresh();
    postReady.value = true;*/
  }

  void getMyPostListAd() {
    getAllPostDraftPublished().then((value) {
      this.myProducts.value = this
          .allProducts
          .where((e) => e.user!.id == this.userStrapi.value!.id)
          .toList();
      this.myProducts.refresh();
      Future.delayed(Duration(seconds: 1), () {
        refreshProducts();
      });
    });
  }

  Future<Products?> addFavorite(Products product) async {
    //print("user sttrapi. ${userStrapi.value!.id}");

    return await apiRepository
        .addProductLike(
            Likes(userId: this.userStrapi.value!.id!, productId: product.id!))
        .then((value) async => await apiRepository.getPostsById(product.id!));
  }

  Future<Products?> removeFavorite(int likeId, int productId) async {
    return await apiRepository
        .removeProductLike(likeId)
        .then((value) async => await apiRepository.getPostsById(productId));
  }

  Future<void> getLikedPosts() async {
    await apiRepository.getProductsLiked(userStrapi.value!.id!).then((value) {
      if (value != null) {
        this.likedProducts.value = value;
        this.allProducts.refresh();
      }
    });
  }

  Future<void> getPostAdFilter(int serach) async {
    currentAdTypeStr = publishAdModel.value.currenTypeAd == EnumTypeAdList.none
        ? getTypeAdList()[0]
        : getActualTypeAd(index: 1);

    print("ggggggggggg------------------${currentAdTypeStr}");

    String locale = TranslationService.locale.toString();
    /* String cat = getActualCateogry();
    print('category: ' + cat);*/
    String query = '';
    if (this.controllerSearch.text.length > 0) {
      query += '&title_contains=${controllerSearch.text}';
    }

    if (serach == 1) {
      final products = await apiRepository.getPostsByFilterSearch(query);
      if (products != null) {
        this.filtersProducts.value = products;
        //this.filtersProducts.refresh();
      }
    } else {
      if (this.currentCatStr != "") {
        query += "&category=${this.currentCat.value.nameEs}";
      }

      if (this.currentSubCatStr != "" && this.currentSubCatStr != 'Select:') {
        print("=======================LANG====================== $locale");

        switch (locale.substring(0, 3)) {
          case "en_":
            {
              query += "&sub_category.name_en=${this.currentSubCatStr}";
            }
            break;
          case "it_":
            {
              query += "&sub_category.name_it=${this.currentSubCatStr}";
            }
            break;
          case "es_":
            {
              query += "&sub_category.name_es=${this.currentSubCatStr}";
            }
            break;
          default:
        }
      }

      //Todo:  FILTROS PARA EL PEOPLE - TYPE=====================

      // switch (locale.substring(0, 3)) {
      //   case "en_":
      //     {
      //       if (currenPeopleTypeStr == "Private") {
      //         query += "&_where[people_type_contains]=Private";
      //       } else if (currenPeopleTypeStr == "IVA") {
      //         query += "&_where[people_type_contains]=IVA";
      //       } else if (currenPeopleTypeStr == "Agency") {
      //         query += "&_where[people_type_contains]=Agency";
      //       }
      //     }
      //     break;
      //   case "it_":
      //     {
      //       if (currenPeopleTypeStr == "Privato") {
      //         query += "&_where[people_type_contains]=Privato";
      //       } else if (currenPeopleTypeStr == "Partita IVA") {
      //         query += "&_where[people_type_contains]=Partita IVA";
      //       } else if (currenPeopleTypeStr == "Azienda") {
      //         query += "&_where[people_type_contains]=Azienda";
      //       }
      //     }
      //     break;
      //   case "es_":
      //     {
      //       if (currenPeopleTypeStr == "Privado") {
      //         query += "&_where[people_type_contains]=Privado";
      //       } else if (currenPeopleTypeStr == "IVA") {
      //         query += "&_where[people_type_contains]=IVA";
      //       } else if (currenPeopleTypeStr == "Agencia") {
      //         query += "&_where[people_type_contains]=Agencia";
      //       }
      //     }
      //     break;
      //   default:
      // }

      // //==================================================FILTRO ADTYPE =====================================================================

      // if (currentAdTypeStr == "Sell" || currentAdTypeStr == "Vendo") {
      //   if (currentAdTypeStr == "Sell")
      //     query += "&_where[ad_type_contains]=Sell";
      //   else
      //     query += "&_where[ad_type_contains]=Vendo";
      // } else if (currentAdTypeStr == "Buy" || currentAdTypeStr == "Compro") {
      //   if (currentAdTypeStr == "Buy")
      //     query += "&_where[ad_type_contains]=Buy";
      //   else
      //     query += "&_where[ad_type_contains]=Compro";
      // } else if (currentAdTypeStr == "Rent" ||
      //     currentAdTypeStr == "Rento" ||
      //     currentAdTypeStr == "Affitto" ||
      //     currentAdTypeStr == "Noleggio") {
      //   if (currentCat.value.nameEs != "MUEBLES") {
      //     if (currentAdTypeStr == "Rent")
      //       query += "&_where[ad_type_contains]=Rent";
      //     else if (currentAdTypeStr == "Rento")
      //       query += "&_where[ad_type_contains]=Rento";
      //     else if (currentAdTypeStr == "Noleggio")
      //       query += "&_where[ad_type_contains]=Noleggio";
      //   } else {
      //     print("CATEGORIA MUEBLES============");
      //     if (currentAdTypeStr == "Rent")
      //       query += "&_where[ad_type_contains]=Rent";
      //     else if (currentAdTypeStr == "Rento")
      //       query += "&_where[ad_type_contains]=Rento";
      //     else if (currentAdTypeStr == "Affitto")
      //       query += "&_where[ad_type_contains]=Affitto";
      //   }
      // } else if (currentAdTypeStr == "I am a supplier" ||
      //     currentAdTypeStr == "Soy proveedor" ||
      //     currentAdTypeStr == "Sono Fornitore") {
      //   if (currentAdTypeStr == "I am a supplier")
      //     query += "&_where[ad_type_contains]=I am a supplier";
      //   else if (currentAdTypeStr == "Soy proveedor")
      //     query += "&_where[ad_type_contains]=Soy proveedor";
      //   else if (currentAdTypeStr == "Sono Fornitore")
      //     query += "&_where[ad_type_contains]=Sono Fornitore";
      // } else if (currentAdTypeStr == "Searching a supplier" ||
      //     currentAdTypeStr == "Busco proveedor" ||
      //     currentAdTypeStr == "Cerca Fornitore") {
      //   if (currentAdTypeStr == "Searching a supplier")
      //     query += "&_where[ad_type_contains]=Searching a supplier";
      //   else if (currentAdTypeStr == "Busco proveedor")
      //     query += "&_where[ad_type_contains]=Busco proveedor";
      //   else if (currentAdTypeStr == "Cerca Fornitore")
      //     query += "&_where[ad_type_contains]=Cerca Fornitore";
      // } else if (currentAdTypeStr == "I am an adviser" ||
      //     currentAdTypeStr == "Soy asesor" ||
      //     currentAdTypeStr == "Sono Consulente") {
      //   if (currentAdTypeStr == "I am an adviser")
      //     query += "&_where[ad_type_contains]=I am an adviser";
      //   else if (currentAdTypeStr == "Soy asesor")
      //     query += "&_where[ad_type_contains]=Soy asesor";
      //   else if (currentAdTypeStr == "Sono Consulente")
      //     query += "&_where[ad_type_contains]=Sono Consulente";
      // } else if (currentAdTypeStr == "Searching an adviser" ||
      //     currentAdTypeStr == "Busco asesor" ||
      //     currentAdTypeStr == "Cerca Consulente") {
      //   if (currentAdTypeStr == "Searching an adviser")
      //     query += "&_where[ad_type_contains]=Searching an adviser";
      //   else if (currentAdTypeStr == "Busco asesor")
      //     query += "&_where[ad_type_contains]=Busco asesor";
      //   else if (currentAdTypeStr == "Cerca Consulente")
      //     query += "&_where[ad_type_contains]=Cerca Consulente";
      // } else if (currentAdTypeStr == "I am entrepreneur" ||
      //     currentAdTypeStr == "Soy emprendedor" ||
      //     currentAdTypeStr == "Sono Imprenditore") {
      //   if (currentAdTypeStr == "I am entrepreneur")
      //     query += "&_where[ad_type_contains]=I am entrepreneur";
      //   else if (currentAdTypeStr == "Soy emprendedor")
      //     query += "&_where[ad_type_contains]=Soy emprendedor";
      //   else if (currentAdTypeStr == "Sono Imprenditore")
      //     query += "&_where[ad_type_contains]=Sono Imprenditore";
      // } else if (currentAdTypeStr == "Searching an entrepreneur" ||
      //     currentAdTypeStr == "Busco emprendedor" ||
      //     currentAdTypeStr == "Cerca Imprenditore") {
      //   if (currentAdTypeStr == "Searching an entrepreneur")
      //     query += "&_where[ad_type_contains]=Searching an entrepreneur";
      //   else if (currentAdTypeStr == "Busco emprendedor")
      //     query += "&_where[ad_type_contains]=Busco emprendedor";
      //   else if (currentAdTypeStr == "Cerca Imprenditore")
      //     query += "&_where[ad_type_contains]=Cerca Imprenditore";
      // }

      switch (locale.substring(0, 3)) {
        case "en_":
          {
            if (currenPeopleTypeStr == "Private") {
              query += "&_where[people_type_contains]=Private";
            } else if (currenPeopleTypeStr == "IVA") {
              query += "&_where[people_type_contains]=IVA";
            } else if (currenPeopleTypeStr == "Agency") {
              query += "&_where[people_type_contains]=Agency";
            }
          }
          break;
        case "it_":
          {
            if (currenPeopleTypeStr == "Privato") {
              query += "&_where[people_type_contains]=Private";
            } else if (currenPeopleTypeStr == "Partita IVA") {
              query += "&_where[people_type_contains]=IVA";
            } else if (currenPeopleTypeStr == "Azienda") {
              query += "&_where[people_type_contains]=Agency";
            }
          }
          break;
        case "es_":
          {
            if (currenPeopleTypeStr == "Privado") {
              query += "&_where[people_type_contains]=Private";
            } else if (currenPeopleTypeStr == "IVA") {
              query += "&_where[people_type_contains]=IVA";
            } else if (currenPeopleTypeStr == "Agencia") {
              query += "&_where[people_type_contains]=Agency";
            }
          }
          break;
        default:
      }

      //==================================================FILTRO ADTYPE =====================================================================

      if (currentAdTypeStr == "Sell" || currentAdTypeStr == "Vendo") {
        query += "&_where[ad_type_contains]=Sell";
      } else if (currentAdTypeStr == "Buy" || currentAdTypeStr == "Compro") {
        query += "&_where[ad_type_contains]=Buy";
      } else if (currentAdTypeStr == "Rent" ||
          currentAdTypeStr == "Rento" ||
          currentAdTypeStr == "Affitto" ||
          currentAdTypeStr == "Noleggio") {
        if (currentCat.value.nameEs != "MUEBLES") {
          if (currentAdTypeStr == "Rent")
            query += "&_where[ad_type_contains]=Rent";
          else if (currentAdTypeStr == "Rento")
            query += "&_where[ad_type_contains]=Rent";
          else if (currentAdTypeStr == "Affitto")
            query += "&_where[ad_type_contains]=Rent";
        } else {
          print("CATEGORIA MUEBLES============");
          if (currentAdTypeStr == "Rent")
            query += "&_where[ad_type_contains]=Rent";
          else if (currentAdTypeStr == "Rento")
            query += "&_where[ad_type_contains]=Rent";
          else if (currentAdTypeStr == "Noleggio")
            query += "&_where[ad_type_contains]=Noleggio";
        }
      } else if (currentAdTypeStr == "I am a supplier" ||
          currentAdTypeStr == "Soy proveedor" ||
          currentAdTypeStr == "Sono Fornitore") {
        if (currentAdTypeStr == "I am a supplier")
          query += "&_where[ad_type_contains]=I am a supplier";
        else if (currentAdTypeStr == "Soy proveedor")
          query += "&_where[ad_type_contains]=I am a supplier";
        else if (currentAdTypeStr == "Sono Fornitore")
          query += "&_where[ad_type_contains]=I am a supplier";
      } else if (currentAdTypeStr == "Searching a supplier" ||
          currentAdTypeStr == "Busco proveedor" ||
          currentAdTypeStr == "Cerca Fornitore") {
        if (currentAdTypeStr == "Searching a supplier")
          query += "&_where[ad_type_contains]=Searching a supplier";
        else if (currentAdTypeStr == "Busco proveedor")
          query += "&_where[ad_type_contains]=Searching a supplier";
        else if (currentAdTypeStr == "Cerca Fornitore")
          query += "&_where[ad_type_contains]=Searching a supplier";
      } else if (currentAdTypeStr == "I am an adviser" ||
          currentAdTypeStr == "Soy asesor" ||
          currentAdTypeStr == "Sono Consulente") {
        if (currentAdTypeStr == "I am an adviser")
          query += "&_where[ad_type_contains]=I am an adviser";
        else if (currentAdTypeStr == "Soy asesor")
          query += "&_where[ad_type_contains]=I am an adviser";
        else if (currentAdTypeStr == "Sono Consulente")
          query += "&_where[ad_type_contains]=I am an adviser";
      } else if (currentAdTypeStr == "Searching an adviser" ||
          currentAdTypeStr == "Busco asesor" ||
          currentAdTypeStr == "Cerca Consulente") {
        if (currentAdTypeStr == "Searching an adviser")
          query += "&_where[ad_type_contains]=Searching an adviser";
        else if (currentAdTypeStr == "Busco asesor")
          query += "&_where[ad_type_contains]=Searching an adviser";
        else if (currentAdTypeStr == "Cerca Consulente")
          query += "&_where[ad_type_contains]=Searching an adviser";
      } else if (currentAdTypeStr == "I am entrepreneur" ||
          currentAdTypeStr == "Soy emprendedor" ||
          currentAdTypeStr == "Sono Imprenditore") {
        if (currentAdTypeStr == "I am entrepreneur")
          query += "&_where[ad_type_contains]=I am entrepreneur";
        else if (currentAdTypeStr == "Soy emprendedor")
          query += "&_where[ad_type_contains]=I am entrepreneur";
        else if (currentAdTypeStr == "Sono Imprenditore")
          query += "&_where[ad_type_contains]=I am entrepreneur";
      } else if (currentAdTypeStr == "Searching an entrepreneur" ||
          currentAdTypeStr == "Busco emprendedor" ||
          currentAdTypeStr == "Cerca Imprenditore") {
        if (currentAdTypeStr == "Searching an entrepreneur")
          query += "&_where[ad_type_contains]=Searching an entrepreneur";
        else if (currentAdTypeStr == "Busco emprendedor")
          query += "&_where[ad_type_contains]=Searching an entrepreneur";
        else if (currentAdTypeStr == "Cerca Imprenditore")
          query += "&_where[ad_type_contains]=Searching an entrepreneur";
      }

      if (controllerPrice.text.isNotEmpty) {
        query += '&_where[price_gte]=${controllerPrice.text}';
      }
      if (controllerPriceMax.text.isNotEmpty) {
        query += '&_where[price_lte]=${controllerPriceMax.text}';
      }
      print("mmmmmmmmmmmmm--------------------${query}");

      final products = await apiRepository.getPostsByFilter(query);

      if(serach == 1) publishAdModel.value.currenTypeAd = EnumTypeAdList.none;
      if (products != null) {
        this.filtersProducts.value = products;
      }
    }
  }

  void setActualProduct(Products product) {
    String lang = TranslationService.locale.toString();

    this.publishAdModel.value.currentCategory =
        getEnumCategoryFromString(product.category);
    this.publishAdModel.value.currenTypeAd =
        getEnumTypeAdFromString(product.adType);
    //this.publishAdModel.value.currentSubCategory =getEnumSubCategoryFromString(product.subCategory);
    this.controllerTitle.text = product.title;
    this.controllerDescription.text = product.description;
    this.controllerPrice.text = product.price.toString();
    this.controllerPhone.text =
        product.phoneNumber != 0 ? product.phoneNumber.toString() : '';
    this.peopleType = product.peopleType;
    this.statusProduct = product.statusProduct;
    this.city = product.city;
    this.idProduct = product.id!;
    this.multimediaProduct = product.multimedia!;
    this.userProduct = product.user;
    this.actualProduct = product;
    this.controllerNewCategoria.text = product.category;
  }

  Future<void> removeImage(int id) async {
    (await apiRepository.removeImage(id))!;
  }

  void updatePostAd() async {
    var updatedPost = await apiRepository.updateProducthAd(
        Products(
            title: controllerTitle.text,
            description: controllerDescription.text,
            city: city,
            currency: 'dollar',
            peopleType: this.currenPeopleTypeStr,
            price: double.parse(controllerPrice.text),
            phoneNumber: controllerPhone.text.isNotEmpty
                ? int.parse(controllerPhone.text)
                : 0,
            statusProduct: this.statusProduct,
            status: 'published',
            adType: this.currentAdTypeStr,
            category: "FURNITURE",
            subCategory: await getSubCatToPost(this.currentSubCatStr),
            user: this.userStrapi.value),
        this.actualProduct!.id!);
    imagesToUpload.forEach((element) async {
      print("Imagen!");
      if (element.path != '') {
        var imageUploaded = await apiRepository.uploadImage(
            File(element.path),
            'product',
            'multimedia',
            updatedPost!.id!,
            DateTime.now().toString());
        //print(imageUploaded!.url);
      }
    });
    setCategory(publishAdModel.value.currentCategory);
    getMyPostListAd();
    //setActualProduct(updatedPost!);
    Get.back();
    cleanControllers();
  }

  void updateProduct() async {
    Get.defaultDialog(
      title: "update_title".tr,
      titleStyle: TextStyle(fontSize: 18.sp),
      content: Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      var updatedPost = await apiRepository.updateProduct(
          Products(
              title: controllerTitle.text,
              description: controllerDescription.text,
              city: city,
              country: "USA",
              currency: 'euro',
              peopleType: this.currenPeopleTypeStr,
              price: double.parse(controllerPrice.text),
              phoneNumber: controllerPhone.text.isNotEmpty
                  ? int.parse(controllerPhone.text)
                  : 0,
              statusProduct: this.statusProduct,
              status: 'published',
              adType: this.currentAdTypeStr,
              category: controllerNewCategoria.text,
              subCategory: await getSubCatToPost(this.currentSubCatStr),
              user: this.userStrapi.value),
          this.actualProduct!.id!);

      //termino update

      imagesToUpload.forEach((element) async {
        print("Imagen!");
        if (element.path != '') {
          var imageUploaded = await apiRepository.uploadImage(
              File(element.path),
              'product',
              'multimedia',
              updatedPost!,
              DateTime.now().toString());
        }
      });
      Get.back();
      //MOSTRAR SNACKBAR

      Get.snackbar("msg".tr, "update_ok".tr,
          backgroundColor: ColorConstants.principalColor,
          colorText: Colors.white,
          duration: Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM, snackbarStatus: (status) async {
        if (status == SnackbarStatus.CLOSED) {
          setCategory(publishAdModel.value.currentCategory);
          getMyPostListAd();
          final prodUpdated = await apiRepository.getProduct(updatedPost);
          setCurrentProduct(prodUpdated);
          //setActualProduct(updatedPost!);
          Get.back();
          cleanControllers();
        }
      });
    } catch (e) {
      Get.snackbar("Error", "error_update".tr,
          backgroundColor: ColorConstants.principalColor,
          colorText: Colors.white,
          duration: Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  var currentproduct = Products(
          title: "",
          category: "",
          subCategory: SubCategory(),
          currency: "",
          adType: "",
          description: "",
          phoneNumber: 1,
          statusProduct: "",
          peopleType: "",
          price: 1,
          city: "")
      .obs;

  setCurrentProduct(Products product) {
    this.currentproduct.value = product;
    this.currentproduct.refresh();
  }

  void disabledProduct(Products product) async {
    product.status = 'draft';

    var updatedPost =
        await apiRepository.changeProductStatus(product, product.id!);

    getMyPostListAd();
  }

  void publishProduct(Products product) async {
    product.status = 'published';
    var updatedPost =
        await apiRepository.changeProductStatus(product, product.id!);
    getMyPostListAd();
  }

  void removeProduct(Products product) async {
    if (product.multimedia != null) {
      product.multimedia!.map((e) => removeImage(e.id));
    }
    var updatedPost = await apiRepository.removeProduct(product.id!);
    getMyPostListAd();
  }
}
