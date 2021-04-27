// To parse this JSON data, do
//
//     final storiesStatus = storiesStatusFromJson(jsonString);

import 'dart:convert';

List<StoriesStatus> storiesStatusFromJson(String str) =>
    List<StoriesStatus>.from(
        json.decode(str).map((x) => StoriesStatus.fromJson(x)));

String storiesStatusToJson(List<StoriesStatus> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoriesStatus {
  StoriesStatus({
    this.id,
    this.title,
    this.bgColor,
    this.url,
    this.caption,
    this.type,
    this.time,
    this.date,
  });

  String id;
  String title;
  String bgColor;
  String url;
  String caption;
  String type;
  String time;
  String date;

  factory StoriesStatus.fromJson(Map<String, dynamic> json) => StoriesStatus(
        id: json["id"],
        title: json["title"],
        bgColor: json["bg_color"],
        url: json["url"],
        caption: json["caption"],
        type: json["type"],
        time: json["time"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "bg_color": bgColor,
        "url": url,
        "caption": caption,
        "type": type,
        "time": time,
        "date": date,
      };
}
