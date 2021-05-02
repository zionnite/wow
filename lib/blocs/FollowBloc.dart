import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wow/blocs/bloc_provider.dart';
import 'package:wow/model/UserProfile.dart';
import 'package:wow/services/ApiService.dart';

class FollowBloc implements BlocBase {
  /*Follow User*/
  final StreamController<String> toggleFollowController =
      BehaviorSubject<String>();
  StreamSink<String> get toggleFollowSink => toggleFollowController.sink;
  Stream<String> get toggleFollowStream => toggleFollowController.stream;
  /*Follow User*/

  /*Follower*/
  final StreamController<List<UserProfile>> followerController =
      BehaviorSubject<List<UserProfile>>();
  Stream<List<UserProfile>> get followerPerPageStream =>
      followerController.stream;

  /*Following*/
  final StreamController<List<UserProfile>> followingController =
      BehaviorSubject<List<UserProfile>>();
  Stream<List<UserProfile>> get followingPerPageStream =>
      followingController.stream;

  /*userFollower*/
  final StreamController<List<UserProfile>> userFollowerController =
      BehaviorSubject<List<UserProfile>>();
  Stream<List<UserProfile>> get userFollowerPerPageStream =>
      userFollowerController.stream;

  /*userFollowing*/
  final StreamController<List<UserProfile>> userFollowingController =
      BehaviorSubject<List<UserProfile>>();
  Stream<List<UserProfile>> get userFollowingPerPageStream =>
      userFollowingController.stream;

  String checker, unfollow_checker;
  int counter;

  List<UserProfile> page_data,
      page_data_2,
      user_follow_data,
      user_following_data;

  handleFollowUser({String my_id, String user_id, BuildContext context}) async {
    checker = await toggle_follow_user(
        my_id: my_id, user_id: user_id, context: context);
    toggleFollowController.sink.add(checker);

    return checker;
  }

  handleMyFollowerCounter(String my_id) async {
    counter = await count_my_followers(my_id);
    return counter;
  }

  handleMyFollowingCounter(String my_id) async {
    counter = await count_my_followers(my_id);
    return counter;
  }

  /*My Follower*/
  my_followerPerPage(int perPage, String my_id) async {
    page_data = await getAllUserFollowersByPage(perPage, my_id);
    followerController.sink.add(page_data);
  }

  my_followerHandleListenPerPage(List<UserProfile> users_profile) {
    page_data.addAll(users_profile);
    followerController.sink.add(page_data);
  }

  my_followerHandleListenRefresh(List<UserProfile> users_profile) {
    page_data.clear();
    page_data.addAll(users_profile);
    followerController.sink.add(users_profile);
  }

  /*My Following*/
  my_followingPerPage(int perPage, String my_id) async {
    page_data_2 = await getAllUserFollowingByPage(perPage, my_id);
    followingController.sink.add(page_data_2);
  }

  my_followingHandleListenPerPage(List<UserProfile> users_profile) {
    page_data_2.addAll(users_profile);
    followingController.sink.add(page_data_2);
  }

  my_followingHandleListenRefresh(List<UserProfile> users_profile) {
    page_data_2.clear();
    page_data_2.addAll(users_profile);
    followingController.sink.add(users_profile);
  }

  /*User Follower*/
  user_followerPerPage(int perPage, String my_id, String user_id) async {
    user_follow_data =
        await getAll_Dis_UserFollowersByPage(perPage, my_id, user_id);
    userFollowerController.sink.add(user_follow_data);
  }

  user_followerHandleListenPerPage(List<UserProfile> users_profile) {
    user_follow_data.addAll(users_profile);
    userFollowerController.sink.add(user_follow_data);
  }

  user_followerHandleListenRefresh(List<UserProfile> users_profile) {
    user_follow_data.clear();
    user_follow_data.addAll(users_profile);
    userFollowerController.sink.add(users_profile);
  }

  /*User Following*/
  user_followingPerPage(int perPage, String my_id, String user_id) async {
    user_following_data =
        await getAll_Dis_UserFollowingByPage(perPage, my_id, user_id);
    userFollowingController.sink.add(user_following_data);
  }

  user_followingHandleListenPerPage(List<UserProfile> users_profile) {
    user_following_data.addAll(users_profile);
    userFollowingController.sink.add(user_following_data);
  }

  user_followingHandleListenRefresh(List<UserProfile> users_profile) {
    user_following_data.clear();
    user_following_data.addAll(users_profile);
    userFollowingController.sink.add(users_profile);
  }

  @override
  void dispose() {
    toggleFollowController.close();
    followerController.close();
    followingController.close();
    userFollowerController.close();
    userFollowingController.close();
  }
}
