import 'dart:io';

import 'package:wow/model/Category.dart';
import 'package:wow/model/Forum.dart';
import 'package:wow/model/ForumComment.dart';
import 'package:wow/model/Quote.dart';
import 'package:http/http.dart' as http;

final String mainUrl = 'http://wow.joons-me.com/Api';
final String fakemainUrl = 'http://localhost/wow_php/Api';

Future<List<Quote>> getAllQuotes() async {
  final response = await http.get('$fakemainUrl/get_quote');
  return quoteFromJson(response.body);
}

Future<List<Quote>> getAllQuotesByPage(int current_page) async {
  final response =
      await http.get('$fakemainUrl/get_quote_2/' + current_page.toString());
  return quoteFromJson(response.body);
}

Future<List<Quote>> getQuoteById(String id) async {
  final response = await http.get('$fakemainUrl/get_quote_by_id/$id');
  return quoteFromJson(response.body);
}

Future<List<Category>> getAllCategory() async {
  final response = await http.get('$fakemainUrl/get_category');
  return categoryFromJson(response.body);
}

Future<List<Quote>> getQuoteByCatId(String catId, int current_page) async {
  final response =
      await http.get('$fakemainUrl/get_quote_by_cat_id_2/$catId/$current_page');
  return quoteFromJson(response.body);
}

Future<List<Forum>> getAllForums() async {
  final response = await http.get('$fakemainUrl/get_forum');
  return forumFromJson(response.body);
}

Future<List<Forum>> getAllForumPerPage(int current_page) async {
  final response = await http.get('$fakemainUrl/get_forum_2/$current_page');
  return forumFromJson(response.body);
}

Future<List<ForumComment>> getForumCommentById(String id) async {
  final response = await http.get('$fakemainUrl/get_forum_comment_by_id/$id');
  return forumCommentFromJson(response.body);
}

Future<List<ForumComment>> getForumCommentByIdnPerPage(
    String id, int current_page) async {
  final response = await http
      .get('$fakemainUrl/get_forum_comment_by_id_2/$id/$current_page');
  return forumCommentFromJson(response.body);
}

Future<bool> makeCommentPost(
    String id, String name, String email, String comment) async {
  //return forumCommentFromJson(response.body);

  final uri = Uri.parse('$fakemainUrl/make_comment');
  var request = http.MultipartRequest('POST', uri);
  request.fields['name'] = name;
  request.fields['email'] = email;
  request.fields['comment'] = comment;
  request.fields['forum_id'] = id;

  var respond = await request.send();
  if (respond.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> makePost(String name, String email, String title, String comment,
    File postImg, File profileImg) async {
  //return forumCommentFromJson(response.body);

  final uri = Uri.parse('$fakemainUrl/make_post');
  var request = http.MultipartRequest('POST', uri);
  request.fields['title'] = title;
  request.fields['body'] = comment;
  request.fields['author'] = name;
  request.fields['email'] = email;

  var postImage = await http.MultipartFile.fromPath('post_image', postImg.path);
  request.files.add(postImage);

  var profileImage =
      await http.MultipartFile.fromPath('profile_image', profileImg.path);
  request.files.add(profileImage);

  var respond = await request.send();
  if (respond.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<List<Forum>> searchForumPost(String search_term) async {
  final uri = Uri.parse('$fakemainUrl/search_forum');

  var response = await http.post(uri, body: {
    'search_term': search_term,
  });

  return forumFromJson(response.body);
}
