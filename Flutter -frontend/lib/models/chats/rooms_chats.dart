// To parse this JSON data, do
//
//     final roomsChats = roomsChatsFromJson(jsonString);

import 'package:hero/models/chats/chats.dart';
import 'package:hero/models/models.dart';
import 'package:hero/models/products/products.dart';
//import 'package:meta/meta.dart';
import 'dart:convert';

List<RoomsChats> roomsChatsFromJson(String str) =>
    List<RoomsChats>.from(json.decode(str).map((x) => RoomsChats.fromJson(x)));

String roomsChatsToJson(List<RoomsChats> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RoomsChats {
  RoomsChats({
    this.id,
    this.createdAt,
    this.updatedAt,
    required this.product,
    this.post,
    this.user,
  });

  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  Products? product;
  UserStrapi? user;
  UserStrapi? post;
  List<Chats>? chats;

  factory RoomsChats.fromJson(Map<String, dynamic> json) => RoomsChats(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        product: json["product"].length > 1
            ? Products.fromJson(json["product"])
            : null,
        post: UserStrapi.fromJsonUpdated(json["post"]),
        user: UserStrapi.fromJsonUpdated(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        "product": product!.id,
        "post": post!.id,
        "user": user!.id,
      };
  static List<RoomsChats> fromListJson(List<dynamic> listRoomChats) {
    List<RoomsChats> roomsChats = [];
    for (var item in listRoomChats) {
      //item['product']['user'] = null;
      if(item['product'] != null) {
        roomsChats.add(RoomsChats.fromJson(item));
      }
    }
    print(roomsChats);
    return roomsChats;
  }
}
