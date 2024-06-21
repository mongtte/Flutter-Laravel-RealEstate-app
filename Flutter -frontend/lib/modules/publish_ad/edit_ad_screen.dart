import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/lang/translation_service.dart';
//import 'package:hero/modules/home/home_controller.dart';
import 'package:hero/modules/publish_ad/publish_ad_controller.dart';
import 'package:hero/modules/publish_ad/widgets/dropdown_button_form.dart';
import 'package:hero/modules/publish_ad/widgets/dropdown_google_places.dart';
import 'package:hero/modules/publish_ad/widgets/select_image.dart';
//import 'package:hero/modules/registry/widgets/custom_radio_button.dart';
import 'package:hero/routes/routes.dart';
import 'package:hero/shared/constants/colors.dart';
import 'package:hero/shared/shared.dart';
import 'package:hero/theme/theme_data.dart';

class EditAdScreen extends StatefulWidget {
  @override
  _EditAdScreenState createState() => _EditAdScreenState();
}

class _EditAdScreenState extends State<EditAdScreen> {
  var controller = Get.find<PublishAdController>();
  final ScrollController _scrollController = new ScrollController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool hidePhoneNumber = false;
  //List<String> peopleTypeList = ['Privato', 'Partita IVA', 'Azienda'];
  @override
  Widget build(BuildContext context) {
    print("Arguments subcategoryList: ${Get.arguments}");
    return _bodyBuilder(Get.arguments);
  }

  _bodyBuilder(List<String> subcategoryList) {
    String local = TranslationService.locale.toString();
    controller.currentCatStr = controller.controllerNewCategoria.text;
    return WillPopScope(
      onWillPop: () async {
        //final homeController = Get.find<HomeController>();
        controller.cleanControllers();
        controller.setCategory(EnumCategoryList.none);
        controller.getMyPostListAd();
        Get.toNamed(Routes.HOME);

        return true;
      },
      child: Stack(children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 20, right: 16, left: 16, bottom: 60),
          child: Form(
            key: formKey,
            child: ListView(
              controller: _scrollController,
              children: [
                TitlePrincipalAds(local.substring(0, 3) == "it_"
                    ? "Categoria"
                    : local.substring(0, 3) == "en_"
                        ? "Category"
                        : "Categoría"),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: TextFormField(
                    controller: controller.controllerNewCategoria,
                    enabled: false
                    /* validator: (val) {
                      if (val!.isEmpty) {
                        _scrollController.animateTo(
                          0.0,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 300),
                        );
                        return 'Devi catturare questo campo';
                      }
                      if (val.length < 5) {
                        _scrollController.animateTo(
                          0.0,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 300),
                        );
                        return 'Requires at least 5 characters.';
                      }
                      return null;
                    },*/
                    ,
                    style: ThemeConfig.bodyText1.override(
                      color: Color(0xFF3C4858),
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                    decoration: InputDecoration(
                        labelStyle: ThemeConfig.bodyText1.override(
                          color: Color(0xFFB4B4B4),
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                        border: OutlineInputBorder(),
                        isDense: true,
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 0.7)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFB4B4B4), width: 0.7))),
                  ),
                ),
                /* Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: InkWell(
                    child: TextFormField(
                      initialValue: controller.getActualCateogry(),
                      enabled: false,
                      style: ThemeConfig.bodyText1.override(
                        color: Color(0xFF3C4858),
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                      decoration: InputDecoration(
                          labelText: !hidePhoneNumber
                              ? 'Seleziona una categoria'
                              : 'Devi mostrare il tuo telefono',
                          labelStyle: ThemeConfig.bodyText1.override(
                            color: Color(0xFFB4B4B4),
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          border: OutlineInputBorder(),
                          isDense: true,
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 0.7)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFB4B4B4), width: 0.7))),
                    ),
                    onTap: () => CommonWidget.showInfo(
                        'Non puoi cambiare la categoria, ma pubblica un nuovo annuncio'),
                  ),
                ),*/
                SizedBox(
                  height: 20,
                ),
                TitlePrincipalAds('adtype_ad'.tr),
                DropDownButtonFormAdType(
                  listOptions: controller.getListAdType(),
                  actualValue: controller.getListAdType()[0],
                  type: EnumTypeList.typePerson,
                ),
                /*RadioButtonForm(
                  options: controller.getTypeAdList(),
                  onChanged: (value) {
                    controller.setTypeAdcategory(
                        getEnumTypeAdFromString(value!),
                        next: false);
                  },
                  defaultOption: controller.getActualTypeAd(),
                  optionHeight: 25,
                  textStyle: ThemeConfig.bodyText1
                      .override(color: Colors.black, fontSize: 13),
                  buttonPosition: RadioButtonPosition.left,
                  direction: controller.publishAdModel.value.currentCategory ==
                              EnumCategoryList.supplier ||
                          controller.publishAdModel.value.currentCategory ==
                              EnumCategoryList.consultant ||
                          controller.publishAdModel.value.currentCategory ==
                              EnumCategoryList.entrepreneur
                      ? Axis.vertical
                      : Axis.horizontal,
                  radioButtonColor: ColorConstants.principalColor,
                  inactiveRadioButtonColor: Color(0x8A000000),
                  toggleable: false,
                  horizontalAlignment: WrapAlignment.spaceBetween,
                  verticalAlignment: WrapCrossAlignment.start,
                ),*/
                SizedBox(
                  height: 20,
                ),
                TitlePrincipalAds(local.substring(0, 3) == "it_"
                    ? "Sottocategoria"
                    : local.substring(0, 3) == "en_"
                        ? "Subcategory"
                        : "Subcategoría"),
                DropDownButtonForm(
                  listOptions: subcategoryList,
                  actualValue: subcategoryList[0],
                  type: EnumTypeList.subCategory,
                ),
                SizedBox(
                  height: 20,
                ),
                TitlePrincipalAds(local.substring(0, 3) == "it_"
                    ? "Telefono"
                    : local.substring(0, 3) == "en_"
                        ? "Phone"
                        : "Teléfono"),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: TextFormField(
                    controller: controller.controllerPhone,
                    keyboardType: TextInputType.phone,
                    enabled: !hidePhoneNumber,
                    validator: (val) {
                      if (!hidePhoneNumber) {
                        if (val!.isEmpty) {
                          _scrollController.animateTo(
                            SizeConfig().screenHeight,
                            curve: Curves.easeOut,
                            duration: const Duration(milliseconds: 300),
                          );
                          return 'require_insert'.tr;
                        }
                        if (val.length < 1) {
                          _scrollController.animateTo(
                            SizeConfig().screenHeight,
                            curve: Curves.easeOut,
                            duration: const Duration(milliseconds: 300),
                          );
                          return 'Requires at least 1 characters.';
                        }
                      }
                      return null;
                    },
                    style: ThemeConfig.bodyText1.override(
                      color: Color(0xFF3C4858),
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                    decoration: InputDecoration(
                        labelText: !hidePhoneNumber
                            ? local.substring(0, 3) == "it_"
                                ? "Scrivi il tuo telefono"
                                : local.substring(0, 3) == "en_"
                                    ? "Type your phone number"
                                    : "Escriba su teléfono"
                            : local.substring(0, 3) == "it_"
                                ? "Devi mostrare il tuo telefono"
                                : local.substring(0, 3) == "en_"
                                    ? "You should show your phone number"
                                    : "Debe mostrar su teléfono",
                        labelStyle: ThemeConfig.bodyText1.override(
                          color: Color(0xFFB4B4B4),
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                        border: OutlineInputBorder(),
                        isDense: true,
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 0.7)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFB4B4B4), width: 0.7))),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      local.substring(0, 3) == "it_"
                          ? "Nascondi telefono"
                          : local.substring(0, 3) == "en_"
                              ? "Hide phone number"
                              : "Ocultar teléfono",
                      textAlign: TextAlign.left,
                      textScaleFactor: 1,
                      style: ThemeConfig.bodyText1.override(
                        color: ColorConstants.titlePrincipal,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Switch(
                      value: hidePhoneNumber,
                      onChanged: (value) {
                        setState(() {
                          hidePhoneNumber = value;
                          print(hidePhoneNumber);
                        });
                      },
                      activeTrackColor: ColorConstants.secondaryAppColor,
                      activeColor: ColorConstants.principalColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TitlePrincipalAds(local.substring(0, 3) == "it_"
                    ? "Immagini"
                    : local.substring(0, 3) == "en_"
                        ? "Images"
                        : "Imágenes"),
                controller.multimediaProduct.length == 0
                    ? SizedBox()
                    : Carousel(
                        controller.multimediaProduct.map((e) {
                          return Container(
                            padding: const EdgeInsets.only(right: 20),
                            child: Stack(children: [
                              Container(
                                  width: 150,
                                  height: 150,
                                  child: CachedNetworkImage(
                                      imageUrl: e.url, fit: BoxFit.cover)),
                              InkWell(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Card(
                                    color: Colors.red.withOpacity(0.5),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 5),
                                      child: Text(
                                        local.substring(0, 3) == "it_"
                                            ? "Rimuovere"
                                            : local.substring(0, 3) == "en_"
                                                ? "Remove"
                                                : "Remover",
                                        style: ThemeConfig.bodyText1
                                            .override(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  controller.removeImage(e.id).then((value) {
                                    setState(() {
                                      controller.multimediaProduct.remove(e);
                                    });
                                  });
                                },
                              )
                            ]),
                          );
                        }).toList(),
                        enableInfiniteScroll: false,
                        height: 150),
                SizedBox(
                  height: 20,
                ),
                SelectImage(),
                SizedBox(
                  height: 20,
                ),
                TitlePrincipalAds(local.substring(0, 3) == "it_"
                    ? "Titolo dell\'annuncio"
                    : local.substring(0, 3) == "en_"
                        ? "Ad title"
                        : "Título del anuncio"),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: TextFormField(
                    controller: controller.controllerTitle,
                    validator: (val) {
                      if (val!.isEmpty) {
                        _scrollController.animateTo(
                          0.0,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 300),
                        );
                        return 'require_insert'.tr;
                      }
                      if (val.length < 5) {
                        _scrollController.animateTo(
                          0.0,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 300),
                        );
                        return 'require_least'.tr;
                      }
                      return null;
                    },
                    style: ThemeConfig.bodyText1.override(
                      color: Color(0xFF3C4858),
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                    decoration: InputDecoration(
                        labelStyle: ThemeConfig.bodyText1.override(
                          color: Color(0xFFB4B4B4),
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                        border: OutlineInputBorder(),
                        isDense: true,
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 0.7)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFB4B4B4), width: 0.7))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TitlePrincipalAds(local.substring(0, 3) == "it_"
                    ? "Testo dell\'annuncio"
                    : local.substring(0, 3) == "en_"
                        ? "Ad description"
                        : "Descripción del anuncio"),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: TextFormField(
                    controller: controller.controllerDescription,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'require_insert'.tr;
                      }
                      if (val.length < 5) {
                        return 'require_least'.tr;
                      }
                      return null;
                    },
                    maxLines: 5,
                    minLines: 5,
                    style: ThemeConfig.bodyText1.override(
                      color: Color(0xFF3C4858),
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                    decoration: InputDecoration(
                        labelStyle: ThemeConfig.bodyText1.override(
                          color: Color(0xFFB4B4B4),
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: local.substring(0, 3) == "it_"
                            ? "Scrivi una descrizione \ndel tuo annuncio, ricorda che non \ndeve contenere spam o nessun \nindirizzo email"
                            : local.substring(0, 3) == "en_"
                                ? "Write a description for your ad, remember that it must not contain spam or any email addresses"
                                : "Escriba una descripción para su anuncio, recuerde que no debe contener spam ni ninguna dirección de correo electrónico",
                        border: OutlineInputBorder(),
                        isDense: true,
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 0.7)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFB4B4B4), width: 0.7))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TitlePrincipalAds('peopletype_ad'.tr),
                DropDownButtonFormPeopleType(
                  listOptions: controller.getListPeopleType(),
                  actualValue: controller.getListPeopleType()[0],
                  type: EnumTypeList.typePerson,
                ),
                SizedBox(
                  height: 20,
                ),
                TitlePrincipalAds(
                  local.substring(0, 3) == "it_"
                      ? "Comune"
                      : local.substring(0, 3) == "en_"
                          ? "Location"
                          : "Ubicación",
                ),
                DropDownGooglePlaces(),
                SizedBox(
                  height: 20,
                ),
                TitlePrincipalAds(
                  local.substring(0, 3) == "it_"
                      ? "Prezzo"
                      : local.substring(0, 3) == "en_"
                          ? "Price"
                          : "Precio",
                ),
                TextFormField(
                  controller: controller.controllerPrice,
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val!.isEmpty) {
                      _scrollController.animateTo(
                        SizeConfig().screenHeight,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 300),
                      );
                      return 'require_insert'.tr;
                    }
                    if (val.length < 1) {
                      _scrollController.animateTo(
                        SizeConfig().screenHeight,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 300),
                      );
                      return 'Requires at least 1 characters.';
                    }
                    return null;
                  },
                  style: ThemeConfig.bodyText1.override(
                    color: Color(0xFF3C4858),
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: InputDecoration(
                      labelText: 'coin'.tr,
                      labelStyle: ThemeConfig.bodyText1.override(
                        color: Color(0xFFB4B4B4),
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                      border: OutlineInputBorder(),
                      isDense: true,
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.red, width: 0.7)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFFB4B4B4), width: 0.7))),
                ),
                SizedBox(
                  height: 20,
                ),
                if (controller.publishAdModel.value.currentCategory ==
                    EnumCategoryList.furniture)
                  TitlePrincipalAds(
                    local.substring(0, 3) == "it_"
                        ? "Condizione"
                        : local.substring(0, 3) == "en_"
                            ? "Condition"
                            : "Condición",
                  ),
                if (controller.publishAdModel.value.currentCategory ==
                    EnumCategoryList.furniture)
                  DropDownButtonForm(
                    listOptions: [
                      'Selezionare:',
                      'Nuovo (mai usato)',
                      'Come nuovo (poco usato)',
                      'Buono (normale uso)',
                      'Usurato (ma funzionante)',
                      'Danneggiato (da riparare)'
                    ],
                    actualValue: controller.statusProduct,
                    type: EnumTypeList.statusProduct,
                  ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    child: Container(
                      height: 50,
                      width: SizeConfig().screenWidth * .45,
                      child: ButtonNotFilledSecundary(
                          local.substring(0, 3) == "it_"
                              ? "Indietro"
                              : local.substring(0, 3) == "en_"
                                  ? "Go back"
                                  : "Volver"),
                    ),
                    onTap: () {
                      controller.cleanControllers();
                      controller.setCategory(EnumCategoryList.none);
                      controller.getMyPostListAd();
                      Get.back();
                    }),
                InkWell(
                    child: Container(
                      height: 50,
                      width: SizeConfig().screenWidth * .45,
                      child: ButtonSecundary(
                        local.substring(0, 3) == "it_"
                            ? "Aggiornare"
                            : local.substring(0, 3) == "en_"
                                ? "Update"
                                : "Actualizar",
                      ),
                    ),
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        if (controller.peopleType != '' &&
                            controller.peopleType != 'Selezionare:') {
                          if (controller.city != '') {
                            if (controller
                                    .publishAdModel.value.currentCategory ==
                                EnumCategoryList.furniture) {
                              if (controller.statusProduct != '' &&
                                  controller.statusProduct != 'Selezionare:') {
                                controller.updateProduct();
                                controller.setCategory(EnumCategoryList.none);
                                controller.getMyPostListAd();
                              } else {
                                CommonWidget.showError(
                                  local.substring(0, 3) == "it_"
                                      ? "La Condizione deve essere specificata."
                                      : local.substring(0, 3) == "en_"
                                          ? "The condition need to be specified."
                                          : "La condición debe ser especificada.",
                                );
                              }
                            } else {
                              controller.updateProduct();
                              controller.setCategory(EnumCategoryList.none);
                              controller.getMyPostListAd();
                            }
                          } else {
                            _scrollController.animateTo(
                              SizeConfig().screenHeight - 100,
                              curve: Curves.easeOut,
                              duration: const Duration(milliseconds: 300),
                            );
                            CommonWidget.showError(local.substring(0, 3) ==
                                    "it_"
                                ? "La Comune deve essere specificata."
                                : local.substring(0, 3) == "en_"
                                    ? "The location need to be specified."
                                    : "La ubicación debe ser especificada.");
                          }
                        } else {
                          CommonWidget.showError(
                            local.substring(0, 3) == "it_"
                                ? "Compila i campi vuoti"
                                : local.substring(0, 3) == "en_"
                                    ? "Fill in the empty fields"
                                    : "Rellene los campos vacíos",
                          );
                        }
                      }
                    })
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
