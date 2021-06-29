// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
  Products({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  String next;
  dynamic previous;
  List<Result> results;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results:
    List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  Result(
      {this.id,
        this.variant,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.name,
        this.slug,
        this.description,
        this.vat,
        this.vatIncluded,
        this.vatAmount,
        this.discountPercent,
        this.discountAmount,
        this.isNew,
        this.isOnSale,
        this.isComingSoon,
        this.priority,
        this.views,
        this.brand,
        this.categories,
        this.tags,
        this.photos,
        this.isAdded});

  int id;
  List<Variant> variant;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String name;
  String slug;
  String description;
  double vat;
  bool vatIncluded;
  double vatAmount;
  double discountPercent;
  double discountAmount;
  bool isNew;
  bool isOnSale;
  bool isComingSoon;
  int priority;
  int views;
  Brand brand;
  List<Category> categories;
  List<Tag> tags;
  List<Photo> photos;
  bool isAdded;
  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    variant:
    List<Variant>.from(json["variant"].map((x) => Variant.fromJson(x))),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    name: json["name"],
    slug: json["slug"],
    description: json["description"],
    vat: json["vat"],
    vatIncluded: json["vat_included"],
    vatAmount: json["vat_amount"].toDouble(),
    discountPercent: json["discount_percent"],
    discountAmount: json["discount_amount"].toDouble(),
    isNew: json["is_new"],
    isOnSale: json["is_on_sale"],
    isComingSoon: json["is_coming_soon"],
    priority: json["priority"],
    views: json["views"],
    brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
    categories: List<Category>.from(
        json["categories"].map((x) => Category.fromJson(x))),
    tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
    photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
    isAdded: json["wishlist_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "variant": List<dynamic>.from(variant.map((x) => x.toJson())),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "name": name,
    "slug": slug,
    "description": description,
    "vat": vat,
    "vat_included": vatIncluded,
    "vat_amount": vatAmount,
    "discount_percent": discountPercent,
    "discount_amount": discountAmount,
    "is_new": isNew,
    "is_on_sale": isOnSale,
    "is_coming_soon": isComingSoon,
    "priority": priority,
    "views": views,
    "brand": brand.toJson(),
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
    "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
    "isAdded": isAdded,
  };
}

class Brand {
  Brand({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
    this.image,
    this.slug,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String name;
  String image;
  String slug;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    name: json["name"],
    image: json["image"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "name": name,
    "image": image,
    "slug": slug,
  };
}

class Category {
  Category({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.title,
    this.slug,
    this.description,
    this.image,
    this.parent,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String title;
  String slug;
  String description;
  String image;
  dynamic parent;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    title: json["title"],
    slug: json["slug"],
    description: json["description"],
    image: json["image"] == null ? null : json["image"],
    parent: json["parent"] == null ? null : json["parent"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "title": title,
    "slug": slug,
    "description": description,
    "image": image == null ? null : image,
    "parent": parent == null ? null : parent,
  };
}

class Photo {
  Photo({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.photo,
    this.isTitlePhoto,
    this.caption,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String photo;
  bool isTitlePhoto;
  dynamic caption;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    id: json["id"] ?? "",
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    photo: json["photo"],
    isTitlePhoto: json["is_title_photo"],
    caption: json["caption"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "photo": photo,
    "is_title_photo": isTitlePhoto,
    "caption": caption,
  };
}

class Tag {
  Tag({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.title,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime deletedAt;
  Title title;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    id: json["id"] ?? "",
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"] == null
        ? null
        : DateTime.parse(json["deleted_at"]),
    title: titleValues.map[json["title"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt == null ? null : deletedAt.toIso8601String(),
    "title": titleValues.reverse[title],
  };
}

enum Title { NEW_NEW, PRIXA1, PRIXA2, NEW, PRIXA }

final titleValues = EnumValues({
  "new": Title.NEW,
  "new new": Title.NEW_NEW,
  "prixa": Title.PRIXA,
  "prixa1": Title.PRIXA1,
  "prixa2": Title.PRIXA2
});

class Variant {
  Variant({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.size,
    this.variations,
    this.quantity,
    this.price,
    this.oldPrice,
    this.isDefault,
    this.product,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String size;
  Variations variations;
  int quantity;
  double price;
  double oldPrice;
  bool isDefault;
  int product;

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    id: json["id"] ?? "",
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    size: json["size"],
    variations: Variations.fromJson(json["variations"]),
    quantity: json["quantity"],
    price: json["price"].toDouble(),
    oldPrice: json["old_price"],
    isDefault: json["is_default"],
    product: json["product"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "size": size,
    "variations": variations.toJson(),
    "quantity": quantity,
    "price": price,
    "old_price": oldPrice,
    "is_default": isDefault,
    "product": product,
  };
}

class Variations {
  Variations({
    this.type,
  });

  String type;

  factory Variations.fromJson(Map<String, dynamic> json) => Variations(
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
