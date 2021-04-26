import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:wow/blocs/bloc_provider.dart';
import 'package:wow/model/UserProfile.dart';
import 'package:wow/services/ApiService.dart';

class UserBloc implements BlocBase {
  final StreamController<List<UserProfile>> userController =
      BehaviorSubject<List<UserProfile>>();
  Stream<List<UserProfile>> get perPageStream => userController.stream;

  List<UserProfile> page_data;

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
    userController.sink.add(page_data);
    // TODO : COME HERE,THIS PLACE MIGHT GIVE US EERROR LATER
  }

  @override
  void dispose() {
    userController.close();
  }
}
