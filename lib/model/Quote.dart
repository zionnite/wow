import 'dart:convert';

List<Quote> quoteFromJson(String str) =>
    List<Quote>.from(json.decode(str).map((x) => Quote.fromJson(x)));

String quoteToJson(List<Quote> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quote {
  Quote({
    this.id,
    this.title,
    this.desc,
    this.image,
    this.author,
    this.authorImage,
    this.time,
    this.type,
    this.status,
    this.statusMsg,
  });

  String id;
  String title;
  String desc;
  String image;
  String author;
  String authorImage;
  String time;
  String type;
  String status;
  String statusMsg;

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
        image: json["image"],
        author: json["author"],
        authorImage: json["author_image"],
        time: json["time"],
        type: json["type"],
        status: json["status"],
        statusMsg: json["status_msg"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "desc": desc,
        "image": image,
        "author": author,
        "author_image": authorImage,
        "time": time,
        "type": type,
        "status": status,
        "status_msg": statusMsg,
      };
}
