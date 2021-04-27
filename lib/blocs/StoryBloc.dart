import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:wow/model/StoriesStatus.dart';
import 'package:wow/services/ApiService.dart';

import 'bloc_provider.dart';

class StoryBloc implements BlocBase {
  final StreamController<List<StoriesStatus>> storyController =
      BehaviorSubject<List<StoriesStatus>>();
  Stream<List<StoriesStatus>> get storyStream => storyController.stream;

  List<StoriesStatus> data;

  StoryBloc() {
    stories();
  }

  stories() async {
    data = await getAllStories();
    storyController.sink.add(data);
  }

  @override
  void dispose() {
    storyController.close();
  }
}
