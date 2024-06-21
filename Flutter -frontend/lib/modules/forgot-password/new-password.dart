import 'package:get/get.dart';
import 'package:hero/lang/translation_service.dart';
//import 'package:hero/modules/auth/auth_controller.dart';
import 'package:hero/modules/forgot-password/forgot-password-controller.dart';
// import 'package:hero/modules/forgot-password/forgot-password.dart';
// import 'package:hero/modules/registry/widgets/button_continue_widget.dart';
// import 'package:hero/routes/routes.dart';
import 'package:hero/shared/constants/colors.dart';
import 'package:hero/shared/widgets/custom_widgets.dart';
import 'package:hero/theme/theme.dart';
import 'package:flutter/material.dart';

class NewPasswordPage extends StatefulWidget {
  NewPasswordPage();

  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  bool passwordVisibility = false;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  //var controller = Get.find<AuthController>();
  String local = TranslationService.locale.toString();
  final forgotPassCtrl = Get.find<ForgotPasswordController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          local.substring(0, 3) == "it_"
              ? "Nuova Password"
              : local.substring(0, 3) == "en_"
                  ? "New Password"
                  : "Nueva Contraseña",
          style: TextStyle(color: ColorConstants.white),
        ),
        backgroundColor: ColorConstants.principalColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 20, color: ColorConstants.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: IconThemeData(color: ColorConstants.titlePrincipal),
      ),
      body: ListView(children: [
        IngresarCodigo(),
        SizedBox(
          height: 20.0,
        ),
        Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  local.substring(0, 3) == "it_"
                      ? "'Inserire una nuova password'"
                      : local.substring(0, 3) == "en_"
                          ? 'Enter a new password'
                          : 'Ingresa una nueva contraseña',
                  textAlign: TextAlign.center,
                  style: ThemeConfig.bodyText1.override(
                    color: Color(0xFF3C4858),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                  child: Text(
                    local.substring(0, 3) == "it_"
                        ? "Nuova Password"
                        : local.substring(0, 3) == "en_"
                            ? "New Password"
                            : "Nueva Contraseña",
                    textAlign: TextAlign.start,
                    style: ThemeConfig.bodyText1.override(
                      color: Color(0xFF3C4858),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: forgotPassCtrl.newPasswordController,
                  obscureText: !passwordVisibility,
                  decoration: InputDecoration(
                    hintText: local.substring(0, 3) == "it_"
                        ? "Inserire una nuova password"
                        : local.substring(0, 3) == "en_"
                            ? "Enter new password"
                            : 'Ingresa contraseña nueva',
                    hintStyle: ThemeConfig.bodyText1.override(
                      color: Color(0xFF3C4858),
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF3C4858),
                        width: 0.5,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF3C4858),
                        width: 0.5,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    suffixIcon: InkWell(
                      onTap: () => setState(
                        () => passwordVisibility = !passwordVisibility,
                      ),
                      child: Icon(
                        passwordVisibility
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Color(0xFF757575),
                        size: 22,
                      ),
                    ),
                  ),
                  style: ThemeConfig.bodyText1.override(
                    color: Color(0xFF3C4858),
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return local.substring(0, 3) == "it_"
                          ? "Devi catturare questo campo"
                          : local.substring(0, 3) == "en_"
                              ? "You must capture this field"
                              : 'Debes capturar este campo';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 8.0),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                  child: Text(
                    local.substring(0, 3) == "it_"
                        ? "Conferma la nuova password"
                        : local.substring(0, 3) == "en_"
                            ? "Confirm New Password"
                            : 'Confirmar Nueva Contraseña',
                    textAlign: TextAlign.start,
                    style: ThemeConfig.bodyText1.override(
                      color: Color(0xFF3C4858),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: forgotPassCtrl.newPasswordConfirmationController,
                  obscureText: !passwordVisibility,
                  decoration: InputDecoration(
                    hintText: local.substring(0, 3) == "it_"
                        ? "Conferma la nuova password"
                        : local.substring(0, 3) == "en_"
                            ? "Confirm New Password"
                            : 'Confirma contraseña nueva',
                    hintStyle: ThemeConfig.bodyText1.override(
                      color: Color(0xFF3C4858),
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF3C4858),
                        width: 0.5,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF3C4858),
                        width: 0.5,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    suffixIcon: InkWell(
                      onTap: () => setState(
                        () => passwordVisibility = !passwordVisibility,
                      ),
                      child: Icon(
                        passwordVisibility
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Color(0xFF757575),
                        size: 22,
                      ),
                    ),
                  ),
                  style: ThemeConfig.bodyText1.override(
                    color: Color(0xFF3C4858),
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return local.substring(0, 3) == "it_"
                          ? "Devi catturare questo campo"
                          : local.substring(0, 3) == "en_"
                              ? "You must capture this field"
                              : 'Debes capturar este campo';
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: Get.width,
                  height: 50,
                  child: TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          forgotPassCtrl.resetPassword();
                        }
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: ColorConstants.principalColor),
                      child: Text(
                        local.substring(0, 3) == "it_"
                            ? "Cambiare la password"
                            : local.substring(0, 3) == "en_"
                                ? "Change Password"
                                : "Cambiar contraseña",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      )),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class IngresarCodigo extends StatelessWidget {
  IngresarCodigo({
    Key? key,
  }) : super(key: key);

  final forgotPassCtrl = Get.find<ForgotPasswordController>();

  @override
  Widget build(BuildContext context) {
    String local = TranslationService.locale.toString();
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
      child: Column(
        children: [
          TitlePrincipalAds(
              local.substring(0, 3) == "it_"
                  ? "Inserisci il codice di verifica"
                  : local.substring(0, 3) == "en_"
                      ? "Enter the verification code"
                      : 'Ingresa el código de verificación',
              color: Colors.black),
          SizedBox(
            height: 10,
          ),
          TitlePrincipalAds(
            local.substring(0, 3) == "it_"
                ? "Abbiamo inviato un codice di verifica alla tua email, incollalo qui sotto"
                : local.substring(0, 3) == "en_"
                    ? "We have sent a verification code to your email, paste it below"
                    : 'Hemos enviado un código de verificación a tu correo electrónico, pégalo a continuación',
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: forgotPassCtrl.codeController,
            decoration: InputDecoration(
              hintText: local.substring(0, 3) == "it_"
                  ? "Inserisci il codice di verifica"
                  : local.substring(0, 3) == "en_"
                      ? "Enter verification code"
                      : 'Ingrese código de verificación',
              hintStyle: ThemeConfig.bodyText1.override(
                color: Color(0xFF3C4858),
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF3C4858),
                  width: 0.5,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF3C4858),
                  width: 0.5,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
            ),
            style: ThemeConfig.bodyText1.override(
              color: Color(0xFF3C4858),
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
            validator: (val) {
              if (val!.isEmpty) {
                return local.substring(0, 3) == "it_"
                    ? "Devi catturare questo campo"
                    : local.substring(0, 3) == "en_"
                        ? "You must capture this field"
                        : 'Debes capturar este campo';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}
