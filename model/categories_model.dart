// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

Categories categoriesFromJson(String str) => Categories.fromJson(json.decode(str));

String categoriesToJson(Categories data) => json.encode(data.toJson());

class Categories {
  Categories({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  Result({
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
  DateTime deletedAt;
  String title;
  String slug;
  String description;
  String image;
  int parent;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
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
    "deleted_at": deletedAt == null ? null : deletedAt.toIso8601String(),
    "title": title,
    "slug": slug,
    "description": description,
    "image": image == null ? null : image,
    "parent": parent == null ? null : parent,
  };
}
