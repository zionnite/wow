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
  });

  String comId;
  String comAuthor;
  String comBody;
  String comTime;

  factory ForumComment.fromJson(Map<String, dynamic> json) => ForumComment(
        comId: json["com_id"],
        comAuthor: json["com_author"],
        comBody: json["com_body"],
        comTime: json["com_time"],
      );

  Map<String, dynamic> toJson() => {
        "com_id": comId,
        "com_author": comAuthor,
        "com_body": comBody,
        "com_time": comTime,
      };
}
