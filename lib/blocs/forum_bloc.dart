import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wow/blocs/bloc_provider.dart';
import 'package:wow/blocs/validator/form_validator.dart';
import 'package:wow/model/Forum.dart';
import 'package:wow/model/ForumComment.dart';
import 'package:wow/services/ApiService.dart';

class ForumBloc extends Object with Validator implements BlocBase {
  final StreamController<List<Forum>> forumStreamController =
      BehaviorSubject<List<Forum>>();
  Stream<List<Forum>> get allforumStream => forumStreamController.stream;

  final StreamController<List<ForumComment>> forumCommentStreamController =
      BehaviorSubject<List<ForumComment>>();
  Stream<List<ForumComment>> get allForumComment =>
      forumCommentStreamController.stream;

  /*Forum Make Comment */
  final _mkcName = BehaviorSubject<String>();
  final _mkcEmail = BehaviorSubject<String>();
  final _mkcComment = BehaviorSubject<String>();

  Stream<String> get mkcNameSinkVal => _mkcName.transform(nameValidator);
  Stream<String> get mkcEmailSinkVal => _mkcEmail.transform(emailValidator);
  Stream<String> get mkcCommentStinkVal =>
      _mkcComment.transform(commentValidator);

  Function(String) get mkcNameSink => _mkcName.sink.add;
  Function(String) get mkcEmailSink => _mkcEmail.sink.add;
  Function(String) get mkcCommentSink => _mkcComment.sink.add;
  /*Forum Make Comment */

  /*Forum Make Post*/
  final _mkpName = BehaviorSubject<String>();
  final _mkpEmail = BehaviorSubject<String>();
  final _mkpTitle = BehaviorSubject<String>();
  final _mkpContent = BehaviorSubject<String>();
  final mkpPostImage = BehaviorSubject<File>();
  final mkpProfileImage = BehaviorSubject<File>();

  Stream<String> get mkpNameSinkVal => _mkpName.transform(nameValidator);
  Stream<String> get mkpEmailSinkVal => _mkpEmail.transform(emailValidator);
  Stream<String> get mkpTitleSinkVal => _mkpTitle.transform(titleValidator);
  Stream<String> get mkpContentSinkVal =>
      _mkpContent.transform(contentValidator);
  Stream<File> get mkpPostImageSinkVal =>
      mkpPostImage.transform(postImageValidator);
  Stream<File> get mkpProfileImageSinkVal =>
      mkpProfileImage.transform(profileImageValidator);

  //Stream<bool> get submitBtn  => Rx.combineLatestList(mkpNameSinkVal,mkpEmailSinkVal,mkpTitleSinkVal,mkpContentSinkVal,mkpPostImageSinkVal,mkpProfileImageSinkVal).

  Function(String) get mkpNameSink => _mkpName.sink.add;
  Function(String) get mkpEmailSink => _mkpEmail.sink.add;
  Function(String) get mkpTitleSink => _mkpTitle.sink.add;
  Function(String) get mkpContentSink => _mkpContent.sink.add;
  Function(File) get mkpPostImageSink => mkpPostImage.sink.add;
  Function(File) get mkpProfileImageSink => mkpProfileImage.sink.add;
  /*Forum Make Post*/

  /*Forum Search Post*/
  final StreamController<List<Forum>> searchController =
      BehaviorSubject<List<Forum>>();
  final StreamController<String> searchTermController =
      BehaviorSubject<String>();

  StreamSink<String> get searchSink => searchTermController.sink;
  Stream<List<Forum>> get searchStream => searchController.stream;
  /*Forum Search Post*/

  /*Per Page*/
  final StreamController<List<Forum>> perPageController =
      BehaviorSubject<List<Forum>>();
  Stream<List<Forum>> get perPageStream => perPageController.stream;

  /*Per Page*/

  /*Report a Problem*/

  final StreamController<List<Forum>> reportProblemController =
      BehaviorSubject<List<Forum>>();
  StreamSink<List<Forum>> get reportStreamSink => reportProblemController.sink;
  Stream<List<Forum>> get reportStream => reportProblemController.stream;
  /*Report a Problem*/

  /*Block User*/
  final StreamController<bool> blockUserController = BehaviorSubject<bool>();
  StreamSink<bool> get blockUserSink => blockUserController.sink;
  Stream<bool> get blockUserStream => blockUserController.stream;
  /*Block User*/

  /*Delete Post */
  final StreamController<bool> deletePostController = BehaviorSubject<bool>();
  StreamSink<bool> get deletePostSink => deletePostController.sink;
  Stream<bool> get deletePostStream => deletePostController.stream;
  /*Delete Post */

  /*Comment Reporting*/
  final StreamController<List<ForumComment>> reportCommentProblemController =
      BehaviorSubject<List<ForumComment>>();
  StreamSink<List<ForumComment>> get reportCommentStreamSink =>
      reportCommentProblemController.sink;
  Stream<List<ForumComment>> get reportCommentStream =>
      reportCommentProblemController.stream;
  /*Comment Reporting*/

  /*Block User*/
  final StreamController<bool> blockCommentUserController =
      BehaviorSubject<bool>();
  StreamSink<bool> get blockCommentUserSink => blockCommentUserController.sink;
  Stream<bool> get blockCommentUserStream => blockCommentUserController.stream;
  /*Block User*/

  /*Delete Comment */
  final StreamController<bool> deleteCommentController =
      BehaviorSubject<bool>();
  StreamSink<bool> get deleteCommentSink => deleteCommentController.sink;
  Stream<bool> get deleteCommentStream => deleteCommentController.stream;
  /*Delete Comment*/

  String report_status_i;
  bool blockUser, delete_Post, blockCommentUser, delete_comment;
  List<Forum> data, page_data, search_data, report_status;
  List<ForumComment> comment_data, comment_report_status;
  bool commentStatus;
  ForumBloc() {
    forums();
  }

  forums() async {
    data = await getAllForums();
    forumStreamController.sink.add(data);
  }

  /*Quote Screen*/
  forumPerPage(int perPage, String my_id) async {
    page_data = await getAllForumPerPage(perPage, my_id);
    perPageController.sink.add(page_data);
  }

  handleListenPerPage(List<Forum> forum) {
    page_data.addAll(forum);
    perPageController.sink.add(page_data);
  }

  handleListenRefresh(List<Forum> forum) {
    page_data.clear();
    page_data.addAll(forum);
    perPageController.sink.add(page_data);
  }
  /*Quote Screen*/

  getCommentById(String id) async {
    comment_data = await getForumCommentById(id);
    forumCommentStreamController.sink.add(comment_data);
  }

  getCommentByIdnPage(String id, int page, String my_id) async {
    comment_data = await getForumCommentByIdnPerPage(id, page, my_id);
    forumCommentStreamController.sink.add(comment_data);
  }

  handleCommentListenPerPage(List<ForumComment> forum) {
    comment_data.addAll(forum);
    forumCommentStreamController.sink.add(comment_data);
  }

  handleCommentListenRefresh(List<ForumComment> forum) {
    comment_data.clear();
    comment_data.addAll(forum);
    forumCommentStreamController.sink.add(comment_data);
  }

  postToComment(String id) async {
    commentStatus = await makeCommentPost(
        id, _mkcName.value, _mkcEmail.value, _mkcComment.value);

    return commentStatus;
  }

  postToPost(File postImage, File profileImage) async {
    commentStatus = await makePost(
      _mkpName.value,
      _mkpEmail.value,
      _mkpTitle.value,
      _mkpContent.value,
      postImage,
      profileImage,
    );

    return commentStatus;
  }

  searchForum(String search, int page) async {
    search_data = await searchForumPostByPage(search, page);
    searchController.sink.add(search_data);
  }

  handleSearchListenPerPage(List<Forum> forum) {
    search_data.addAll(forum);
    searchController.sink.add(search_data);
  }

  handleSearchListenRefresh(List<Forum> forum) {
    search_data.clear();
    search_data.addAll(forum);
    searchController.sink.add(search_data);
  }

  handleProblemReporting({
    String id,
    String user,
    String report_type,
    BuildContext context,
  }) async {
    report_status = await postReportProblem(id, report_type, context, user);
    reportProblemController.sink.add(report_status);
    forums();
  }

  handleBlockUser({
    String id,
    String user,
    BuildContext context,
  }) async {
    blockUser = await postBlockUser(id: id, user: user, context: context);
    blockUserController.sink.add(blockUser);
  }

  handlePostDelete({
    String id,
    String user,
    BuildContext context,
  }) async {
    delete_Post = await deletePost(id: id, user: user, context: context);
    deletePostController.sink.add(delete_Post);
  }

  handleCommentProblemReporting({
    String id,
    String user,
    String report_type,
    BuildContext context,
    String forum_id,
  }) async {
    comment_report_status =
        await commentReportProblem(id, report_type, context, forum_id, user);
    reportCommentProblemController.sink.add(comment_report_status);
    forums();
  }

  handleCommentBlockUser({String id, String user, BuildContext context}) async {
    blockCommentUser =
        await commentBlockUser(id: id, user: user, context: context);
    blockCommentUserController.sink.add(blockCommentUser);
  }

  handleDeleteComment(
      {String forum_id, String id, String user, BuildContext context}) async {
    delete_comment = await deleteComment(
        forum_id: forum_id, id: id, user: user, context: context);
    deleteCommentController.sink.add(blockCommentUser);
  }

  @override
  void dispose() {
    forumStreamController.close();
    forumCommentStreamController.close();
    _mkcName.close();
    _mkcEmail.close();
    _mkcComment.close();
    _mkpName.close();
    _mkpEmail.close();
    _mkpTitle.close();
    _mkpContent.close();
    mkpPostImage.close();
    mkpProfileImage.close();
    searchController.close();
    searchTermController.close();
    reportProblemController.close();
    blockUserController.close();
    deletePostController.close();
    reportCommentProblemController.close();
    blockCommentUserController.close();
    deleteCommentController.close();
  }
}
