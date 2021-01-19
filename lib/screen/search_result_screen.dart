import 'package:flutter/material.dart';
import 'package:wow/blocs/forum_bloc.dart';
import 'package:wow/model/Forum.dart';
import 'package:wow/services/ApiService.dart';
import 'package:wow/utils.dart';
import 'package:wow/widget/forum_widget.dart';

import 'forum_detail_screen.dart';

class ResultSearchScreen extends StatefulWidget {
  String searchTerm;

  ResultSearchScreen({this.searchTerm});

  @override
  _ResultSearchScreenState createState() => _ResultSearchScreenState();
}

class _ResultSearchScreenState extends State<ResultSearchScreen> {
  final forumBloc = ForumBloc();

  ScrollController _controller;
  int current_page = 10;
  bool isLoading = false;
  @override
  void initState() {
    forumBloc.searchForum(widget.searchTerm, current_page);
    _controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page++;
      });

      // Future.delayed(new Duration(seconds: 4), () {
      searchForumPostByPage(widget.searchTerm, current_page).then((value) => {
            forumBloc.handleSearchListenPerPage(value),
          });

      //});
    }
  }

  Future<void> handleRefresh() async {
    setState(() {
      current_page = 1;
    });
    await searchForumPostByPage(widget.searchTerm, current_page)
        .then((value) => {
              forumBloc.handleSearchListenRefresh(value),
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
      appBar: AppBar(
        title: Text(
          'Result Page',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: firstColor,
        leading: InkWell(
          onTap: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.popAndPushNamed(context, null);
            }
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: handleRefresh,
        child: SingleChildScrollView(
          controller: _controller,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3),
                child: Text(
                  'Result search for ("${widget.searchTerm}")',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: StreamBuilder<List<Forum>>(
                    stream: forumBloc.searchStream,
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
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Could not search for more data',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                );
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
