//import 'dart:math';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
//import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:hero/lang/translation_service.dart';
import 'package:hero/modules/publish_ad/publish_ad_controller.dart';
import 'package:hero/modules/publish_ad/widgets/dropdown_button_form.dart';
import 'package:hero/modules/publish_ad/widgets/dropdown_google_places.dart';
import 'package:hero/modules/publish_ad/widgets/publish_ad_app_bar.dart';
import 'package:hero/routes/routes.dart';
import 'package:hero/shared/shared.dart';
import 'package:hero/theme/theme_data.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PublishAdStepTwoScreen extends StatefulWidget {
  @override
  _PublishAdStepTwoScreenState createState() => _PublishAdStepTwoScreenState();
}

class _PublishAdStepTwoScreenState extends State<PublishAdStepTwoScreen> {
  var controller = Get.find<PublishAdController>();
  final ScrollController _scrollController = new ScrollController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool hidePhoneNumber = false;
  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');
  final FocusScopeNode _node = FocusScopeNode();

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();

    print("subCatStr ${controller.currentSubCatStr}");
  }

  Widget build(BuildContext context) {
    String local = TranslationService.locale.toString();
    return PublishAdAppBar(
        body: FocusScope(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 0),
            child: Form(
              key: formKey,
              child: ListView(
                controller: _scrollController,
                children: [
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
                        } else
                          return null;
                      },
                      style: ThemeConfig.bodyText1.override(
                        color: Color(0xFF3C4858),
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                      decoration: InputDecoration(
                          labelText: local.substring(0, 3) == "it_"
                              ? "Scrivi un titolo per il tuo annuncio."
                              : local.substring(0, 3) == "en_"
                                  ? "Write a title for your ad."
                                  : "Escriba un título para el anuncio.",
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
                      child: Scrollbar(
                          thickness: 7,
                          thumbVisibility: true,
                          child: SingleChildScrollView(
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
                              maxLines: 3,
                              minLines: 3,
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
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  labelText: local.substring(0, 3) == "it_"
                                      ? "Scrivi una descrizione \ndel tuo annuncio, ricorda che non \ndeve contenere spam o nessun \nindirizzo email"
                                      : local.substring(0, 3) == "en_"
                                          ? "Write a description for your ad, remember that it must not contain spam or any email addresses"
                                          : "Escriba una descripción para su anuncio, recuerde que no debe contener spam ni ninguna dirección de correo electrónico",
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 0.7)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFB4B4B4),
                                          width: 0.7))),
                            ),
                          ))),
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
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
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
                  TitlePrincipalAds(
                    local.substring(0, 3) == "it_"
                        ? "Telefono"
                        : local.substring(0, 3) == "en_"
                            ? "Phone number"
                            : "Número telefónico",
                  ),
                  InternationalPhoneNumberInput(
                    textStyle: TextStyle(color: Colors.black),
                    onInputChanged: (PhoneNumber number) {
                      controller.controllerPhone.text =
                          number.phoneNumber.toString();
                    },
                    initialValue: PhoneNumber(
                      isoCode: Platform.localeName.split('_').last,
                    ),
                    selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    ),
                    ignoreBlank: false,
                    autoValidateMode: AutovalidateMode.disabled,
                    selectorTextStyle: TextStyle(color: Colors.black),
                    formatInput: true,
                    keyboardType: TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    inputBorder: OutlineInputBorder(),
                    onSaved: (PhoneNumber number) {
                      controller.controllerPhone.text =
                          number.phoneNumber.toString();
                    },
                  ),
                  SizedBox(
                    height: 20,
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
                  if (controller.publishAdModel.value.currentCategory ==
                      EnumCategoryList.furniture)
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
                    DropDownButtonFormCondizione(
                      listOptions: controller.getListCondition(),
                      actualValue: controller.getListCondition()[0],
                      type: EnumTypeList.statusProduct,
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
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
                                        : "Volver",
                              ),
                            ),
                            onTap: () {
                              controller.backStep(
                                  Routes.HOME + Routes.CREATE_AD_STEP_ONE);
                            }),
                        InkWell(
                            child: Container(
                              height: 50,
                              width: SizeConfig().screenWidth * .45,
                              child: ButtonSecundary(
                                local.substring(0, 3) == "it_"
                                    ? "Avanti"
                                    : local.substring(0, 3) == "en_"
                                        ? "Continue"
                                        : "Continuar",
                              ),
                            ),
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                if (controller.controllerCity.text != '' &&
                                    controller.currenPeopleTypeStr !=
                                        'Select:'.tr) {
                                  if (controller.publishAdModel.value
                                          .currentCategory ==
                                      EnumCategoryList.furniture) {
                                    if (controller.statusProduct != '' &&
                                        controller.statusProduct !=
                                            'Select:'.tr) {
                                      controller.nexStep(Routes.HOME +
                                          Routes.CREATE_AD_STEP_THREE);
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
                                    controller.nexStep(Routes.HOME +
                                        Routes.CREATE_AD_STEP_THREE);
                                  }
                                } else {
                                  _scrollController.animateTo(
                                    SizeConfig().screenHeight - 100,
                                    curve: Curves.easeOut,
                                    duration: const Duration(milliseconds: 300),
                                  );
                                  CommonWidget.showError(local.substring(
                                              0, 3) ==
                                          "it_"
                                      ? "La Comune deve essere specificata."
                                      : local.substring(0, 3) == "en_"
                                          ? "The location need to be specified."
                                          : "La ubicación debe ser especificada.");
                                }
                              }
                            })
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
