// To parse this JSON data, do
//
//     final chats = chatsFromJson(jsonString);

//import 'package:hero/models/chats/rooms_chats.dart';
import 'package:hero/models/models.dart';
import 'package:hero/models/multimedia.dart';
//import 'package:meta/meta.dart';
import 'dart:convert';

List<Chats> chatsFromJson(String str) =>
    List<Chats>.from(json.decode(str).map((x) => Chats.fromJson(x)));

String chatsToJson(List<Chats> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Chats {
  Chats(
      {this.id,
      //  required this.room,
      required this.message,
      required this.type,
      this.createdAt,
      this.updatedAt,
      required this.user,
      this.roomId,
      this.multimedia});

  int? id;
  // RoomsChats room;
  String message;
  Multimedia? multimedia;
  String type;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserStrapi user;
  int? roomId;

  factory Chats.fromJson(Map<String, dynamic> json) => Chats(
        id: json["id"],
        // room: RoomsChats.fromJson(json["room"]),
        message: json["message"],
        type: json["type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: UserStrapi.fromJsonUpdated(json["user"]),
        multimedia: json["multimedia"] != null
            ? Multimedia.fromJson(json["multimedia"])
            : null,
      );

  Map<String, dynamic> toJson() => { 
        // "id": id,
        // "room": room.toJson(),
        "message": message,
        "type": type,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        "user": user,
        "roomId": roomId,
      };
  static List<Chats> fromListJson(List<dynamic> listChats) {
    List<Chats> roomsChats = [];
    for (var item in listChats) {
      roomsChats.add(Chats.fromJson(item));
    }
    return roomsChats;
  }
}
