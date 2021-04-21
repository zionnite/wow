import 'dart:convert';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    this.catId,
    this.catName,
  });

  String catId;
  String catName;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        catId: json["cat_id"],
        catName: json["cat_name"],
      );

  Map<String, dynamic> toJson() => {
        "cat_id": catId,
        "cat_name": catName,
      };
}
