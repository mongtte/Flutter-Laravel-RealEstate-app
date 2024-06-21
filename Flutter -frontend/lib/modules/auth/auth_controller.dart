// ignore_for_file: unnecessary_this, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:hero/api/api.dart';
import 'package:hero/lang/lang.dart';
import 'package:hero/models/models.dart';
//import 'package:hero/models/response/users_response.dart';
import 'package:hero/modules/home/home.dart';
import 'package:hero/routes/app_pages.dart';
import 'package:hero/shared/shared.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final ApiRepository apiRepository;
  AuthController({required this.apiRepository});

  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  TextEditingController registerNameController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerAddressController = TextEditingController();
  Rx<DateTime> registerBirthday = DateTime(2000).obs;
  String registerGenderRadioButton = "man";
  bool registerTermsChecked = false;
  RxBool _isChecked = false.obs;
  bool get isChecked => _isChecked.value;
  set isChecked(bool value) => _isChecked.value = value;
  var userStrapi = Rxn<UserStrapi>();
  ValueNotifier userCredential = ValueNotifier('');
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  final locale = TranslationService.locale.toString();

  String get getSelectedDate {
    return "${this.registerBirthday.value.year}-${this.registerBirthday.value.month.toString().padLeft(2, '0')}-${this.registerBirthday.value.day.toString().padLeft(2, '0')}";
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void register(BuildContext context) async {
    AppFocus.unfocus(context);
    final userStrapi = await apiRepository.register(
      RegisterRequest(
          nameLastname: registerNameController.text,
          userName: registerEmailController.text,
          email: registerEmailController.text,
          password: registerPasswordController.text,
          birthday: getSelectedDate,
          address: registerAddressController.text,
          gender: registerGenderRadioButton),
    );

    if (userStrapi == null) {
      Get.toNamed(Routes.LOGIN);
    } else {
      final prefs = Get.find<SharedPreferences>();
      if (userStrapi != null && userStrapi.token!.isNotEmpty) {
        prefs.setString(StorageConstants.token, userStrapi.token!);
        print(prefs.getString(StorageConstants.token));
        var controller = Get.find<HomeController>();
        await controller.loadUser();
        Get.offAndToNamed(Routes.HOME);
        cleanInputs();
      }
    }
  }

  void login(BuildContext context) async {
    AppFocus.unfocus(context);
    this.userStrapi.value = await apiRepository.login(
      LoginRequest(
        identifier: loginEmailController.text,
        password: loginPasswordController.text,
      ),
    );

    if (this.userStrapi != null && this.userStrapi.value!.token!.isNotEmpty) {
      final prefs = Get.find<SharedPreferences>();
      prefs.setString(
          StorageConstants.token, this.userStrapi.value!.token.toString());
      refresh();

      var controller = Get.find<HomeController>();
      await controller.loadUser();
      Get.toNamed(Routes.HOME);
      cleanInputs();
    } else {
      CommonWidget.showError(
        locale.substring(0, 3) == "it_"
            ? "Si prega di inserire correttamente."
            : locale.substring(0, 3) == "en_"
                ? "Please insert correctly."
                : "Por favor inserte correctamente.",
      );
    }
  }

  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      userCredential.value =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final userStrapi = await apiRepository.register(
        RegisterRequest(
            nameLastname: userCredential.value!.user.displayName.toString(),
            userName: userCredential.value!.user.email.toString(),
            email: userCredential.value!.user.email.toString(),
            password: "111111",
            birthday: "2000-01-01",
            address: "USA",
            gender: "Man"),
      );

      if (userStrapi == null) {
        this.userStrapi.value = await apiRepository.login(
          LoginRequest(
            identifier: userCredential.value!.user.email.toString(),
            password: "111111",
          ),
        );

        if (this.userStrapi != null &&
            this.userStrapi.value!.token!.isNotEmpty) {
          final prefs = Get.find<SharedPreferences>();
          prefs.setString(
              StorageConstants.token, this.userStrapi.value!.token.toString());
          refresh();

          var controller = Get.find<HomeController>();
          await controller.loadUser();
          Get.toNamed(Routes.HOME);
          cleanInputs();
        }
      } else {
        final prefs = Get.find<SharedPreferences>();
        if (userStrapi != null && userStrapi.token!.isNotEmpty) {
          prefs.setString(StorageConstants.token, userStrapi.token!);
          var controller = Get.find<HomeController>();
          await controller.loadUser();
          Get.offAndToNamed(Routes.HOME);
          cleanInputs();
        }
      }
    } on Exception catch (e) {
      // TODO
      print('exception->$e');
    }
  }

  @override
  void onClose() {
    super.onClose();

    registerNameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
  }

  void updateSelectedDate(DateTime? selected) {
    if (selected != null && selected != this.registerBirthday) {
      this.registerBirthday.value = selected;
      print(this.registerBirthday.value);
    }
  }

  void cleanInputs() async {
    registerNameController.clear();
    registerEmailController.clear();
    registerPasswordController.clear();
    registerGenderRadioButton = "man";
    registerAddressController.clear();
    registerBirthday.value = DateTime(2000);
    loginEmailController.clear();
    loginPasswordController.clear();
  }
}
