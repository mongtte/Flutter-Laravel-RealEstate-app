//import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/lang/translation_service.dart';
//import 'package:hero/shared/constants/colors.dart';
import 'package:hero/shared/shared.dart';
import 'package:hero/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonWidget {
  static AppBar appBar(
      BuildContext context, String title, IconData? backIcon, Color color,
      {void Function()? callback}) {
    return AppBar(
      leading: backIcon == null
          ? null
          : IconButton(
              icon: Icon(backIcon, color: color),
              onPressed: () {
                if (callback != null) {
                  callback();
                } else {
                  Navigator.pop(context);
                }
              },
            ),
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: color, fontFamily: 'Rubik'),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  static SizedBox rowHeight({double height = 30}) {
    return SizedBox(height: height);
  }

  static SizedBox rowWidth({double width = 30}) {
    return SizedBox(width: width);
  }

  static void showInfo(String body,
      {String title = 'Info', color = Colors.red}) async {
    Get.snackbar(title, body,
        titleText: Text(
          title,
          style: ThemeConfig.title3.override(color: Colors.white),
        ),
        messageText: Text(
          body,
          style: ThemeConfig.subtitle2.override(color: Colors.white),
        ),
        icon: Icon(
          Icons.error_outline_rounded,
          size: 28.0,
          color: Colors.white,
        ),
        duration: Duration(seconds: 5),
        colorText: Colors.blue[400],
        backgroundColor: color);
  }

  showLoading() {
    Get.defaultDialog(
        title: "Cargando...",
        titleStyle: Get.textTheme.subtitle1,
        content: CircularProgressIndicator(),
        barrierDismissible: false);
  }

  static void showError(String body, {String title = 'Error'}) async {
    Get.snackbar(title, body,
        titleText: Text(
          title,
          textScaleFactor: 1,
          style: ThemeConfig.title3.override(color: Colors.white),
        ),
        messageText: Text(
          body,
          textScaleFactor: 1,
          style: ThemeConfig.subtitle2.override(color: Colors.white),
        ),
        icon: Icon(
          Icons.error_outline_rounded,
          size: 28.0,
          color: Colors.white,
        ),
        duration: Duration(seconds: 5),
        colorText: Colors.white,
        backgroundColor: Colors.red);
  }

  static Future<bool> showModalInfo(String body,
      {String title = 'Info', bool hasCancel = false}) async {
    String local = TranslationService.locale.toString();
    bool onOK = await Get.dialog(
      AlertDialog(
        title: Text(title, textScaleFactor: 1, style: ThemeConfig.title3),
        content: Text(body, textScaleFactor: 1, style: ThemeConfig.subtitle2),
        actions: <Widget>[
          !hasCancel
              ? TextButton(
                  child: ButtonSecundary(
                    local.substring(0, 3) == "it_"
                        ? "Confermare"
                        : local.substring(0, 3) == "en_"
                            ? "Confirm"
                            : "Confirmar",
                  ),
                  onPressed: () => Get.back(result: true))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: TextButton(
                          child: Container(
                            height: 48,
                            child: ButtonNotFilledSecundary(
                              local.substring(0, 3) == "it_"
                                  ? "Anulla"
                                  : local.substring(0, 3) == "en_"
                                      ? "Cancel"
                                      : "Cancelar",
                            ),
                          ),
                          onPressed: () => Get.back(result: false)),
                    ),
                    Expanded(
                      child: TextButton(
                          child: Container(
                              height: 50,
                              child: ButtonSecundary(
                                local.substring(0, 3) == "it_"
                                    ? "Confermare"
                                    : local.substring(0, 3) == "en_"
                                        ? "Confirm"
                                        : "Confirmar",
                              )),
                          onPressed: () => Get.back(result: true)),
                    )
                  ],
                )
        ],
      ),
      barrierDismissible: true,
    );
    return onOK;
  }

  static Future<bool> showModalAlert(String body, BuildContext context) async {
    String local = TranslationService.locale.toString();
    bool onOK = await Get.dialog(
      AlertDialog(
        content: Text(body, textScaleFactor: 1, style: TextStyle(fontSize: 22)),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: TextButton(
                    child: Container(
                      height: 40,
                      child: ButtonNotFilledSecundary(
                        local.substring(0, 3) == "it_"
                            ? "Anulla"
                            : local.substring(0, 3) == "en_"
                                ? "Cancel"
                                : "Cancelar",
                      ),
                    ),
                    onPressed: () => Get.back(result: false)),
              ),
              Expanded(
                child: TextButton(
                    child: Container(
                        height: 40,
                        child: ButtonSecundary(
                          local.substring(0, 3) == "it_"
                              ? "Confermare"
                              : local.substring(0, 3) == "en_"
                                  ? "Confirm"
                                  : "Confirmar",
                        )),
                    onPressed: () => Get.back(result: true)),
              )
            ],
          )
        ],
      ),
      barrierDismissible: true,
    );
    return onOK;
  }

  static getScreenSizeFontFixed(Widget screen) {
    return MediaQuery(
        data: MediaQuery.of(Get.context!).copyWith(textScaleFactor: 1),
        child: screen);
  }

  static Future<void> showModalImage(String urlImage) async {
    Get.dialog(AlertDialog(
      title: Text('Imagini', textScaleFactor: 1, style: ThemeConfig.title3),
      insetPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      content: Container(
        height: SizeConfig().screenHeight / 2,
        width: 80,
        child: CachedNetworkImage(imageUrl: urlImage, fit: BoxFit.cover),
      ),
    ));
  }

  static Future<void> showModalListImages(Widget child) async {
    Get.dialog(AlertDialog(
      backgroundColor: Colors.black.withOpacity(0.9),
      insetPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      content: Container(
        height: SizeConfig().screenHeight / 1.5,
        // width:  SizeConfig().screenWidth,
        child: child,
      ),
    ));
  }

  static previewFilew(String urlImage) async {
    await canLaunch(urlImage)
        ? await launch(urlImage)
        : throw 'Could not launch $urlImage';
  }
}
