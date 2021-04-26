// To parse this JSON data, do
//
//     final forumComment = forumCommentFromJson(jsonString);

import 'dart:convert';

List<ForumComment> forumCommentFromJson(String str) => List<ForumComment>.from(
    json.decode(str).map((x) => ForumComment.fromJson(x)));

String forumCommentToJson(List<ForumComment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ForumComment {
  ForumComment({
    this.comId,
    this.comAuthor,
    this.comBody,
    this.comTime,
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

  String comId;
  String comAuthor;
  String comBody;
  String comTime;
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

  factory ForumComment.fromJson(Map<String, dynamic> json) => ForumComment(
        comId: json["com_id"],
        comAuthor: json["com_author"],
        comBody: json["com_body"],
        comTime: json["com_time"],
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
        "com_id": comId,
        "com_author": comAuthor,
        "com_body": comBody,
        "com_time": comTime,
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
