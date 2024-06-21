import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/lang/translation_service.dart';
import 'package:hero/modules/forgot-password/forgot-password-controller.dart';
import 'package:hero/routes/app_pages.dart';
//import 'package:hero/modules/forgot-password/new-password.dart';
import 'package:hero/shared/constants/colors.dart';
import 'package:hero/shared/widgets/custom_widgets.dart';
import 'package:hero/theme/theme_data.dart';
//import 'package:otp_text_field/otp_field.dart';
//import 'package:otp_text_field/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);

  final forgotPassCtrl = Get.find<ForgotPasswordController>();

  @override
  Widget build(BuildContext context) {
    String local = TranslationService.locale.toString();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            local.substring(0, 3) == "it_"
                ? "Resetta la password"
                : local.substring(0, 3) == "en_"
                    ? "Reset password"
                    : "Resetear contraseña",
            style: TextStyle(color: ColorConstants.white, fontSize: 20.sp),
          ),
          centerTitle: true,
          backgroundColor: ColorConstants.principalColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, size: 20, color: ColorConstants.white),
            onPressed: () => Get.toNamed(Routes.LOGIN),
          ),
          iconTheme: IconThemeData(color: ColorConstants.titlePrincipal),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              TitlePrincipalAds(
                  local.substring(0, 3) == "it_"
                      ? "Hai dimenticato la tua password?"
                      : local.substring(0, 3) == "en_"
                          ? "Forgot your password?"
                          : "¿Haz olvidado tu contraseña?",
                  color: Colors.black),
              SizedBox(
                height: 15,
              ),
              TitlePrincipalAds(
                local.substring(0, 3) == "it_"
                    ? "Inserisci la tua email, premi conferma e riceverai un codice di verifica nella tua email."
                    : local.substring(0, 3) == "en_"
                        ? "Enter your email, press confirm and you will receive a verification code in your email."
                        : "Ingrese su correo electrónico, presione confirmar y recibirá un codigo de verificación en su correo.",
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: forgotPassCtrl.emailController,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: "login_label2".tr,
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
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'require_insert'.tr;
                  }
                  if (val.length < 5) {
                    return 'require_least'.tr;
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: Get.width,
                height: 50,
                child: TextButton(
                    onPressed: () {
                      forgotPassCtrl.forgotPassword();
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: ColorConstants.principalColor),
                    child: Text(
                      local.substring(0, 3) == "it_"
                          ? "Confermare"
                          : local.substring(0, 3) == "en_"
                              ? "Confirm"
                              : "Confirmar",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    )),
              ),
              SizedBox(
                height: 25,
              ),
              Divider(),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
