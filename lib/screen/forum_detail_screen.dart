import 'package:flutter/material.dart';
import 'package:wow/blocs/bloc_provider.dart';
import 'package:wow/blocs/forum_bloc.dart';
import 'package:wow/model/ForumComment.dart';
import 'package:wow/screen/forum_make_comment.dart';
import 'package:wow/utils.dart';
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
  var forumBloc = ForumBloc();

  @override
  void initState() {
    forumBloc.getCommentById(widget.pick_id);
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
          SingleChildScrollView(
            child: Column(
              children: [
                ForumDetailWidget(
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
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
                                  return Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'No comment yet, be the first to comment!',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return Card(
                                  elevation: 3,
                                  color: Colors.white70,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          snapshot.data[index].comBody,
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            height: 2,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              snapshot.data[index].comAuthor,
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                height: 2,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20.0,
                                            ),
                                            Text(
                                              snapshot.data[index].comTime,
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                height: 2,
                                                color: Colors.red.shade400,
                                                fontWeight: FontWeight.w100,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
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
