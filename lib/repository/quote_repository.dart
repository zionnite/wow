import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:wow/model/Quote.dart';
import 'package:wow/model/model_response/quote_response.dart';

class QuoteRepository {
  final String apiKey ='';
  static String mainUrl  ='http://localhost/wow_php/Api';
  final Dio dio = Dio();
  var get_quote_post  = '$mainUrl/get_quote';
  var get_quote_by_id  = '$mainUrl/get_quote_by_id';
  var get_forum_post  = '$mainUrl/get_forum';
  var get_forum_by_id  = '$mainUrl/get_forum_by_id';
  var get_forum_comment_by_id  = '$mainUrl/get_forum_comment_by_id';

  Future<QuoteResponse> getQuote() async {
    var params  ={
      "api_key": apiKey,
      "page":1,
    };
    try{
      Response response = await dio.get(get_forum_post, queryParameters: params);
      return QuoteResponse.fromJson(response.data);
    }catch(error, stackTrace){
      print('Exception Occured: $error stacktrace: $stackTrace');
      return QuoteResponse.withError("$error");
    }
  }

  Future<QuoteResponse> getQuoteById() async {
    var params  ={
      "api_key": apiKey,
      "page":1,
    };
    try{
      Response response = await dio.get(get_forum_by_id, queryParameters: params);
      return QuoteResponse.fromJson(response.data);
    }catch(error, stackTrace){
      print('Exception Occured: $error stacktrace: $stackTrace');
      return QuoteResponse.withError("$error");
    }
  }
}
