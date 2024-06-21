import 'dart:io';

import 'package:hero/api/base_provider.dart';
import 'package:hero/models/models.dart';
import 'package:get/get.dart';
import 'package:hero/shared/constants/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider extends BaseProvider {
  var storage = Get.find<SharedPreferences>();

  Future<Response> login(String path, LoginRequest data) {
    return post(path, data.toJson());
  }

  Future<Response> register(String path, RegisterRequest data) {
    return post(path, data.toJson());
  }

  Future<Response> getUsers(String path) {
    return get(path);
  }

  Future<Response> getWithAuth(String path, String token) {
    //eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjQ4OTYxODE0LCJleHAiOjE2NTE1NTM4MTR9.lAE3cboDsOFgNPh2U9vPhzkKhN91EO91bV2u528aw0I
    return get(path, headers: {"Authorization": "Bearer $token "});
  }

  Future<Response> uploadImage(
      File image, String ref, String field, int id, String time) async {
    String token = storage.getString(StorageConstants.token)!;
    String extension = image.path.split('.').last;
    final form = FormData({
      'files': MultipartFile(image.path,
          filename: '${field}_${id}_.$extension',
          contentType: (extension == 'jpg' || extension == 'png')
              ? 'image/jpeg'
              : 'application/pdf'),
      'field': field,
      'ref': ref,
      'refId': id,
      'time': time
    });
    return post('/upload', form, headers: {"Authorization": "Bearer $token"});
  }
}
