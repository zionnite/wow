// To parse this JSON data, do
//
//     final forum = forumFromJson(jsonString);

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
    this.userId,
    this.userName,
    this.fullName,
    this.sex,
    this.age,
    this.phoneNo,
    this.userImg,
    this.following,
    this.followers,
    this.iFollow,
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
  String userId;
  String userName;
  String fullName;
  String sex;
  String age;
  String phoneNo;
  String userImg;
  int following;
  int followers;
  bool iFollow;

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
        userId: json["user_id"],
        userName: json["user_name"],
        fullName: json["full_name"],
        sex: json["sex"],
        age: json["age"],
        phoneNo: json["phone_no"],
        userImg: json["user_img"],
        following: json["following"],
        followers: json["followers"],
        iFollow: json["iFollow"],
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
        "user_id": userId,
        "user_name": userName,
        "full_name": fullName,
        "sex": sex,
        "age": age,
        "phone_no": phoneNo,
        "user_img": userImg,
        "following": following,
        "followers": followers,
        "iFollow": iFollow,
      };
}
