import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/lang/es_ES.dart';
import 'package:hero/lang/es_US.dart';

import 'en_US.dart';
import 'it_IT.dart';

class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static final fallbackLocale = Locale('en', 'US');
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
        'it_IT': it_IT,
        'es_ES': es_ES,
        'es_US': es_US,
      };
}
