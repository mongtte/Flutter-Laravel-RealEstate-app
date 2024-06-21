class AdType {
    AdType({
        required this.id,
        required this.name,
        required this.publishedAt,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String name;
    DateTime publishedAt;
    DateTime createdAt;
    DateTime updatedAt;

    factory AdType.fromJson(Map<String, dynamic> json) => AdType(
        id: json["id"],
        name: json["name"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "published_at": publishedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}