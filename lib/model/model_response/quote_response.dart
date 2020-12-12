import 'package:flutter/material.dart';
import 'package:wow/model/Quote.dart';


class QuoteResponse{
  final List<Quote> quotes;
  final String error;

  QuoteResponse(this.quotes, this.error);

  QuoteResponse.fromJson(Map<String, dynamic> json)
    : quotes =
      (json["result"] as List).map((i) => new Quote.fromJson(i)).toList(),
        error="";

  QuoteResponse.withError(String errorValue)
    : quotes = List(),
      error = errorValue;
}
