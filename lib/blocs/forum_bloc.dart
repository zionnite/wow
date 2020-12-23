import 'dart:async';
import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:wow/blocs/bloc_provider.dart';
import 'package:wow/model/Forum.dart';
import 'package:wow/model/ForumComment.dart';
import 'package:wow/services/ApiService.dart';

class ForumBloc implements BlocBase {
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
  Function(String) get mkcNameSink => _mkcName.sink.add;
  Function(String) get mkcEmailSink => _mkcEmail.sink.add;
  Function(String) get mkcCommentSink => _mkcComment.sink.add;
  /*Forum Make Comment */

  /*Forum Make Post*/
  final _mkpName = BehaviorSubject<String>();
  final _mkpEmail = BehaviorSubject<String>();
  final _mkpTitle = BehaviorSubject<String>();
  final _mkpContent = BehaviorSubject<String>();
  final _mkpPostImage = BehaviorSubject<File>();
  final _mkpProfileImage = BehaviorSubject<File>();

  Function(String) get mkpNameSink => _mkpName.sink.add;
  Function(String) get mkpEmailSink => _mkpEmail.sink.add;
  Function(String) get mkpTitleSink => _mkpTitle.sink.add;
  Function(String) get mkpContentSink => _mkpContent.sink.add;
  Function(File) get mkpPostImageSink => _mkpPostImage.sink.add;
  Function(File) get mkpProfileImageSink => _mkpProfileImage.sink.add;

  /*Forum Make Post*/

  List<Forum> data;
  List<ForumComment> comment_data;
  bool commentStatus;
  ForumBloc() {
    forums();
  }

  forums() async {
    data = await getAllForums();
    forumStreamController.sink.add(data);
  }

  getCommentById(String id) async {
    comment_data = await getForumCommentById(id);
    forumCommentStreamController.sink.add(comment_data);
  }

  postToComment(String id) async {
    commentStatus = await makeCommentPost(
        id, _mkcName.value, _mkcEmail.value, _mkcComment.value);

    return commentStatus;
  }

  @override
  void dispose() {
    forumStreamController.close();
    forumCommentStreamController.close();
    _mkcName.close();
    _mkcEmail.close();
    _mkcComment.close();
  }
}
