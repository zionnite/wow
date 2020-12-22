import 'package:wow/model/Category.dart';
import 'package:wow/model/Forum.dart';
import 'package:wow/model/ForumComment.dart';
import 'package:wow/model/Quote.dart';
import 'package:http/http.dart' as http;

final String mainUrl = 'http://wow.joons-me.com/Api';

Future<List<Quote>> getAllQuotes() async {
  final response = await http.get('$mainUrl/get_quote');
  return quoteFromJson(response.body);
}

Future<List<Quote>> getQuoteById(String id) async {
  final response = await http.get('$mainUrl/get_quote_by_id/$id');
  return quoteFromJson(response.body);
}

Future<List<Category>> getAllCategory() async {
  final response = await http.get('$mainUrl/get_category');
  return categoryFromJson(response.body);
}

Future<List<Quote>> getQuoteByCatId(String catId) async {
  final response = await http.get('$mainUrl/get_quote_by_cat_id/$catId');
  return quoteFromJson(response.body);
}

Future<List<Forum>> getAllForums() async {
  final response = await http.get('$mainUrl/get_forum');
  return forumFromJson(response.body);
}

Future<List<ForumComment>> getForumCommentById(String id) async {
  final response = await http.get('$mainUrl/get_forum_comment_by_id/$id');
  return forumCommentFromJson(response.body);
}
