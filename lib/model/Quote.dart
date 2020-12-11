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

//   int _id;
//   String _title;
//   String _desc;
//   String _image_name;
//   String _time_ago;
//   String _author;
//   String _author_image;
//
//   Quote(
//     this._id,
//     this._title,
//     this._desc,
//     this._image_name,
//     this._time_ago,
//     this._author,
//     this._author_image,
//   );
//
//   String get author_image => _author_image;
//
//   set author_image(String value) {
//     _author_image = value;
//   }
//
//   String get author => _author;
//
//   set author(String value) {
//     _author = value;
//   }
//
//   String get time_ago => _time_ago;
//
//   set time_ago(String value) {
//     _time_ago = value;
//   }
//
//   String get image_name => _image_name;
//
//   set image_name(String value) {
//     _image_name = value;
//   }
//
//   String get desc => _desc;
//
//   set desc(String value) {
//     _desc = value;
//   }
//
//   String get title => _title;
//
//   set title(String value) {
//     _title = value;
//   }
//
//   int get id => _id;
//
//   set id(int value) {
//     _id = value;
//   }
// }
