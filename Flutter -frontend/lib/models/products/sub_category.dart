/*class SubCategory {
    SubCategory({
        required this.id,
        required this.nameSubCategory,
        required this.publishedAt,
        required this.createdAt,
        required this.updatedAt,
        required this.description,
    });

    int id;
    String nameSubCategory;
    DateTime publishedAt;
    DateTime createdAt;
    DateTime updatedAt;
    String description;

    factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        nameSubCategory: json["nameSubCategory"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nameSubCategory": nameSubCategory,
        "published_at": publishedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "description": description,
    };
}*/