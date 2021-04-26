// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
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
    this.iFollow,
  });

  String systemId;
  String userId;
  String fullName;
  String age;
  String sex;
  String email;
  String phoneNo;
  String userImg;
  String following;
  String followers;
  bool iFollow;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
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
        iFollow: json["iFollow"],
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
        "iFollow": iFollow,
      };
}
