class ProductModel {
  ProductModel({
    this.id,
    this.title,
    this.description,
    this.price,
    this.slug,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.customField,
    this.image,
    this.categories,
    this.usersPermissionsUsers,
  });

  int? id;
  String? title;
  String? description;
  double? price;
  String? slug;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<CustomField>? customField;
  Image? image;
  List<Category>? categories;
  List<UsersPermissionsUser>? usersPermissionsUsers;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"].toDouble(),
        slug: json["slug"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        customField: List<CustomField>.from(
            json["Custom_field"].map((x) => CustomField.fromJson(x))),
        image: Image.fromJson(json["image"]),
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        usersPermissionsUsers: List<UsersPermissionsUser>.from(
            json["users_permissions_users"]
                .map((x) => UsersPermissionsUser.fromJson(x))),
      );
}

class Category {
  Category({
    this.id,
    this.name,
    this.slug,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? slug;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}

class CustomField {
  CustomField({
    this.id,
    this.title,
    this.required,
    this.options,
  });

  int? id;
  String? title;
  bool? required;
  String? options;

  factory CustomField.fromJson(Map<String, dynamic> json) => CustomField(
        id: json["id"],
        title: json["title"],
        required: json["required"],
        options: json["options"],
      );
}

class Image {
  Image({
    this.id,
    this.name,
    this.alternativeText,
    this.caption,
    this.width,
    this.height,
    this.formats,
    this.hash,
    this.ext,
    this.mime,
    this.size,
    this.url,
    this.previewUrl,
    this.provider,
    this.providerMetadata,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  dynamic alternativeText;
  dynamic caption;
  int? width;
  int? height;
  Formats? formats;
  String? hash;
  String? ext;
  String? mime;
  double? size;
  String? url;
  dynamic previewUrl;
  String? provider;
  dynamic providerMetadata;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
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
}

class Formats {
  Formats({
    this.thumbnail,
    this.small,
  });

  Thumbnail? thumbnail;
  Thumbnail? small;

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        small: json["small"] == null ? null : Thumbnail.fromJson(json["small"]),
      );
}

class Thumbnail {
  Thumbnail({
    this.name,
    this.hash,
    this.ext,
    this.mime,
    this.width,
    this.height,
    this.size,
    this.path,
    this.url,
  });

  String? name;
  String? hash;
  String? ext;
  String? mime;
  int? width;
  int? height;
  double? size;
  dynamic path;
  String? url;

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
}

class UsersPermissionsUser {
  UsersPermissionsUser({
    this.id,
    this.username,
    this.email,
    this.provider,
    this.confirmed,
    this.blocked,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? username;
  String? email;
  String? provider;
  bool? confirmed;
  bool? blocked;
  int? role;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory UsersPermissionsUser.fromJson(Map<String, dynamic> json) =>
      UsersPermissionsUser(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        provider: json["provider"],
        confirmed: json["confirmed"],
        blocked: json["blocked"],
        role: json["role"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}
