import 'package:wow/model/Forum.dart';
import 'package:wow/model/ForumComment.dart';
import 'package:wow/model/Quote.dart';
import 'package:http/http.dart' as http;

final String mainUrl = 'http://wow.joons-me.com/Api';

Future<List<Quote>> getAllQuotes() async {
  final response = await http.get('$mainUrl/get_quote');
  return quoteFromJson(response.body);
}

Future<List<Forum>> getAllForums() async {
  final response = await http.get('$mainUrl/get_forum');
  return forumFromJson(response.body);
}

Future<List<ForumComment>> getForumCommentById(int Id) async {
  final response = await http.get('$mainUrl/get_forum_comment_by_id/$Id');
  return forumCommentFromJson(response.body);
}
