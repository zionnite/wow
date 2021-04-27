import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/story_view.dart';
import 'package:wow/blocs/StoryBloc.dart';
import 'package:wow/bottom_navigation.dart';
import 'package:wow/model/StoriesStatus.dart';
import 'package:wow/screen/send_private_message.dart';

class StoryScreen extends StatefulWidget {
  static const String id = 'story_screen';
  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  final StoryController controller = StoryController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('W.O.W Stories'),
      ),
      body: MoreStories(),
    );
  }
}

class MoreStories extends StatefulWidget {
  @override
  _MoreStoriesState createState() => _MoreStoriesState();
}

class _MoreStoriesState extends State<MoreStories> {
  final storyBloc = StoryBloc();
  final storyController = StoryController();

  List<StoryItem> storyViews = [];
  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<StoriesStatus>>(
      stream: storyBloc.storyStream,
      builder: (context, AsyncSnapshot<List<StoriesStatus>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.error != null && snapshot.data.length > 0) {
            return _buildErrorWidget(snapshot.error);
          }
          for (var story in snapshot.data) {
            var type = story.type;
            var title = story.title;
            var caption = story.caption;
            var url = story.url;
            var bgColor = story.bgColor;
            var time = story.title;
            var date = story.date;

            if (type == 'text') {
              storyViews.add(
                  StoryItem.text(title: title, backgroundColor: Colors.red));
            } else if (type == 'image') {
              storyViews.add(StoryItem.pageImage(
                  url: url, controller: storyController, caption: caption));
            }
          }

          return StoryView(
              storyItems: storyViews,
              onStoryShow: (s) {
                //print("Showing a story");
              },
              onComplete: () {
                Navigator.popAndPushNamed(context, SendPrivateMessage.id);
              },
              progressPosition: ProgressPosition.top,
              repeat: false,
              controller: storyController,
              onVerticalSwipeComplete: (direction) {
                if (direction == Direction.up) {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    Navigator.popAndPushNamed(context, SendPrivateMessage.id);
                  }
                }
              });
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occurred: $error"),
      ],
    ));
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
