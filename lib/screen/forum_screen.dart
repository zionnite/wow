import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:wow/blocs/bloc_provider.dart';
import 'package:wow/blocs/forum_bloc.dart';
import 'package:wow/model/Forum.dart';
import 'package:wow/screen/forum_make_post.dart';
import 'package:wow/screen/send_private_message.dart';
import 'package:wow/services/ApiService.dart';
import 'package:wow/utils.dart';
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
  final forumBloc = ForumBloc();
  // ForumBloc forumBloc;

  ScrollController _controller;
  int current_page = 1;
  bool isLoading = false;

  @override
  void initState() {
    // forumBloc = BlocProvider.of<ForumBloc>(context);

    forumBloc.forumPerPage(current_page);
    _controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page++;
      });

      // Future.delayed(new Duration(seconds: 4), () {
      getAllForumPerPage(current_page).then((value) => {
            forumBloc.handleListenPerPage(value),
          });

      //});
    }
  }

  Future<void> handleRefresh() async {
    setState(() {
      current_page = 1;
    });
    await getAllForumPerPage(current_page).then((value) => {
          forumBloc.handleListenRefresh(value),
        });
  }

  @override
  void dispose() {
    //forumBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: handleRefresh,
        child: SingleChildScrollView(
          controller: _controller,
          child: Column(
            children: [
              appTitleWidget(
                title: 'Forum',
                toNav: Nav.id,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, top: 20.0),
                child: Text(
                  'Scroll Down for More!',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_downward_rounded,
                  color: Colors.black,
                  size: 40.0,
                ),
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
                        'Click here to tell your Story!',
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
                    stream: forumBloc.perPageStream,
                    builder: (context, AsyncSnapshot<List<Forum>> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.error != null &&
                            snapshot.data.length > 0) {
                          return _buildErrorWidget(snapshot.error);
                        }
                        return ListView.builder(
                            physics: ClampingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              if (snapshot.data[index].id == null ||
                                  snapshot.data[index].id == '') {
                                return Container();
                              }
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ForumDetailScreen(
                                          pick_id: snapshot.data[index].id,
                                          imageName: snapshot.data[index].image,
                                          forumTitle:
                                              snapshot.data[index].title,
                                          forumDesc: snapshot.data[index].desc,
                                          comment_counter: snapshot
                                              .data[index].commentCounter,
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
                                  pick_id: snapshot.data[index].id,
                                  imageName: snapshot.data[index].image,
                                  quoteTitle: snapshot.data[index].title,
                                  quoteDesc: snapshot.data[index].desc,
                                  comment_counter:
                                      snapshot.data[index].commentCounter,
                                  author: snapshot.data[index].author,
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
      ),
      floatingActionButton: DraggableFab(
        child: FloatingActionButton(
          backgroundColor: firstColor,
          onPressed: () {
            Navigator.pushNamed(context, SendPrivateMessage.id);
          },
          child: Icon(
            Icons.message,
          ),
        ),
      ),
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
