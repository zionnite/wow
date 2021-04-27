import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wow/model/Category.dart';
import 'package:wow/model/Forum.dart';
import 'package:wow/model/ForumComment.dart';
import 'package:wow/model/Quote.dart';
import 'package:http/http.dart' as http;
import 'package:wow/model/StoriesStatus.dart';
import 'package:wow/model/UserProfile.dart';

// final String mainUrl = 'http://wow.esuku.xyz/Api';
final String mainUrl = 'https://api.osherwomen.com/Api';
final String fakemainUrl = 'http://localhost/wow_php/Api';

Future<List<Quote>> getAllQuotes() async {
  final response = await http.get(Uri.parse('$mainUrl/get_quote'));
  return quoteFromJson(response.body);
}

Future<List<Quote>> getAllQuotesByPage(int current_page) async {
  final response = await http
      .get(Uri.parse('$mainUrl/get_quote_2/' + current_page.toString()));
  return quoteFromJson(response.body);
}

Future<List<Quote>> getQuoteById(String id) async {
  final response = await http.get(Uri.parse('$mainUrl/get_quote_by_id/$id'));
  return quoteFromJson(response.body);
}

Future<List<Quote>> getRandomQuote() async {
  final response = await http.get(Uri.parse('$mainUrl/get_random_quote'));
  return quoteFromJson(response.body);
}

Future<List<Category>> getAllCategory() async {
  final response = await http.get(Uri.parse('$mainUrl/get_category'));
  return categoryFromJson(response.body);
}

Future<List<Quote>> getQuoteByCatId(String catId, int current_page) async {
  final response = await http
      .get(Uri.parse('$mainUrl/get_quote_by_cat_id_2/$catId/$current_page'));
  return quoteFromJson(response.body);
}

Future<List<Forum>> getAllForums() async {
  final response = await http.get(Uri.parse('$mainUrl/get_forum'));
  return forumFromJson(response.body);
}

Future<List<Forum>> getAllForumPerPage(int current_page, String my_id) async {
  final response =
      await http.get(Uri.parse('$mainUrl/get_forum_2/$current_page/$my_id'));
  // print('my id ${my_id}');
  // print(response.body);
  return forumFromJson(response.body);
}

Future<List<ForumComment>> getForumCommentById(String id) async {
  final response =
      await http.get(Uri.parse('$mainUrl/get_forum_comment_by_id/$id'));
  return forumCommentFromJson(response.body);
}

Future<List<ForumComment>> getForumCommentByIdnPerPage(
    String id, int current_page, String my_id) async {
  final response = await http.get(
      Uri.parse('$mainUrl/get_forum_comment_by_id_2/$id/$current_page/$my_id'));
  return forumCommentFromJson(response.body);
}

Future<bool> makeCommentPost(
    String id, String name, String email, String comment) async {
  //return forumCommentFromJson(response.body);

  final uri = Uri.parse('$mainUrl/make_comment');
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

  final uri = Uri.parse('$mainUrl/make_post');
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
  final uri = Uri.parse('$mainUrl/search_forum');

  var response = await http.post(uri, body: {
    'search_term': search_term,
  });

  return forumFromJson(response.body);
}

Future<List<Forum>> searchForumPostByPage(
    String search_term, int current_page) async {
  final uri = Uri.parse('$mainUrl/search_forum_by_page/$current_page');

  var response = await http.post(uri, body: {
    'search_term': search_term,
  });

  return forumFromJson(response.body);
}

Future<bool> sendPrivateMsg({
  String name,
  String email,
  String message,
}) async {
  final uri = Uri.parse('$mainUrl/send_private_message');
  var request = http.MultipartRequest('POST', uri);
  request.fields['name'] = name;
  request.fields['email'] = email;
  request.fields['message'] = message;

  var respond = await request.send();

  //print(respond);
  if (respond.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

//Quote Yes Counter
Future<int> getCurrentQuoteYesCounter(String id) async {
  final response =
      await http.get(Uri.parse('$mainUrl/getCurrentQuoteYesCount/$id'));
  var body = response.body;
  Map<String, dynamic> j = json.decode(body);
  bool status = j['status'];
  int counter = j['counter'];
  // print('Counter Plus ${counter}');
  // print('Status Plus ${status}');
  if (status == true) {
    return counter;
  } else {
    return 0;
  }
}

Future<int> getQuoteYesCounter(
    String id, int current_counter, String user) async {
  final response = await http
      .get(Uri.parse('$mainUrl/post_make_counter/$id/$user/$current_counter'));
  var body = response.body;
  Map<String, dynamic> j = json.decode(body);
  bool status = j['status'];
  int counter = j['uplike_counter'];

  if (status == true) {
    return counter;
    // return counter;
  } else {
    return 0;
  }
}

//Quote No Counter
Future<int> getCurrentQuoteNoCounter(String id) async {
  final response =
      await http.get(Uri.parse('$mainUrl/getCurrentQuoteNoCount/$id'));
  var body = response.body;
  Map<String, dynamic> j = json.decode(body);
  bool status = j['status'];
  int counter = j['counter'];
  // print('Counter Plus ${counter}');
  // print('Status Plus ${status}');
  if (status == true) {
    return counter;
  } else {
    return 0;
  }
}

Future<int> getQuoteNoCounter(
  String id,
  int current_counter,
  String user,
  BuildContext context,
) async {
  final response = await http.get(
      Uri.parse('$mainUrl/post_make_down_counter/$id/$user/$current_counter'));
  var body = response.body;
  Map<String, dynamic> j = json.decode(body);
  bool status = j['status'];
  int counter = j['downlike_counter'];

  if (status == true) {
    return counter;
  } else {
    return 0;
  }
}

Future<List<Forum>> postReportProblem(
  String id,
  String report_type,
  BuildContext context,
  String user,
) async {
  final response = await http
      .get(Uri.parse('$mainUrl/post_report_problem/$id/$report_type/$user'));
  var body = response.body;
  Forum forum = Forum();

  // print(body);

  Map<String, dynamic> j = json.decode(body);
  String status = j['status'];
  String status_msg = j['status_msg'];

  // String qid = j['forum'][0]['id'];
  // String title = j['forum'][0]['title'];
  // String desc = j['forum'][0]['desc'];
  // String image = j['forum'][0]['image'];
  // String author = j['forum'][0]['author'];
  // String author_image = j['forum'][0]['author_image'];
  // String time = j['forum'][0]['time'];
  // String q_status = j['forum'][0]['status'];
  // String status_msg = j['forum'][0]['status_msg'];
  // String comment_counter = j['forum'][0]['comment_counter'];
  //
  // print('Status ${status}');
  //List<String> forum_list = new List<String>.from(body_quote[0]);
  //print('Forum List ${forum_list}');

  if (status == 'true') {
    var body_forum = j['forum'];

    final snacksBar = SnackBar(
      content: Text('Report Submitted!'),
      //action: SnackBarAction(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snacksBar);
    for (var bf in body_forum) {
      String qid = bf['id'];
      String title = bf['title'];
      String desc = bf['desc'];
      String image = bf['image'];
      String author = bf['author'];
      String author_image = bf['author_image'];
      String time = bf['time'];
      String q_status = bf['status'];
      String status_msg = bf['status_msg'];
      String comment_counter = bf['comment_counter'];

      Forum(
        id: qid,
        title: title,
        desc: desc,
        image: image,
        author: author,
        authorImage: author_image,
        time: time,
        status: q_status,
        statusMsg: status_msg,
        commentCounter: comment_counter,
      );
    }
    // return forumFromJson(body_forum);
  } else if (status == 'fail_01') {
    final snacksBar = SnackBar(
      content: Text(status_msg),
      //action: SnackBarAction(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snacksBar);
    //return forumFromJson(response.body[0]);
  } else if (status == 'fail_02') {
    final snacksBar = SnackBar(
      content: Text(status_msg),
      //action: SnackBarAction(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snacksBar);
    //return forumFromJson(response.body[0]);
  } else if (status == 'fail_03') {
    final snacksBar = SnackBar(
      content: Text(status_msg),
      //action: SnackBarAction(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snacksBar);
    //return forumFromJson(response.body[0]);
  }
}

Future<bool> postBlockUser({
  String id,
  String user,
  BuildContext context,
}) async {
  final response =
      await http.get(Uri.parse('$mainUrl/post_block_user/$id/$user'));
  var body = response.body;

  Map<String, dynamic> j = json.decode(body);
  String status = j['status'];

  // print(body);
  // print('Status ${status}');

  if (status == 'true') {
    final snacksBar = SnackBar(
      content: Text('You won\'t seen this user post anymore'),
      //action: SnackBarAction(),
    );

    ScaffoldMessenger.of(context).showSnackBar(snacksBar);
    return true;
  } else if (status == 'false') {
    final snacksBar = SnackBar(
      content: Text('Could not perform operation, Try Later!'),
      //action: SnackBarAction(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snacksBar);
    return false;
  } else if (status == 'already') {
    final snacksBar = SnackBar(
      content: Text('Already blocked User!'),
      //action: SnackBarAction(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snacksBar);
    return false;
  }
}

Future<bool> deletePost({
  String id,
  String user,
  BuildContext context,
}) async {
  final response = await http.get(Uri.parse('$mainUrl/delete_post/$id/$user'));
  var body = response.body;

  Map<String, dynamic> j = json.decode(body);
  String status = j['status'];

  if (status == 'true') {
    final snacksBar = SnackBar(
      content: Text('You won\'t seen this post anymore'),
      //action: SnackBarAction(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snacksBar);
    return true;
  } else if (status == 'false') {
    final snacksBar = SnackBar(
      content: Text('Could not perform operation, Try Later!'),
      //action: SnackBarAction(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snacksBar);
    return false;
  } else if (status == 'already') {
    final snacksBar = SnackBar(
      content: Text('Post already deleted!'),
      //action: SnackBarAction(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snacksBar);
    return false;
  }
}

Future<List<ForumComment>> commentReportProblem(
  String id,
  String report_type,
  BuildContext context,
  String forum_id,
  String user,
) async {
  final response = await http.get(Uri.parse(
      '$mainUrl/comment_report_problem/$forum_id/$id/$report_type/$user'));
  var body = response.body;

  // print(forum_id);
  // print(id);
  Map<String, dynamic> j = json.decode(body);
  String status = j['status'];
  String status_msg = j['status_msg'];

  if (status == 'true') {
    final snacksBar = SnackBar(
      content: Text('Comment has been Submitted for Review!'),
      //action: SnackBarAction(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snacksBar);

    // return forumFromJson(body_forum);
  } else if (status == 'fail_01' ||
      status == 'fail_02' ||
      status == 'fail_03' ||
      status == 'fail_04') {
    final snacksBar = SnackBar(
      content: Text(status_msg),
      //action: SnackBarAction(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snacksBar);
    //return forumFromJson(response.body[0]);
  }
}

Future<bool> commentBlockUser({
  String id,
  String user,
  BuildContext context,
}) async {
  final response =
      await http.get(Uri.parse('$mainUrl/comment_block_user/$id/$user'));
  var body = response.body;

  Map<String, dynamic> j = json.decode(body);
  String status = j['status'];

  if (status == 'true') {
    final snacksBar = SnackBar(
      content: Text('You won\'t seen this user post anymore'),
      //action: SnackBarAction(),
    );

    ScaffoldMessenger.of(context).showSnackBar(snacksBar);
    return true;
  } else if (status == 'false') {
    final snacksBar = SnackBar(
      content: Text('Could not perform operation, Try Later!'),
      //action: SnackBarAction(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snacksBar);
    return false;
  } else if (status == 'already') {
    final snacksBar = SnackBar(
      content: Text('Comment already deleted!'),
      //action: SnackBarAction(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snacksBar);
    return false;
  }
}

Future<bool> deleteComment({
  String forum_id,
  String id,
  String user,
  BuildContext context,
}) async {
  final response =
      await http.get(Uri.parse('$mainUrl/delete_comment/$forum_id/$id/$user'));
  var body = response.body;

  Map<String, dynamic> j = json.decode(body);
  String status = j['status'];
  String status_msg = j['status_msg'];

  if (status == "true") {
    final snacksBar = SnackBar(
      content: Text('You won\'t seen this comment anymore'),
      //action: SnackBarAction(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snacksBar);
    return true;
  } else if (status == "fail_01" ||
      status == 'fail_02' ||
      status == 'fail_03') {
    final snacksBar = SnackBar(
      content: Text(status_msg),
      //action: SnackBarAction(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snacksBar);
    return false;
  }
}

Future<String> toggle_follow_user({
  String my_id,
  String user_id,
  BuildContext context,
}) async {
  final response =
      await http.get(Uri.parse('$mainUrl/toggle_follow/$my_id/$user_id'));
  var body = response.body;

  Map<String, dynamic> j = json.decode(body);
  String status = j['status'];

  //following_true
  //following_false
  //unfollowing_true
  //unfollowing_false

  if (status == 'following_true') {
    final snacksBar = SnackBar(
      content: Text('You are Following User'),
      //action: SnackBarAction(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snacksBar);
    return status;
  } else if (status == 'following_false') {
    final snacksBar = SnackBar(
      content: Text('Could not perform operation, please try later!'),
      //action: SnackBarAction(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snacksBar);
    return status;
  } else if (status == 'unfollowing_true') {
    final snacksBar = SnackBar(
      content: Text('User unfollow'),
      //action: SnackBarAction(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snacksBar);
    return status;
  } else if (status == 'unfollowing_false') {
    final snacksBar = SnackBar(
      content: Text('Could not perform operation, please try later!'),
      //action: SnackBarAction(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snacksBar);
    return status;
  }
}

Future<List<UserProfile>> getAllUsersByPage(
    int current_page, String my_id) async {
  final response = await http
      .get(Uri.parse('$mainUrl/get_users/$my_id/' + current_page.toString()));
  return userProfileFromJson(response.body);
}

Future<List<UserProfile>> searchUsersByPage(
    String search_term, int current_page, String my_id) async {
  final uri = Uri.parse('$mainUrl/search_users/$current_page/$my_id');

  var response = await http.post(uri, body: {
    'search_term': search_term,
  });

  print(response.body);
  return userProfileFromJson(response.body);
}

Future<List<StoriesStatus>> getAllStories() async {
  final response = await http.get(Uri.parse('$mainUrl/get_stories_status'));
  return storiesStatusFromJson(response.body);
}
