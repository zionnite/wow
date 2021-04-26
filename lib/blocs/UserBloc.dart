import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:wow/blocs/bloc_provider.dart';
import 'package:wow/model/UserProfile.dart';
import 'package:wow/services/ApiService.dart';

class UserBloc implements BlocBase {
  final StreamController<List<UserProfile>> userController =
      BehaviorSubject<List<UserProfile>>();
  Stream<List<UserProfile>> get perPageStream => userController.stream;

  /*Search Users */
  final StreamController<List<UserProfile>> searchController =
      BehaviorSubject<List<UserProfile>>();
  Stream<List<UserProfile>> get searchStream => searchController.stream;
  /*Search Users */

  List<UserProfile> page_data, search_data;

  userPerPage(int perPage, String my_id) async {
    page_data = await getAllUsersByPage(perPage, my_id);
    userController.sink.add(page_data);
  }

  handleListenPerPage(List<UserProfile> users_profile) {
    page_data.addAll(users_profile);
    userController.sink.add(page_data);
  }

  handleListenRefresh(List<UserProfile> users_profile) {
    page_data.clear();
    page_data.addAll(users_profile);
    userController.sink.add(users_profile);
  }

  searchUsers(String search, int page, String my_id) async {
    search_data = await searchUsersByPage(search, page, my_id);
    searchController.sink.add(search_data);
  }

  handleSearchListenPerPage(List<UserProfile> users) {
    search_data.addAll(users);
    searchController.sink.add(search_data);
  }

  handleSearchListenRefresh(List<UserProfile> users) {
    search_data.clear();
    search_data.addAll(users);
    searchController.sink.add(search_data);
  }

  @override
  void dispose() {
    userController.close();
    searchController.close();
  }
}