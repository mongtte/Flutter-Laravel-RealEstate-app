import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hero/models/models.dart';
import 'package:hero/shared/shared.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

FutureOr<dynamic> responseInterceptor(
    Request request, Response response) async {
  EasyLoading.dismiss();

  if (response.statusCode != 200) {
    handleErrorStatus(response);
  }

  return response;
}

void handleErrorStatus(Response response) {
  switch (response.statusCode) {
    case 400:
      final message = ErrorResponse.fromJson(response.body);
      CommonWidget.showError(message.error);
      break;
    default:
      //CommonWidget.showError(response.statusText.toString());
  }

  return;
}
