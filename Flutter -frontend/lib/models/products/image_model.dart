class ImageModel {
    ImageModel({
        required this.id,
        required this.name,
        required this.alternativeText,
        required this.caption,
        required this.width,
        required this.height,
        required this.formats,
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
    });

    int id;
    String name;
    dynamic alternativeText;
    dynamic caption;
    int width;
    int height;
    Formats formats;
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

    factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        id: json["id"],
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        width: json["width"],
        height: json["height"],
        formats: Formats.fromJson(json["formats"]),
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
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "alternativeText": alternativeText,
        "caption": caption,
        "width": width,
        "height": height,
        "formats": formats.toJson(),
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
    };
}

class Formats {
    Formats({
        required this.thumbnail,
        required this.small,
    });

    Thumbnail thumbnail;
    Thumbnail? small;

    factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        small: json["small"] == null ? null : Thumbnail.fromJson(json["small"]),
    );

    Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail.toJson(),
        "small": small == null ? null : small!.toJson(),
    };
}

class Thumbnail {
    Thumbnail({
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

    factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
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