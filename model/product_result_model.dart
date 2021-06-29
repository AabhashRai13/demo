// To parse this JSON data, do
//
//     final productsResult = productsResultFromJson(jsonString);

import 'dart:convert';

ProductsResult productsResultFromJson(String str) => ProductsResult.fromJson(json.decode(str));

String productsResultToJson(ProductsResult data) => json.encode(data.toJson());


class ProductsResult {
  ProductsResult({
    this.id,
    this.variant,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
    this.slug,
    this.description,
    this.quantity,
    // this.oldPrice,
    // this.price,
    this.vat,
    this.vatIncluded,
    this.vatAmount,
    this.discountPercent,
    this.discountAmount,
    // this.grandTotal,
    this.expireOn,
    this.isNew,
    this.isOnSale,
    this.isComingSoon,
    this.priority,
    this.views,
    this.batch,
    this.brand,
    this.categories,
    this.tags,
    this.photos,
  });

  int id;
  List<Variant> variant;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String name;
  String slug;
  String description;
  int quantity;
  // double oldPrice;
  // double price;
  double vat;
  bool vatIncluded;
  double vatAmount;
  double discountPercent;
  double discountAmount;
  // double grandTotal;
  dynamic expireOn;
  bool isNew;
  bool isOnSale;
  bool isComingSoon;
  int priority;
  int views;
  String batch;
  Brand brand;
  List<Category> categories;
  List<Tag> tags;
  List<Photo> photos;

  factory ProductsResult.fromJson(Map<String, dynamic> json) => ProductsResult(
    id: json["id"],
    variant: List<Variant>.from(json["variant"].map((x) => Variant.fromJson(x))),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    name: json["name"],
    slug: json["slug"],
    description: json["description"],
    quantity: json["quantity"],
    // oldPrice: json["old_price"],
    // price: json["price"],
    vat: json["vat"],
    vatIncluded: json["vat_included"],
    vatAmount: json["vat_amount"],
    discountPercent: json["discount_percent"],
    discountAmount: json["discount_amount"],
    // grandTotal: json["grand_total"],
    expireOn: json["expire_on"],
    isNew: json["is_new"],
    isOnSale: json["is_on_sale"],
    isComingSoon: json["is_coming_soon"],
    priority: json["priority"],
    views: json["views"],
    batch: json["batch"],
    brand: Brand.fromJson(json["brand"]),
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
    photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
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
    "quantity": quantity,
    // "old_price": oldPrice,
    // "price": price,
    "vat": vat,
    "vat_included": vatIncluded,
    "vat_amount": vatAmount,
    "discount_percent": discountPercent,
    "discount_amount": discountAmount,
    // "grand_total": grandTotal,
    "expire_on": expireOn,
    "is_new": isNew,
    "is_on_sale": isOnSale,
    "is_coming_soon": isComingSoon,
    "priority": priority,
    "views": views,
    "batch": batch,
    "brand": brand.toJson(),
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
    "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
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
  dynamic image;
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
  dynamic image;
  dynamic parent;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    title: json["title"],
    slug: json["slug"],
    description: json["description"],
    image: json["image"],
    parent: json["parent"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "title": title,
    "slug": slug,
    "description": description,
    "image": image,
    "parent": parent,
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
  String caption;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    id: json["id"],
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
  dynamic deletedAt;
  String title;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "title": title,
  };
}

class Variant {
  Variant({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.variations,
    this.quantity,
    this.price,
    this.product,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  Variations variations;
  int quantity;
  double price;
  int product;

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    variations: Variations.fromJson(json["variations"]),
    quantity: json["quantity"],
    price: json["price"],
    product: json["product"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "variations": variations.toJson(),
    "quantity": quantity,
    "price": price,
    "product": product,
  };
}

class Variations {
  Variations({
    this.bb,
    this.cc,
  });

  String bb;
  String cc;

  factory Variations.fromJson(Map<String, dynamic> json) => Variations(
    bb: json["bb"],
    cc: json["cc"],
  );

  Map<String, dynamic> toJson() => {
    "bb": bb,
    "cc": cc,
  };
}
