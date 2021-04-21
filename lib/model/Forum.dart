import 'dart:convert';

List<Forum> forumFromJson(String str) =>
    List<Forum>.from(json.decode(str).map((x) => Forum.fromJson(x)));

String forumToJson(List<Forum> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Forum {
  Forum({
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
    this.commentCounter,
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
  String commentCounter;

  factory Forum.fromJson(Map<String, dynamic> json) => Forum(
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
        commentCounter: json["comment_counter"],
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
        "comment_counter": commentCounter,
      };
}
