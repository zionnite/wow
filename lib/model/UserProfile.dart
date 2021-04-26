import 'dart:convert';

List<UserProfile> userProfileFromJson(String str) => List<UserProfile>.from(
    json.decode(str).map((x) => UserProfile.fromJson(x)));

String userProfileToJson(List<UserProfile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
  int following;
  int followers;
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
