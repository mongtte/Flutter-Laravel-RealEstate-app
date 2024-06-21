import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/lang/translation_service.dart';
import 'package:hero/modules/home/home_controller.dart';
import 'package:hero/modules/publish_ad/widgets/dropdown_google_places.dart';
import 'package:hero/modules/registry/widgets/button_continue_widget.dart';
import 'package:hero/shared/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hero/shared/utils/regex.dart';
import 'package:hero/theme/theme_data.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final FocusScopeNode _node = FocusScopeNode();
  final ScrollController _scrollController = new ScrollController();
  final homeController = Get.find<HomeController>();

  @override
  void initState() {
    homeController.nameController.text =
        homeController.userStrapi.value!.nameLastname!;
    homeController.emailController.text =
        homeController.userStrapi.value!.email!;
    print(homeController.userStrapi.value!.birthday!);
    homeController.birthDay.value = homeController.userStrapi.value!.birthday!;
    super.initState();
  }

  void _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    if (selected != null) {
      homeController.birthDay.value =
          "${selected.year}-${selected.month.toString().padLeft(2, '0')}-${selected.day.toString().padLeft(2, '0')}";
    }
  }

  @override
  Widget build(BuildContext context) {
    String local = TranslationService.locale.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(
            local.substring(0, 3) == "it_"
                ? "Modifica profilo"
                : local.substring(0, 3) == "en_"
                    ? "Edit account"
                    : "Editar perfíl",
            style: TextStyle(fontSize: 20.sp, color: Colors.white)),
        centerTitle: true,
        backgroundColor: ColorConstants.principalColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 20, color: ColorConstants.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FocusScope(
        node: _node,
        child: Form(
          key: homeController.editProfileFormKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
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
                        controller: homeController.nameController,
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
                                borderSide:
                                    BorderSide(color: Colors.red, width: 0.7)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFB4B4B4), width: 0.7))),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
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
                        controller: homeController.emailController,
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
                            return 'Inserisci un indirizzo email corretta';
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
                                borderSide:
                                    BorderSide(color: Colors.red, width: 0.7)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFB4B4B4), width: 0.7))),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
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
                                  homeController.birthDay.value,
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
                    SizedBox(
                      height: 10.h,
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
                      type: "edit-profile",
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                      child: InkWell(
                        onTap: () {
                          if (homeController.editProfileFormKey.currentState!
                              .validate()) {
                            homeController.editProfile();
                          }
                        },
                        child: ButtonContinueWidget(
                            labelButton: local.substring(0, 3) == "it_"
                                ? "Aggiornare"
                                : local.substring(0, 3) == "en_"
                                    ? "Update"
                                    : "Actualizar"),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
