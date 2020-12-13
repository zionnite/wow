import 'package:flutter/material.dart';
import 'package:wow/model/Quote.dart';

class QuoteResponse {
  final List<Quote> quotes;
  String error;

  QuoteResponse(this.quotes, this.error);

  // QuoteResponse.fromJson(List<dynamic> json)
  //     : quotes = (json[0] as List).map((i) => new Quote.fromJson(i)).toList(),
  //       error = "";

  // QuoteResponse.fromJson(List<dynamic> json)
  //     : quotes = json.map((i) => new Quote.fromJson(i)).toList(),
  //       error = "";

  // factory QuoteResponse.fromJson(List<dynamic> parsedJson) {
  //   List<Quote> quotes = new List<Quote>();
  //   //quotes = parsedJson.map((i) => Quote.fromJson(i)).toList();
  //   List<Quote> list =
  //       List<Quote>.from(parsedJson.map((i) => Quote.fromJson(i)));
  //   String error = '';
  //
  //   return new QuoteResponse(list, error);
  // }

  factory QuoteResponse.fromJson(List<dynamic> parsedJson) {
    List<Quote> quotes = new List<Quote>();
    //quotes = parsedJson.map((i) => Quote.fromJson(i)).toList();
    quotes = List<Quote>.from(parsedJson.map((i) => Quote.fromJson(i)));
    String error = '';

    return new QuoteResponse(quotes, error);
  }
  QuoteResponse.withError(String errorValue)
      : quotes = List(),
        error = errorValue;
}
