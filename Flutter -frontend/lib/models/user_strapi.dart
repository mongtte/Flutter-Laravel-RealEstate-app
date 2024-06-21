// To parse this JSON data, do
//
//     final usersResponse = usersResponseFromJson(jsonString);

//import 'package:meta/meta.dart';
import 'dart:convert';

UserStrapi usersResponseFromJson(String str) =>
    UserStrapi.fromJson(json.decode(str));

String usersResponseToJson(UserStrapi data) => json.encode(data.toJson());

class UserStrapi {
  UserStrapi({
    this.token,
    required this.id,
    required this.username,
    required this.email,
    required this.provider,
    //required this.confirmed,
    //required this.blocked,
    // required this.role,
    required this.validation,
    required this.aboutMe,
    required this.height,
    required this.smoker,
    required this.sonsAndDaughters,
    required this.bodyShape,
    required this.eyeColor,
    required this.sport,
    required this.recreation,
    required this.hairColor,
    required this.fantasy,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.phoneNumber,
    required this.birthday,
    required this.nameLastname,
    required this.currentLocation,
    required this.generalLocation,
  });

  String? token;
  int? id;
  String? username;
  String? email;
  String? provider;
  bool? confirmed;
  String? blocked;
  // String? role;
  String? validation;
  String? aboutMe;
  String? height;
  String? smoker = 'no';
  String? sonsAndDaughters = 'no';
  String? bodyShape = 'skinny';
  String? eyeColor = 'brown';
  String? sport = 'soccer';
  String? recreation = 'watchMovies';
  String? hairColor = 'black';
  String? fantasy = 'flirt';
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? phoneNumber;
  String? birthday;
  String? nameLastname;
  String? currentLocation;
  String? generalLocation;

  factory UserStrapi.fromJson(Map<String, dynamic> json) => UserStrapi(
        token: json["jwt"],
        id: json["user"]["id"],
        username: json["user"]["username"],
        email: json["user"]["email"],
        provider: json["user"]["provider"],
        //confirmed:        json["user"]["confirmed"],
        //blocked:          json["user"]["blocked"],
        // role: json["user"]["role"],
        validation: json["user"]["validation"],
        aboutMe: json["user"]["aboutMe"],
        height: json["user"]["height"],
        smoker: json["user"]["smoker"],
        sonsAndDaughters: json["user"]["sonsAndDaughters"],
        bodyShape: json["user"]["bodyShape"],
        eyeColor: json["user"]["eyeColor"],
        sport: json["user"]["sport"],
        recreation: json["user"]["recreation"],
        hairColor: json["user"]["hairColor"],
        fantasy: json["user"]["fantasy"],
        type: json["user"]["type"],
        createdAt: DateTime.parse(json["user"]["created_at"]),
        updatedAt: DateTime.parse(json["user"]["updated_at"]),
        phoneNumber: json["user"]["phoneNumber"],
        birthday: json["user"]["birthday"],
        nameLastname: json["user"]["nameLastname"],
        currentLocation: json["user"]["currentLocation"],
        generalLocation: json["user"]["generalLocation"],
      );

  factory UserStrapi.fromJson2(Map<String, dynamic> json) => UserStrapi(
        token: json["jwt"],
        id: json["id"],
        username: json["username"],
        email: json["email"],
        provider: json["provider"],
        validation: json["validation"] ?? "",
        aboutMe: json["aboutMe"] ?? "",
        height: json["height"] ?? "",
        smoker: json["smoker"] ?? "",
        sonsAndDaughters: json["sonsAndDaughters"] ?? "",
        bodyShape: json["bodyShape"] ?? "",
        eyeColor: json["eyeColor"] ?? "",
        sport: json["sport"] ?? "",
        recreation: json["recreation"] ?? "",
        hairColor: json["hairColor"] ?? "",
        fantasy: json["fantasy"] ?? "",
        type: json["type"] ?? "",
        createdAt:
            DateTime.parse(json["created_at"] ?? DateTime.now().toString()),
        updatedAt:
            DateTime.parse(json["updated_at"] ?? DateTime.now().toString()),
        phoneNumber: json["phoneNumber"] ?? "",
        birthday: json["birthday"] ?? "",
        nameLastname: json["nameLastname"] ?? "",
        currentLocation: json["currentLocation"] ?? "",
        generalLocation: json["generalLocation"] ?? "",
      );

  factory UserStrapi.fromJsonUpdated(Map<String, dynamic> json) => UserStrapi(
        id: json["id"],
        token: json["jwt"],
        username: json["username"],
        email: json["email"],
        provider: json["provider"],
        //confirmed:        json["confirmed"],
        //blocked:          json["blocked"],
        // role: json["role"],
        validation: json["validation"],
        aboutMe: json["aboutMe"],
        height:
            json["height"].toString() != '' ? json["height"].toString() : '100',
        smoker: json["smoker"] ?? 'no',
        sonsAndDaughters: json["sonsAndDaughters"] ?? 'no',
        bodyShape: json["bodyShape"] ?? 'delgado',
        eyeColor: json["eyeColor"] ?? 'cafe',
        sport: json["sport"] ?? 'futbol',
        recreation: json["recreation"] ?? 'peliculas',
        hairColor: json["hairColor"] ?? 'negro',
        fantasy: json["fantasy"] ?? 'ligar',
        type: json["type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        phoneNumber: json["phoneNumber"],
        birthday: json["birthday"],
        nameLastname: json["nameLastname"],
        currentLocation: json["currentLocation"],
        generalLocation: json["generalLocation"],
      );
  Map<String, dynamic> toJson() => {
        "jwt": token,
        "id": id,
        "username": username,
        "email": email,
        "provider": provider,
        "confirmed": confirmed,
        "blocked": blocked,
        // "role": role,
        "validation": validation,
        "aboutMe": aboutMe,
        "height": height,
        "smoker": smoker,
        "sonsAndDaughters": sonsAndDaughters,
        "bodyShape": bodyShape,
        "eyeColor": eyeColor,
        "sport": sport,
        "recreation": recreation,
        "hairColor": hairColor,
        "fantasy": fantasy,
        "type": type,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "phoneNumber": phoneNumber,
        "birthday": birthday,
        "nameLastname": nameLastname,
        "currentLocation": currentLocation,
        "generalLocation": generalLocation,
      };

  UserStrapi copyWith({
    String? token,
    int? id,
    String? username,
    String? email,
    String? provider,
    bool? confirmed,
    String? blocked,
    String? role,
    String? validation,
    String? aboutMe,
    String? height,
    String? smoker,
    String? sonsAndDaughters,
    String? bodyShape,
    String? eyeColor,
    String? sport,
    String? recreation,
    String? hairColor,
    String? fantasy,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? phoneNumber,
    String? birthday,
    String? nameLastname,
    String? currentLocation,
    String? generalLocation,
  }) {
    return UserStrapi(
      token: token ?? this.token,
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      provider: provider ?? this.provider,
      //confirmed:         confirmed        ?? this.confirmed,
      //blocked:           blocked          ?? this.blocked,
      // role:              role             ?? this.role,
      validation: validation ?? this.validation,
      aboutMe: aboutMe ?? this.aboutMe,
      height: height ?? this.height,
      smoker: smoker ?? this.smoker,
      sonsAndDaughters: sonsAndDaughters ?? this.sonsAndDaughters,
      bodyShape: bodyShape ?? this.bodyShape,
      eyeColor: eyeColor ?? this.eyeColor,
      sport: sport ?? this.sport,
      recreation: recreation ?? this.recreation,
      hairColor: hairColor ?? this.hairColor,
      fantasy: fantasy ?? this.fantasy,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthday: birthday ?? this.birthday,
      nameLastname: nameLastname ?? this.nameLastname,
      currentLocation: currentLocation ?? this.currentLocation,
      generalLocation: generalLocation ?? this.generalLocation,
    );
  }
}
