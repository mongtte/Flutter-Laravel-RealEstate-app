// To parse this JSON data, do
//
//     final subCategory = subCategoryFromMap(jsonString);

// ignore_for_file: unnecessary_question_mark

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hero/lang/lang.dart';
import 'package:hero/shared/shared.dart';

class SubCategory {
  SubCategory({
    this.id,
    this.nameSubCategory,
    this.description,
    this.language,
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
    this.nameEn,
    this.nameEs,
    this.nameIt,
    this.category,
  });

  final int? id;
  final dynamic? nameSubCategory;
  final dynamic? description;
  final dynamic? language;
  final DateTime? publishedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? nameEn;
  final String? nameEs;
  final String? nameIt;
  final Category? category;

  factory SubCategory.fromJson(String str) =>
      SubCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubCategory.fromMap(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        nameSubCategory:
            json["nameSubCategory"] == null ? "" : json["nameSubCategory"],
        description: json["description"] == null ? "" : json["description"],
        language: json["language"] == null ? "" : json["language"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        nameEn: json["name_en"],
        nameEs: json["name_es"],
        nameIt: json["name_it"],
        category: Category.fromMap(json["category"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nameSubCategory": nameSubCategory,
        "description": description,
        "language": language,
        "published_at": publishedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name_en": nameEn,
        "name_es": nameEs,
        "name_it": nameIt,
        "category": category?.toMap(),
      };

  static List<SubCategory> fromListJson(List<dynamic> listSubCategory) {
    List<SubCategory> subcategories = [];
    for (var item in listSubCategory) {
      subcategories.add(SubCategory.fromMap(item));
    }
    return subcategories;
  }
}

class Category {
  Category(
      {this.id,
      this.language,
      this.createdAt,
      this.updatedAt,
      this.slug,
      this.nameEn,
      this.nameEs,
      this.nameIt,
      this.color,
      this.icon,
      this.type});

  final int? id;
  final dynamic? language;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic? slug;
  final String? nameEn;
  final String? nameEs;
  final String? nameIt;
  final Color? color;
  final IconData? icon;
  final String? type;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
      id: json["id"],
      language: json["language"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      slug: json["slug"],
      nameEn: json["name_en"],
      nameEs: json["name_es"],
      nameIt: json["name_it"],
      color: hexToColor(json["color"]),
      icon: IconData(int.parse(json["icon"]), fontFamily: "MaterialIcons"),
      type: json["type"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "language": language,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "slug": slug,
        "name_en": nameEn,
        "name_es": nameEs,
        "name_it": nameIt,
        //"color": color,
        "icon": icon!.codePoint,
        "type": type
      };

  String get name {
    String? local = TranslationService.locale.toString();
    switch (local) {
      case 'en_US':
        return this.nameEn ?? "no-name";
      case 'it_IT':
        return this.nameIt ?? 'no-name';
      case 'es_ES':
        return this.nameEs ?? 'no-name';
      default:
        return "no-name";
    }
  }

  static List<Category> fromListJson(List<dynamic> listCategory) {
    List<Category> categories = [];
    for (var item in listCategory) {
      categories.add(Category.fromMap(item));
    }
    return categories;
  }
}
