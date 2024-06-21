import 'package:flutter/material.dart';
class ColorConstants {
  static Color lightScaffoldBackgroundColor = hexToColor('#f7f8fc');
  static Color darkScaffoldBackgroundColor = hexToColor('#2F2E2E');
  static Color secondaryAppColor = Colors.blueAccent;
  static Color secondaryDarkAppColor = Colors.white;
  static Color tipColor = hexToColor('#B6B6B6');
  static Color lightGray = hexToColor('#dfe3ee');
  static Color darkGray = hexToColor('#aeb9c6');
  static Color titlePrincipal = hexToColor('#3c4858');
  static Color titleSecundary = hexToColor('#717f90');
  static Color black = Color(0xFF000000);
  static Color white = Color(0xFFFFFFFF);
  static Color principalColor = hexToColor('#2a3cc5');
  static Color actionOrangeColor = Colors.deepOrange;
  static Color furnitureColor = hexToColor('#99c946');
  static Color activityColor = hexToColor('#f5771f');
  static Color franchiseColor = hexToColor('#7e57c2');
  static Color supplierColor = hexToColor('#d31d2a');
  static Color consultantColor = hexToColor('#0499d9');
  static Color entrepreneurColor = hexToColor("#ff8a80");
}

hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}
