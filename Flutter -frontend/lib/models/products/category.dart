class Category {
    Category({
        required this.id,
        required this.name,
        required this.slug,
        required this.createdAt,
        required this.updatedAt,
        required this.description,
    });

    int id;
    String name;
    dynamic slug;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic description;

   factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "description": description,
    };
}