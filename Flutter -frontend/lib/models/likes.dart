//import 'package:hero/models/models.dart';
import 'package:hero/models/products/products.dart';
import 'dart:convert';

Likes likesFromJson(String str) => Likes.fromJson(json.decode(str));

String likesToJson(Likes data) => json.encode(data.toJson());

class Likes {
  Likes({
    this.id,
    required this.userId,
    required this.productId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int userId;
  int productId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Likes.fromJson(Map<String, dynamic> json) => Likes(
        id: json["id"],
        userId: json["user"],
        productId: json["product"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
  factory Likes.fromJsonIds(Map<String, dynamic> json) => Likes(
        id: json["id"],
        userId: json["user"]["id"],
        productId: json["product"]["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
  Map<String, dynamic> toJson() => {
        "user": userId,
        "product": productId,
      };

  static List<Products> fromListJsonGetProducts(List<dynamic> listPost) {
    List<Products> posts = [];
    for (var item in listPost) {
      item['product']['likes'] = [
        {
          'id': item['id'],
          'product': item['product']['id'],
          'user': item['user']['id'],
          'created_at': item['created_at'],
          'updated_at': item['updated_at'],
        }
      ];
      posts.add(Products.fromJson(item['product']));
    }
    return posts;
  }
}
