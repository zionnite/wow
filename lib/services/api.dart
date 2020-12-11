import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:wow/model/Quote.dart';

class AppApi {
  Future<Quote> fetchQuote() async {
    final response = await http.get('http://localhost/wow_php/Api/get_quote/');
    if (response.statusCode == 200) {
      print(response.body);
      return Quote.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Load Quote');
    }
  }
}
