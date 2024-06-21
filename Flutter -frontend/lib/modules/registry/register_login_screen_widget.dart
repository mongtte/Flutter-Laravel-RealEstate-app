import 'package:get/get.dart';
import 'package:hero/lang/lang.dart';
import 'package:hero/modules/auth/auth_controller.dart';
import 'package:hero/modules/publish_ad/widgets/dropdown_google_places.dart';
import 'package:hero/modules/registry/widgets/button_continue_widget.dart';
import 'package:hero/routes/app_pages.dart';
import 'package:hero/shared/constants/colors.dart';
import 'package:hero/shared/shared.dart';
import 'package:hero/theme/theme.dart';

import 'widgets/custom_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterLoginScreenWidget extends GetView<AuthController> {
  final TextEditingController textController4 = TextEditingController();
  final TextEditingController textController5 = TextEditingController();
  final FocusScopeNode _node = FocusScopeNode();
  final ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    String local = TranslationService.locale.toString();

    return CommonWidget.getScreenSizeFontFixed(
      Scaffold(
        appBar: AppBar(
          title: Text(
            local.substring(0, 3) == "it_"
                ? "Registrazione"
                : local.substring(0, 3) == "en_"
                    ? "Register"
                    : "Registrarse",
            style: TextStyle(color: ColorConstants.white, fontSize: 20.sp),
          ),
          backgroundColor: ColorConstants.principalColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, size: 20, color: ColorConstants.white),
            onPressed: () => Get.toNamed(Routes.HOME),
          ),
          iconTheme: IconThemeData(color: ColorConstants.titlePrincipal),
        ),
        body: FocusScope(
          node: _node,
          child: Form(
            key: controller.registerFormKey,
            child: ListView(
              controller: _scrollController,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'join_horecah1'.tr,
                        textAlign: TextAlign.start,
                        style: ThemeConfig.bodyText1.override(
                          color: Color(0xFF3C4858),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                        child: Text(
                          local.substring(0, 3) == "it_"
                              ? "Nome"
                              : (local.substring(0, 3) == "en_")
                                  ? "Name"
                                  : "Nombre",
                          textAlign: TextAlign.start,
                          style: ThemeConfig.bodyText1.override(
                            color: Color(0xFF3C4858),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: TextFormField(
                          controller: controller.registerNameController,
                          onEditingComplete: _node.nextFocus,
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
                              labelText: local.substring(0, 3) == "it_"
                                  ? "Inserisci tuo nome"
                                  : (local.substring(0, 3) == "en_")
                                      ? "Enter your name"
                                      : "Ingrese su nombre",
                              labelStyle: ThemeConfig.bodyText1.override(
                                color: Color(0xFFB4B4B4),
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              border: OutlineInputBorder(),
                              isDense: true,
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 0.7)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFB4B4B4), width: 0.7))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: Text(
                          local.substring(0, 3) == "it_"
                              ? "Il tuo nome di utente sará visibile nel tuo profilo e nei tuoi annunci."
                              : (local.substring(0, 3) == "en_")
                                  ? "Your username will be visible on your profile and when you post an ad."
                                  : "Tu nombre de usuario será visible en tu perfíl y al realizar un anuncio.",
                          textAlign: TextAlign.start,
                          style: ThemeConfig.bodyText1.override(
                            color: Color(0xFF3C4858),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                        child: Text(
                          'login_label1'.tr,
                          textAlign: TextAlign.start,
                          style: ThemeConfig.bodyText1.override(
                            color: Color(0xFF3C4858),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: TextFormField(
                          controller: controller.registerEmailController,
                          keyboardType: TextInputType.emailAddress,
                          onEditingComplete: _node.nextFocus,
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
                            if (!Regex.isEmail(val)) {
                              _scrollController.animateTo(
                                0.0,
                                curve: Curves.easeOut,
                                duration: const Duration(milliseconds: 300),
                              );
                              return 'email_format'.tr;
                            }
                            return null;
                          },
                          style: ThemeConfig.bodyText1.override(
                            color: Color(0xFF3C4858),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                          decoration: InputDecoration(
                              labelText: 'login_label2'.tr,
                              labelStyle: ThemeConfig.bodyText1.override(
                                color: Color(0xFFB4B4B4),
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              border: OutlineInputBorder(),
                              isDense: true,
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 0.7)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFB4B4B4), width: 0.7))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                        child: Text(
                          'login_label3'.tr,
                          textAlign: TextAlign.start,
                          style: ThemeConfig.bodyText1.override(
                            color: Color(0xFF3C4858),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: TextFormField(
                          obscureText: true,
                          controller: controller.registerPasswordController,
                          onEditingComplete: _node.nextFocus,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'require_insert'.tr;
                            }
                            if (val.length < 5) {
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
                              labelText: 'login_label4'.tr,
                              labelStyle: ThemeConfig.bodyText1.override(
                                color: Color(0xFFB4B4B4),
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              border: OutlineInputBorder(),
                              isDense: true,
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 0.7)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFB4B4B4), width: 0.7))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                        child: Text(
                          local.substring(0, 3) == "it_"
                              ? "Data di nascita"
                              : (local.substring(0, 3) == "en_")
                                  ? "Birthday"
                                  : "Fecha de Nacimiento",
                          textAlign: TextAlign.start,
                          style: ThemeConfig.bodyText1.override(
                            color: Color(0xFF3C4858),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: Color(0xFFB4B4B4),
                                width: 0.7,
                              ),
                            ),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Obx(
                                  () => Text(
                                    controller.getSelectedDate,
                                    textAlign: TextAlign.left,
                                    style: ThemeConfig.bodyText1.override(
                                      color: Color(0xFFB4B4B4),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                )),
                          ),
                          onTap: () => _selectDate(context),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                        child: Text(
                          local.substring(0, 3) == "it_"
                              ? "Sesso"
                              : (local.substring(0, 3) == "en_")
                                  ? "Sex"
                                  : "Sexo",
                          textAlign: TextAlign.start,
                          style: ThemeConfig.bodyText1.override(
                            color: Color(0xFF3C4858),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: RadioButtonForm(
                          options: local.substring(0, 3) == "it_"
                              ? ['Maschio', 'Femmina']
                              : (local.substring(0, 3) == "en_")
                                  ? ['Male', 'Female']
                                  : ['Hombre', 'Mujer'],
                          onChanged: (value) {
                            if (value == 'Maschio' ||
                                value == 'Male' ||
                                value == 'Hombre') {
                              controller.registerGenderRadioButton = 'man';
                            } else {
                              controller.registerGenderRadioButton = 'woman';
                            }
                          },
                          optionHeight: 25,
                          textStyle: ThemeConfig.bodyText1
                              .override(color: Colors.black, fontSize: 13),
                          buttonPosition: RadioButtonPosition.left,
                          direction: Axis.horizontal,
                          radioButtonColor: ColorConstants.principalColor,
                          inactiveRadioButtonColor: Color(0x8A000000),
                          toggleable: false,
                          horizontalAlignment: WrapAlignment.spaceBetween,
                          verticalAlignment: WrapCrossAlignment.start,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                        child: Text(
                          local.substring(0, 3) == "it_"
                              ? "Comune"
                              : (local.substring(0, 3) == "en_")
                                  ? "Location"
                                  : "Ubicación",
                          textAlign: TextAlign.start,
                          style: ThemeConfig.bodyText1.override(
                            color: Color(0xFF3C4858),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      DropDownGooglePlaces(
                        type: "register",
                      ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      /* Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: TextFormField(
                          controller: controller.registerAddressController,
                          onEditingComplete: _node.nextFocus,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Devi catturare questo campo';
                            }
                            if (val.length < 5) {
                              return 'Requires at least 5 characters.';
                            }
                            return null;
                          },
                          style: ThemeConfig.bodyText1.override(
                            color: Color(0xFF3C4858),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                          decoration: InputDecoration(
                              labelText: 'Inserisci un comune',
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
                      ),*/
                      Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  value: controller.isChecked,
                                  onChanged: (bool? newValue) {
                                    controller.isChecked = newValue!;
                                  },
                                ),
                              ),
                              Text(
                                local.substring(0, 3) == "it_"
                                    ? "Accetto Termini e Condizioni."
                                    : local.substring(0, 3) == "en_"
                                        ? "I agree to the terms and conditions."
                                        : "Estoy de acuerdo con los términos y condiciones.",
                                textAlign: TextAlign.start,
                                style: ThemeConfig.bodyText1.override(
                                  color: ColorConstants.principalColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          )),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                        child: InkWell(
                          onTap: () {
                            if (controller.registerFormKey.currentState!
                                    .validate() &&
                                controller.isChecked == true) {
                              controller.register(context);
                            }
                          },
                          child: ButtonContinueWidget(
                              labelButton: 'register_label'.tr),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: controller.registerBirthday.value,
      firstDate: DateTime(1900),
      lastDate: DateTime(DateTime.now().year - 18),
    );
    controller.updateSelectedDate(selected);
  }
}
