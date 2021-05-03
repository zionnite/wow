import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/story_view.dart';
import 'package:wow/blocs/StoryBloc.dart';
import 'package:wow/model/StoriesStatus.dart';
import 'package:wow/screen/send_private_message.dart';

class StoryScreen extends StatefulWidget {
  static const String id = 'story_screen';
  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  final StoryController controller = StoryController();

  bool story_quide;

  _initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isStoryQuide = prefs.getBool('storyQuide');

    setState(() {
      story_quide = isStoryQuide;
    });
  }

  @override
  void initState() {
    _initUserDetail();
  }

  Color colorCode = Colors.deepPurpleAccent;
  final Random random = Random();
  generateRandomColor() {
    Color tempColor = Color.fromARGB(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );

    setState(() {
      colorCode = tempColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'W.O.W Stories',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: (story_quide == null) ? defaultStory() : MoreStories(),
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
                StoryItem.text(
                  title: title,
                  backgroundColor: Colors.deepPurple,
                  textStyle: TextStyle(
                    fontFamily: 'NerkoOne',
                    fontSize: 40,
                  ),
                ),
              );
            } else if (type == 'image') {
              storyViews.add(
                StoryItem.pageImage(
                  url: url,
                  controller: storyController,
                  caption: caption,
                ),
              );
            }
          }

          return StoryView(
            storyItems: storyViews,
            onStoryShow: (s) {
              //print("Showing a story");
              //generateRandomColor();
            },
            onComplete: () {
              Navigator.pushNamed(context, SendPrivateMessage.id);
            },
            progressPosition: ProgressPosition.top,
            repeat: false,
            controller: storyController,
            onVerticalSwipeComplete: (direction) {
              if (direction == Direction.up) {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  Navigator.pushNamed(context, SendPrivateMessage.id);
                }
              }
            },
          );
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
          Text(
            'Loading Stories...',
            style: TextStyle(
              fontSize: 14.0,
              fontFamily: 'NerkoOne',
            ),
          )
        ],
      ),
    );
  }
}

class defaultStory extends StatefulWidget {
  @override
  _defaultStoryState createState() => _defaultStoryState();
}

class _defaultStoryState extends State<defaultStory> {
  final mystoryController = StoryController();

  @override
  void dispose() {
    mystoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryView(
        storyItems: [
          StoryItem.text(
            title: "Welcome New User",
            backgroundColor: Colors.blue,
            textStyle: TextStyle(
              fontFamily: 'NerkoOne',
              fontSize: 40,
            ),
          ),
          StoryItem.text(
            title: "You are Seeing this, because this is your first time here",
            backgroundColor: Colors.red,
            textStyle: TextStyle(
              fontFamily: 'NerkoOne',
              fontSize: 40,
            ),
          ),
          StoryItem.text(
            title:
                "Story are shown here and it automatically disappear after 7days",
            backgroundColor: Colors.deepPurple,
            textStyle: TextStyle(
              fontFamily: 'NerkoOne',
              fontSize: 40,
            ),
          ),
          StoryItem.text(
            title: "Slide Up To Send Us a Message",
            backgroundColor: Colors.brown,
            textStyle: TextStyle(
              fontFamily: 'NerkoOne',
              fontSize: 40,
            ),
          ),
          StoryItem.pageImage(
            url:
                "https://osherwomen.com/gallary/images/c5aa3140d0ae78a665e34cfb63bdff61.jpg",
            caption: "We are excited to meet you",
            controller: mystoryController,
          ),
          StoryItem.pageImage(
            url:
                "https://osherwomen.com/gallary/images/4382b94d01e1f9904f4f35837298aea5.jpg",
            controller: mystoryController,
          ),
        ],
        onStoryShow: (s) {},
        onComplete: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('storyQuide', true);
          Navigator.pushNamed(context, SendPrivateMessage.id);
        },
        progressPosition: ProgressPosition.top,
        repeat: false,
        controller: mystoryController,
        onVerticalSwipeComplete: (direction) {
          if (direction == Direction.up) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushNamed(context, SendPrivateMessage.id);
            }
          }
        },
      ),
    );
  }
}
