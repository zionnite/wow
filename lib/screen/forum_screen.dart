import 'package:flutter/material.dart';
import 'package:wow/blocs/bloc_provider.dart';
import 'package:wow/blocs/forum_bloc.dart';
import 'package:wow/model/Forum.dart';
import 'package:wow/screen/forum_make_post.dart';
import 'package:wow/widget/app_title_widget.dart';
import 'package:wow/widget/forum_widget.dart';

import '../bottom_navigation.dart';
import 'forum_detail_screen.dart';

class ForumScreen extends StatefulWidget {
  static const String id = 'forum_screen';
  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  ForumBloc forumBloc;

  @override
  void initState() {
    forumBloc = BlocProvider.of<ForumBloc>(context);
  }

  @override
  void dispose() {
    forumBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            appTitleWidget(
              title: 'Forum',
              toNav: Nav.id,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ForumMakePost();
                      },
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(250),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 50),
                    child: Text(
                      'Create Topic',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  elevation: 5.0,
                ),
              ),
            ),
            SingleChildScrollView(
              child: StreamBuilder<List<Forum>>(
                  stream: forumBloc.allforumStream,
                  builder: (context, AsyncSnapshot<List<Forum>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.error != null && snapshot.data.length > 0) {
                        return _buildErrorWidget(snapshot.error);
                      }
                      return ListView.builder(
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ForumDetailScreen(
                                        pick_id: snapshot.data[index].id,
                                        imageName: snapshot.data[index].image,
                                        forumTitle: snapshot.data[index].title,
                                        forumDesc: snapshot.data[index].desc,
                                        comment_counter:
                                            snapshot.data[index].commentCounter,
                                        authorImg:
                                            snapshot.data[index].authorImage,
                                        author: snapshot.data[index].author,
                                        time_ago: snapshot.data[index].time,
                                        //forumBloc: forumBloc,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: ForumWidget(
                                imageName: snapshot.data[index].image,
                                quoteTitle: snapshot.data[index].title,
                                quoteDesc: snapshot.data[index].desc,
                                comment_counter:
                                    snapshot.data[index].commentCounter,
                              ),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return _buildErrorWidget(snapshot.error);
                    } else {
                      return _buildLoadingWidget();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
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
