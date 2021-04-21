import 'package:flutter/material.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:wow/blocs/bloc_provider.dart';
import 'package:wow/blocs/forum_bloc.dart';
import 'package:wow/model/ForumComment.dart';
import 'package:wow/screen/forum_make_comment.dart';
import 'package:wow/services/ApiService.dart';
import 'package:wow/utils.dart';
import 'package:wow/widget/forum_comment_widget.dart';
import 'package:wow/widget/forum_detail_widget.dart';

class ForumDetailScreen extends StatefulWidget {
  static const String id = 'forum_detail_screen';
  String pick_id;
  String imageName;
  String forumTitle;
  String forumDesc;
  String comment_counter;
  String author;
  String authorImg;
  String time_ago;

  // ForumBloc forumBloc;

  ForumDetailScreen({
    this.pick_id,
    this.imageName,
    this.forumTitle,
    this.forumDesc,
    this.comment_counter,
    this.author,
    this.authorImg,
    this.time_ago,
    //this.forumBloc,
  });

  @override
  _ForumDetailScreenState createState() => _ForumDetailScreenState();
}

class _ForumDetailScreenState extends State<ForumDetailScreen> {
  //block start
  final forumBloc = ForumBloc();

  ScrollController _controller;
  int current_page = 1;
  bool isLoading = false;

  @override
  void initState() {
    forumBloc.getCommentByIdnPage(widget.pick_id, current_page);
    _controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page++;
      });

      // Future.delayed(new Duration(seconds: 4), () {
      getForumCommentByIdnPerPage(widget.pick_id, current_page)
          .then((value) => {
                forumBloc.handleCommentListenPerPage(value),
              });

      //});
    }
  }

  Future<void> handleRefresh() async {
    setState(() {
      current_page = 1;
    });
    await getForumCommentByIdnPerPage(widget.pick_id, current_page)
        .then((value) => {
              forumBloc.handleCommentListenRefresh(value),
            });
  }

  @override
  void dispose() {
    // forumBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: btnKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
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
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: handleRefresh,
            child: SingleChildScrollView(
              controller: _controller,
              child: Column(
                children: [
                  ForumDetailWidget(
                    pick_id: widget.pick_id,
                    imageName: widget.imageName,
                    forumTitle: widget.forumTitle,
                    forumDesc: widget.forumDesc,
                    comment_counter: widget.comment_counter,
                    authorImg: widget.authorImg,
                    author: widget.author,
                    time_ago: widget.time_ago,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 5.0,
                              bottom: 25.0,
                            ),
                            child: Text(
                              '${widget.comment_counter} Comment',
                              style: TextStyle(
                                fontSize: 20.0,
                                height: 2,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 5.0,
                              bottom: 25.0,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ForumMakeComment(
                                        pick_id: widget.pick_id,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                'Make Comment',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  height: 2,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Divider(
                              height: 1.0,
                              color: Colors.black12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                          top: 5.0,
                          bottom: 5.0,
                        ),
                        child: StreamBuilder<List<ForumComment>>(
                          stream: forumBloc.allForumComment,
                          builder: (context,
                              AsyncSnapshot<List<ForumComment>> snapshot) {
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
                                  if (snapshot.data[index].comId == null ||
                                      snapshot.data[index].comId == '') {
                                    return Container();
                                  }
                                  return ForumCommentWidget(
                                    com_id: snapshot.data[index].comId,
                                    com_author: snapshot.data[index].comAuthor,
                                    com_body: snapshot.data[index].comBody,
                                    com_time: snapshot.data[index].comTime,
                                    com_authorImg:
                                        'https://writestylesonline.com/wp-content/uploads/2021/02/Michele-Round-Circle-2020.png',
                                  );
                                },
                              );
                            } else if (snapshot.hasError) {
                              return _buildErrorWidget(snapshot.error);
                            } else {
                              return _buildLoadingWidget();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 80.0,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ForumMakeComment(
                          pick_id: widget.pick_id,
                        );
                      },
                    ),
                  );
                },
                child: Card(
                  elevation: 9,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Make Comment',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
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
