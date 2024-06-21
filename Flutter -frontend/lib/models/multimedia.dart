// To parse this JSON data, do
//
//     final profilePicture = profilePictureFromJson(jsonString);

import 'package:hero/models/user_strapi.dart';
import 'dart:convert';

Multimedia multimediaFromJson(String str) =>
    Multimedia.fromJson(json.decode(str));

String multimediaToJson(Multimedia data) => json.encode(data.toJson());

class Multimedia {
  Multimedia({
    required this.id,
    required this.name,
    required this.alternativeText,
    required this.caption,
    required this.width,
    required this.height,
    //this.formats,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    required this.previewUrl,
    required this.provider,
    required this.providerMetadata,
    required this.createdAt,
    required this.updatedAt,
    this.related,
  });

  int id;
  String name;
  dynamic alternativeText;
  dynamic caption;
  int width;
  int height;
  Formats? formats;
  String hash;
  String ext;
  String mime;
  double size;
  String url;
  dynamic previewUrl;
  String provider;
  dynamic providerMetadata;
  DateTime createdAt;
  DateTime updatedAt;
  List<UserStrapi>? related;

  factory Multimedia.fromJson(Map<String, dynamic> json) => Multimedia(
        id: json["id"],
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        width: json["width"] != null ? json["width"] : 0,
        height: json["height"] != null ? json["height"] : 0,
        //formats: Formats.fromJson(json["formats"]),
        hash: json["hash"],
        ext: json["ext"],
        mime: json["mime"],
        size: json["size"].toDouble(),
        url: json["url"],
        previewUrl: json["previewUrl"],
        provider: json["provider"],
        providerMetadata: json["provider_metadata"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        //related: List<UserStrapi>.from(json["related"].map((x) => UserStrapi.fromJsonUpdated(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "alternativeText": alternativeText,
        "caption": caption,
        "width": width,
        "height": height,
        // "formats": formats.toJson(),
        "hash": hash,
        "ext": ext,
        "mime": mime,
        "size": size,
        "url": url,
        "previewUrl": previewUrl,
        "provider": provider,
        "provider_metadata": providerMetadata,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        //"related": List<dynamic>.from(related.map((x) => x.toJson())),
      };
}

class Formats {
  Formats({
    required this.thumbnail,
    required this.large,
    required this.medium,
    required this.small,
  });

  Large thumbnail;
  Large large;
  Large medium;
  Large small;

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        thumbnail: Large.fromJson(json["thumbnail"]),
        large: Large.fromJson(json["large"]),
        medium: Large.fromJson(json["medium"]),
        small: Large.fromJson(json["small"]),
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail.toJson(),
        "large": large.toJson(),
        "medium": medium.toJson(),
        "small": small.toJson(),
      };
}

class Large {
  Large({
    required this.name,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.width,
    required this.height,
    required this.size,
    required this.path,
    required this.url,
  });

  String name;
  String hash;
  String ext;
  String mime;
  int width;
  int height;
  double size;
  dynamic path;
  String url;

  factory Large.fromJson(Map<String, dynamic> json) => Large(
        name: json["name"],
        hash: json["hash"],
        ext: json["ext"],
        mime: json["mime"],
        width: json["width"],
        height: json["height"],
        size: json["size"].toDouble(),
        path: json["path"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "hash": hash,
        "ext": ext,
        "mime": mime,
        "width": width,
        "height": height,
        "size": size,
        "path": path,
        "url": url,
      };
}
