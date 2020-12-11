import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:async';

class Quote {
  int id;
  String title;
  String desc;
  String image_name;
  String time_ago;
  String author;
  String author_image;

  Quote({
    this.id,
    this.title,
    this.desc,
    this.image_name,
    this.time_ago,
    this.author,
    this.author_image,
  });

  Quote.fromJson(Map<String, dynamic> json) {
    Quote(
      id: json['id'],
      title: json['title'],
      image_name: json['image_name'],
      time_ago: json['time_ago'],
      author: json['author'],
      author_image: json['author_image'],
    );
  }
}
