// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'package:hero/models/models.dart';
import 'package:hero/models/multimedia.dart';
//import 'package:hero/models/products/ad_type.dart';
//import 'package:hero/models/products/category.dart';
//import 'package:hero/models/products/image_model.dart';
//import 'package:hero/models/products/sub_category.dart';
import 'package:hero/models/subcategory.dart';
//import 'package:meta/meta.dart';
import 'dart:convert';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
  Products(
      {this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.phoneNumber,
      required this.currency,
      required this.city,
      required this.adType,
      this.subCategory,
      required this.category,
      required this.peopleType,
      required this.statusProduct,
      this.user,
      this.slug,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.country,
      this.multimedia,
      this.likes});

  String title;
  String description;
  double price;
  int phoneNumber;
  dynamic slug;
  String currency;
  dynamic city;
  String adType;
  SubCategory? subCategory;
  String category;
  String peopleType;
  String statusProduct;
  dynamic country;
  UserStrapi? user;
  int? id;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? publishedAt;
  List<Multimedia>? multimedia;
  List<Likes>? likes;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"].toDouble(),
        phoneNumber:
            json["phone_number"] != null ? int.parse(json["phone_number"]) : 0,
        slug: json["slug"],
        status: json["status"],
        statusProduct: json["status_product"] ?? "",
        peopleType: json["people_type"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        publishedAt: json["published_at"] == null ? false : true,
        currency: json["currency"],
        city: json["city"] ?? "",
        country: json["country"] ?? "",
        adType: json["ad_type"] ?? "",
        subCategory: SubCategory.fromMap(json["sub_category"]),
        category: json["category"] ?? "",
        user: json["user"] != null
            ? UserStrapi.fromJsonUpdated(json["user"])
            : null,
        multimedia: json["multimedia"] != null
            ? List<Multimedia>.from(
                json["multimedia"].map((x) => Multimedia.fromJson(x)))
            : null,
        likes: json["likes"] != null
            ? List<Likes>.from(json["likes"].map((x) => Likes.fromJson(x)))
            : null,
      );

//FOR UPDATE

  factory Products.fromJsonForUpdate(Map<String, dynamic> json) => Products(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"].toDouble(),
        phoneNumber:
            json["phone_number"] != null ? int.parse(json["phone_number"]) : 0,
        slug: json["slug"],
        status: json["status"],
        statusProduct: json["status_product"] ?? "",
        peopleType: json["people_type"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        publishedAt: json["published_at"] == null ? false : true,
        currency: json["currency"],
        city: json["city"] ?? "",
        country: json["country"] ?? "",
        adType: json["ad_type"] ?? "",
        subCategory: SubCategory.fromMap(json["sub_category"]),
        category: json["category"] ?? "",
        multimedia: json["multimedia"] != null
            ? List<Multimedia>.from(
                json["multimedia"].map((x) => Multimedia.fromJson(x)))
            : null,
        likes: json["likes"] != null
            ? List<Likes>.from(json["likes"].map((x) => Likes.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "price": price.toInt(),
        "phone_number": phoneNumber,
        "status_product": statusProduct ?? "",
        "status": status,
        "slug":slug,
        "people_type": peopleType,
        "currency": currency,
        "city": city,
        "country":country,
        "ad_type": adType,
        "sub_category": subCategory!.toMap(),
        "category": category,
        "user": user != null ? user!.toJson() : null,
      };
  static List<Products> fromListJson(List<dynamic> listPost) {
    List<Products> posts = [];
    for (var item in listPost) {
      posts.add(Products.fromJson(item));
    }
    return posts;
  }
}
