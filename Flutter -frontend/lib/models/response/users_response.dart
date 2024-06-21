// To parse this JSON data, do
//
//     final usersResponse = usersResponseFromJson(jsonString);

import 'dart:convert';

class UsersResponse {
  UsersResponse({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    this.data,
    this.support,
  });

  int page;
  int perPage;
  int total;
  int totalPages;
  List<UserData>? data;
  Support? support;

  factory UsersResponse.fromRawJson(String str) =>
      UsersResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UsersResponse.fromJson(Map<String, dynamic> json) => UsersResponse(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: List<UserData>.from(json["data"].map((x) => UserData.fromJson(x))),
        support: Support.fromJson(json["support"]),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "support": support!.toJson(),
      };
}

class UserData {
  UserData({
    required this.id,
    this.email,
    this.name,
    this.lastName,
    this.avatar,
  });

  int id;
  String? email;
  String? name;
  String? lastName;
  String? avatar;

  factory UserData.fromRawJson(String str) => UserData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        email: json["email"],
        name: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": name,
        "last_name": lastName,
        "avatar": avatar,
      };
}

class Support {
  Support({
    this.url,
    this.text,
  });

  String? url;
  String? text;

  factory Support.fromRawJson(String str) => Support.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Support.fromJson(Map<String, dynamic> json) => Support(
        url: json["url"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "text": text,
      };
}
