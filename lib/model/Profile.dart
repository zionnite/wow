// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    this.systemId,
    this.userId,
    this.fullName,
    this.age,
    this.sex,
    this.email,
    this.phoneNo,
    this.userImg,
    this.following,
    this.followers,
    //this.status,
    //this.statusMsg,
  });

  String systemId;
  String userId;
  String fullName;
  String age;
  String sex;
  String email;
  String phoneNo;
  String userImg;
  int following;
  int followers;
  String status;
  String statusMsg;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        systemId: json["system_id"],
        userId: json["user_id"],
        fullName: json["full_name"],
        age: json["age"],
        sex: json["sex"],
        email: json["email"],
        phoneNo: json["phone_no"],
        userImg: json["user_img"],
        following: json["following"],
        followers: json["followers"],
        //status: json["status"],
        //statusMsg: json["status_msg"],
      );

  Map<String, dynamic> toJson() => {
        "system_id": systemId,
        "user_id": userId,
        "full_name": fullName,
        "age": age,
        "sex": sex,
        "email": email,
        "phone_no": phoneNo,
        "user_img": userImg,
        "following": following,
        "followers": followers,
        //"status": status,
        //"status_msg": statusMsg,
      };

  //String get user_name => user_name;

  //setStatus(String status) => this.status = status;
}
