import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/api/api_repository.dart';
import 'package:hero/lang/translation_service.dart';
import 'package:hero/modules/forgot-password/new-password.dart';
import 'package:hero/routes/app_pages.dart';
import 'package:hero/shared/shared.dart';

//import 'package:hero/routes/app_pages.dart';
import 'package:hero/shared/constants/colors.dart';

class ForgotPasswordController extends GetxController {
  final ApiRepository apiRepository;

  ForgotPasswordController({required this.apiRepository});

  var newPasswordController = TextEditingController();
  var newPasswordConfirmationController = TextEditingController();
  var codeController = TextEditingController();
  var emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  forgotPassword() async {
    final res =
        await this.apiRepository.forgotPassword(this.emailController.text);
    if (res == true) {
      Get.to(() => NewPasswordPage());
    } else {
      String local = TranslationService.locale.toString();
      CommonWidget.showError(
        local.substring(0, 3) == "it_"
            ? "La posta non esiste."
            : local.substring(0, 3) == "en_"
                ? "Tha mail doesn't exist."
                : "El correo no existe.",
      );
    }
  }

  resetPassword() async {
    String local = TranslationService.locale.toString();
    final res = await apiRepository.resetPassword(
        this.codeController.text.trim(),
        this.emailController.text.trim(),
        this.newPasswordController.text.trim(),
        this.newPasswordConfirmationController.text.trim());
    print(res);
    if (res == true) {
      this.codeController.text = "";
      this.emailController.text = "";
      this.newPasswordConfirmationController.text = "";
      this.newPasswordController.text = "";
      Get.snackbar(
          local.substring(0, 3) == "it_"
              ? "Password cambiata"
              : local.substring(0, 3) == "en_"
                  ? "Password changed"
                  : "Contraseña cambiada",
          local.substring(0, 3) == "it_"
              ? "La password è stata modificata correttamente."
              : local.substring(0, 3) == "en_"
                  ? "The password has been changed successfully."
                  : "La contraseña se ha modificado correctamente.",
          backgroundColor: ColorConstants.principalColor,
          colorText: Colors.white,
          duration: Duration(seconds: 5), snackbarStatus: (status) {
        if (status == SnackbarStatus.CLOSED) {
          Get.toNamed(Routes.LOGIN);
        }
      });
    } else {
      CommonWidget.showError(
        local.substring(0, 3) == "it_"
            ? "Il codice di verifica non corrisponde."
            : local.substring(0, 3) == "en_"
                ? "Veryfication code doesn't match."
                : "El código de verificación no coincide.",
      );
    }
  }
}
