// ignore_for_file: body_might_complete_normally_nullable, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:hero/models/chats/chats.dart';
import 'package:hero/models/chats/rooms_chats.dart';
import 'package:hero/models/models.dart';
import 'package:hero/models/multimedia.dart';
import 'package:hero/models/prices/prices.dart';
import 'package:hero/models/products/products.dart';
import 'package:hero/models/response/users_response.dart';
import 'package:hero/models/subcategory.dart';
import 'package:hero/shared/constants/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';

class ApiRepository {
  ApiRepository({required this.apiProvider});
  var storage = Get.find<SharedPreferences>();
  final ApiProvider apiProvider;

  Future<UserStrapi?> login(LoginRequest data) async {
    final res = await apiProvider.login('/auth/local', data);
    print(res.body);
    if (res.statusCode == 200) {
      return UserStrapi.fromJson2(res.body);
    }
  }

  Future<UserStrapi?> register(RegisterRequest data) async {
    print(data.toJson());
    final res = await apiProvider.register('/auth/local/register', data);
    if (res.body["message"] != null) {
      return null;
    } else if (res.statusCode == 200 && res.body["message"] == null) {
      //print(res.body["data"]["attributes"]);
      return UserStrapi.fromJson2(res.body);
    }
  }

  Future<UsersResponse?> getUsers() async {
    final res = await apiProvider.getUsers('/api/users?page=1&per_page=12');
    if (res.statusCode == 200) {
      return UsersResponse.fromJson(res.body);
    }
  }

  Future<UserStrapi?> getUser(String token) async {
    final res = await apiProvider.getWithAuth('/users/me', token);
    print("status Code!!!!!! ${res.statusCode}");
    print("100101010101111111: ${res.body}");
    if (res.statusCode == 200) {
      print(res.body);
      return UserStrapi.fromJsonUpdated(res.body);
    }
  }

  Future<UserStrapi?> getUserById(int id) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider.getWithAuth('/users/$id', token);
    if (res.statusCode == 200) {
      return UserStrapi.fromJsonUpdated(res.body);
    }
  }

  Future publishAd(Products products) async {
    print(products.toJson());
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider.post('/products', products.toJson(),
        headers: {"Authorization": "Bearer $token"});
    print("what are they: ${res.body}");
    if (res.statusCode == 200) {
      print(res.body[0]["id"]);
      return res.body[0]["id"];
    }
  }

  Future<Products?> updateProducthAd(Products products, int id) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider.put('/products/$id', products.toJson(),
        headers: {"Authorization": "Bearer $token"});

    print("status code!! ${res.statusCode}");
    if (res.statusCode == 200) {
      print("UPDATE SUCCESFULL!!!");

      return Products.fromJson(res.body);
    }
  }

  Future<UserStrapi?> updateUserProfile(
      Map<String, dynamic> newUser, int id) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider.put('/users?id=$id', jsonEncode(newUser),
        headers: {"Authorization": "Bearer $token"});
    print("=====================================${res.body}");
    print("status code!! ${res.statusCode}");
    if (res.statusCode == 200) {
      print("UPDATE PROFILE SUCCESFULL!!!");
      print("USER UPDATED!!!!!  ");
      print(res.body);
      return UserStrapi.fromJson2(res.body);
    }
  }

  Future changeProductStatus(Products products, int id) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider.put('/products/$id', products.toJson(),
        headers: {"Authorization": "Bearer $token"});

    print("status code!! ${res.statusCode}");
    if (res.statusCode == 200) {
      return res.body["id"];
    }
  }

  Future updateProduct(Products products, int id) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider.put('/products?id=$id', products.toJson(),
        headers: {"Authorization": "Bearer $token"});

    print("status code!! ${products.toJson()}");
    print("what is wrong : ${res.body}");
    if (res.statusCode == 200) {
      print(res.body);
      print("UPDATE SUCCESFULL!!!");
      return id;
    }
  }

  Future<Products> getProduct(int id) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider
        .get('/products?id=$id', headers: {"Authorization": "Bearer $token"});

    print(res.body);
    final prod = Products.fromJsonForUpdate(res.body);
    return prod;
  }

  Future<Multimedia?> uploadImage(
      File image, String ref, String field, int id, String time) async {
    print("----------------------------------------${image}");
    final res = await apiProvider.uploadImage(image, ref, field, id, time);
    if (res.statusCode == 200) {
      print(res.body[0]);
      return Multimedia.fromJson(res.body[0][0]);
    }
  }

  Future<List<Products>?> getPosts({String? category, String? filter}) async {
    print("CATEGORY!!!! $category");
    print("Filter: ${filter}");
    String path = category == ""
        ? '/products?status=published'
        : '/products?status=published&category=$category&ad_type=$filter';
    final res = await apiProvider.get(path);
    print(res.body);
    // print("0000000000000000000000status Code!!!!!! ${res.body[1].toString()}");
    if (res.statusCode == 200 && res.body != {"message": "No products found"}) {
      return Products.fromListJson(res.body);
    } else
      return [];
  }

  Future<String> getConfirm(int id) async {
    String path = '/confirm-product?id=$id';
    final res = await apiProvider.get(path);
    print(res.body);
    // print("0000000000000000000000status Code!!!!!! ${res.body[1].toString()}");
    if (res.statusCode == 200) {
      return res.body;
    }
    return "Nothing";
  }

  Future<List<dynamic>> getPrice() async {
    String path = '/price';
    final res = await apiProvider.get(path);
    print(res.body);
    // print("0000000000000000000000status Code!!!!!! ${res.body[1].toString()}");
    if (res.statusCode == 200) {
      return res.body;
    }
    return [];
  }

  Future<String> getConfirmPayment(int id, String period) async {
    String path = '/confirmed-price';
    final res = await apiProvider.post(path, {"id": id, "period": period});
    print(res.body);
    // print("0000000000000000000000status Code!!!!!! ${res.body[1].toString()}");
    if (res.statusCode == 200) {
      return res.body["servicekind"];
    }
    return "Nothing";
  }

  Future<List<Products>?> getRecentlyProducts(int id) async {
    String token = storage.getString(StorageConstants.token)!;

    final res = await apiProvider.get("/recently-seens?user=$id",
        headers: {"Authorization": "Bearer $token"});
    if (res.statusCode == 200) {
      var response = res.body;
      //if (response.runtimeType == String) response = jsonDecode(res.body);
      return Products.fromListJson(response);
    } else {
      return <Products>[];
    }
  }

  addToRecentlyProducts(int userId, int productId) async {
    String? token = storage.getString(StorageConstants.token);

    if (token == null) return false;

    final res = await apiProvider.post(
        "/recently-seens", {"id": productId, "user": userId},
        headers: {"Authorization": "Bearer $token"});
    if (res.statusCode == 200) {
      print("============ADDED TO FAVORITES!!!!!");
      return true;

      //return Products.fromListJson(res.body[0]["products"]);
    } else {
      print("=======NOT ADDED TO FAVORITE====");
      return false;
    }
  }

  Future<List<Category>> getAllCategories() async {
    String path = "/categories";
    final res = await apiProvider.get(path + '?_sort=created_at:ASC');
    print("=============CATEGORIES   ${res.body}");
    return Category.fromListJson(res.body);
  }

  Future<List<SubCategory>> getSubCategoriesByCategory(String category) async {
    print(category);
    String path = "/sub-categories?category_name_es=$category";
    final res = await apiProvider.get(path + '&_sort=created_at:DESC');
    //print("SUBCATS: ${res.body}");
    print(res.body);
    return SubCategory.fromListJson(res.body);
  }

  Future<List<SubCategory>> getSubCategoriesForPost(
      String nameSubCat, String lang) async {
    String field = lang.substring(0, 3) == "en_"
        ? "name_en"
        : lang.substring(0, 3) == "it_"
            ? "name_it"
            : "name_es";
    String path = "/sub-categories?$field=$nameSubCat";
    //print("Path!!!! $path");
    final res = await apiProvider.get(path + '&_sort=created_at:DESC');
    //print("SUBCATS: ${res.body}");
    return SubCategory.fromListJson(res.body);
  }

  Future<List<Products>?> getAllPosts({String? category}) async {
    String token = storage.getString(StorageConstants.token)!;
    String path = category == ''
        ? '/products?_sort=created_at:DESC'
        : '/products?category=$category&_sort=created_at:DESC';

    final res = await apiProvider
        .get(path, headers: {"Authorization": "Bearer $token"});
    if (res.statusCode == 200) {
      print("======ALL PRODUCTS =======");
      print(res.statusCode);
      return Products.fromListJson(res.body);
    }
  }

  Future<List<Products>?> getAllPostsDraftPublished() async {
    String token = storage.getString(StorageConstants.token)!;
    String path = '/products?_sort=created_at:DESC&_publicationState=preview';

    final res = await apiProvider.get(
      path,
    );

    print("==========RES DRAFT & PUBLISHED PRODUCTS ============");
    print(res.statusCode);

    if (res.statusCode == 200) {
      print(res.body);
      return Products.fromListJson(res.body);
    }
  }

  Future<Products?> getPostsById(int id) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider
        .get('/products?id=$id', headers: {"Authorization": "Bearer $token"});
    if (res.statusCode == 200) {
      print(res.body);
      return Products.fromJson(res.body[0]);
    }
  }

  Future<Likes?> addProductLike(Likes like) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider.post('/likes', like.toJson(),
        headers: {"Authorization": "Bearer $token"});
    if (res.statusCode == 200) {
      print("=======${res.body}");
      return Likes.fromJson(res.body);
    }
  }

  Future<int?> removeProductLike(int id) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider
        .delete('/likes?id=$id', headers: {"Authorization": "Bearer $token"});
    if (res.statusCode == 200) {
      print(res.body);
      return res.body;
    }
  }

  Future<List<Products>?> getProductsLiked(int id) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider
        .get('/likes?user=$id', headers: {"Authorization": "Bearer $token"});
    if (res.statusCode == 200) {
      print("====================${res.body}");
      List<Products> posts = [];
      //print(res.body);
      for (var likeItem in res.body) {
        // likeItem['user'] = null;
        // print("Lieks in product: ${likeItem['likes']}");
        // likeItem['likes'] = [
        //   {
        //     'id': likeItem['id'],
        //     'product': likeItem['product'],
        //     'user': likeItem['user'],
        //     'created_at': likeItem['created_at'],
        //     'updated_at': likeItem['updated_at'],
        //   }
        // ];
        posts.add(Products.fromJson(likeItem));
      }
      // for (int i = 0; i < res.body.length; i++){
      //   res.body[i]['product']['user'] = getUserById(res.body[i]['product']['user']);
      // }
      // return Likes.fromListJsonGetProducts(res.body);

      return posts;
    }
  }

  Future<List<RoomsChats>?> getRooms(int id) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider.get(
        '/room-chats?_sort=created_at:DESC&user=$id',
        headers: {"Authorization": "Bearer $token"});
    print(res.body);
    //print(res.body);
    if (res.statusCode == 200) {
      //print("rooms:  ${res.body}");

      return RoomsChats.fromListJson(res.body);
    }
  }

  Future<List<Chats>?> getChat(int id) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider
        .get('/chats?roomId=$id', headers: {"Authorization": "Bearer $token"});
    if (res.statusCode == 200) {
      return Chats.fromListJson(res.body);
    }
  }

  Future<Chats?> sendMessage(Chats message) async {
    String token = storage.getString(StorageConstants.token)!;
    print(message.toJson());
    final res = await apiProvider.post('/chats', message.toJson(),
        headers: {"Authorization": "Bearer $token"});
    print("==========================${res.body}");
    if (res.statusCode == 200) {
      return Chats.fromJson(res.body);
    }
  }

  Future<RoomsChats?> createRoom(RoomsChats roomsChats) async {
    String token = storage.getString(StorageConstants.token)!;
    print(roomsChats.toJson());
    final res = await apiProvider.post('/room-chats', roomsChats.toJson(),
        headers: {"Authorization": "Bearer $token"});
    if (res.statusCode == 200) {
      print("======================");
      //res.body['product']['user'] = null;
      return RoomsChats.fromJson(res.body);
    } else {
      print(res.body);
    }
  }

  Future<List<Products>?> getPostsByFilter(String filter) async {
    print("FILTER!!! /filter?status=published$filter");
    final res = await apiProvider.get('/filter?status=published$filter');
    if (res.statusCode == 200) {
      print("22222-22222-------------------${res.body}");
      return Products.fromListJson(res.body);
    } else {
      print(res.statusCode);
    }
  }

  Future<List<Products>?> getPostsByFilterSearch(String filter) async {
    print("FILTER!!! /search_filter?status=published$filter");
    final res = await apiProvider.get('/search_filter?status=published$filter');
    if (res.statusCode == 200) {
      print("33322-22222-------------------${res.body}");
      return Products.fromListJson(res.body);
    } else {
      print(res.statusCode);
    }
  }

  Future<Multimedia?> removeImage(int id) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider
        .delete('/upload?id=$id', headers: {"Authorization": "Bearer $token"});
    print('delete Image:${res.body}');
    if (res.statusCode == 200) {
      return Multimedia.fromJson(res.body);
    }
  }

  Future<Products?> removeProduct(int id) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider.delete('/products?id=$id',
        headers: {"Authorization": "Bearer $token"});
    if (res.statusCode == 200) {
      //return Products.fromJson(res.body);
    }
  }

  Future<Prices> getPrices() async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider
        .get("/prices", headers: {"Authorization": "Bearer $token"});
    return Prices.fromJson(res.body[0]);
  }

  Future<bool> postAgency(
      String name,
      String vatNumber,
      String taxId,
      String address,
      String common,
      String province,
      String postal,
      String pec,
      String telephone,
      String fax,
      String referent) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider.post("/agency", {
      "business_name:": name,
      "vat_number": vatNumber,
      "tax_id": taxId,
      "address": address,
      "common": common,
      "province": province,
      "postal": postal,
      "pec": pec,
      "telephone": telephone,
      "fax": fax,
      "referent": referent
    }, headers: {
      "Authorization": "Bearer $token"
    });
    return res.body;
  }

  Future<String> getUrlCheckout(int option, int productId) async {
    String token = storage.getString(StorageConstants.token)!;
    final res = await apiProvider.post(
        "/purchases/payment", {"product": productId, "option": option},
        headers: {"Authorization": "Bearer $token"});
    return res.body['url'];
  }

  Future<bool> confirmCheckout(String endpoint) async {
    String token = storage.getString(StorageConstants.token)!;
    final response = await apiProvider
        .get(endpoint, headers: {"Authorization": "Bearer $token"});

    if (response.hasError) return false;

    return true;
  }

  Future<bool> forgotPassword(String userEmail) async {
    final map = {"email": userEmail};
    final res =
        await apiProvider.post("/auth/forgot-password", jsonEncode(map));
    if (res.statusCode == 200) {
      print(res.body);
      return true;
    } else {
      print(res.body);
      return false;
    }
  }

  Future<bool> resetPassword(String code, String email, String password,
      String passwordConfirmation) async {
    final map = {
      "code": code,
      "email": email,
      "password": password,
      "passwordConfirmation": passwordConfirmation
    };
    final res = await apiProvider.post("/auth/reset-password", jsonEncode(map));

    if (res.body == "true") {
      print(res.body);
      return true;
    } else {
      print(res.body);
      return false;
    }
  }
}
