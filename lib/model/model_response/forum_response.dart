import 'package:flutter/material.dart';
import 'package:wow/model/Forum.dart';


class ForumResponse{
  final List<Forum> quotes;
  final String error;

  ForumResponse(this.quotes, this.error);

  ForumResponse.fromJson(Map<String, dynamic> json)
      : quotes =
  (json["result"] as List).map((i) => new Forum.fromJson(i)).toList(),
        error="";

  ForumResponse.withError(String errorValue)
      : quotes = List(),
        error = errorValue;
}
