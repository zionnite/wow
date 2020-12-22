import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:wow/blocs/bloc_provider.dart';
import 'package:wow/model/Forum.dart';
import 'package:wow/model/ForumComment.dart';
import 'package:wow/services/ApiService.dart';

class ForumBloc implements BlocBase {
  final StreamController<List<Forum>> forumStreamController =
      BehaviorSubject<List<Forum>>();
  Stream<List<Forum>> get allforumStream => forumStreamController.stream;

  final StreamController<List<ForumComment>> forumCommentStreamCotroller =
      BehaviorSubject<List<ForumComment>>();
  Stream<List<ForumComment>> get allForumComment =>
      forumCommentStreamCotroller.stream;

  List<Forum> data;
  List<ForumComment> comment_data;

  ForumBloc() {
    forums();
  }

  forums() async {
    data = await getAllForums();
    forumStreamController.sink.add(data);
  }

  getCommentById(String id) async {
    comment_data = await getForumCommentById(id);
    forumCommentStreamCotroller.sink.add(comment_data);
  }

  @override
  void dispose() {
    forumStreamController.close();
    forumCommentStreamCotroller.close();
  }
}
