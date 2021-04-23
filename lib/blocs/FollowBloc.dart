import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wow/blocs/bloc_provider.dart';
import 'package:wow/services/ApiService.dart';

class FollowBloc implements BlocBase {
  /*Follow User*/
  final StreamController<String> toggleFollowController =
      BehaviorSubject<String>();
  StreamSink<String> get toggleFollowSink => toggleFollowController.sink;
  Stream<String> get toggleFollowStream => toggleFollowController.stream;
  /*Follow User*/

  String checker, unfollow_checker;

  handleFollowUser({String my_id, String user_id, BuildContext context}) async {
    checker = await toggle_follow_user(
        my_id: my_id, user_id: user_id, context: context);
    toggleFollowController.sink.add(checker);

    return checker;
  }

  @override
  void dispose() {
    toggleFollowController.close();
  }
}
