import 'package:flutter/material.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  String user_id;
  String user_name;
  String full_name;
  String sex;
  String age;
  String phone_no;
  String user_img;
  int following;
  int followers;
  bool iFollow;

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
    this.user_id,
    this.user_name,
    this.full_name,
    this.sex,
    this.age,
    this.phone_no,
    this.user_img,
    this.following,
    this.followers,
    this.iFollow,
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

  String my_id, my_full_name, my_email, my_image;

  _initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isUserLogin = prefs.getBool('isUserLogin');
    var user_id = prefs.getString('user_id');
    var user_full_name = prefs.getString('full_name');
    var user_email = prefs.getString('email');
    var user_img = prefs.getString('user_img');

    setState(() {
      my_id = user_id;
      my_full_name = user_full_name;
      my_email = user_email;
      my_image = user_img;
    });
  }

  @override
  void initState() {
    forumBloc.getCommentByIdnPage(widget.pick_id, current_page, my_id);
    _controller = ScrollController()..addListener(_scrollListener);
    _initUserDetail();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page++;
      });

      // Future.delayed(new Duration(seconds: 4), () {
      getForumCommentByIdnPerPage(widget.pick_id, current_page, my_id)
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
    await getForumCommentByIdnPerPage(widget.pick_id, current_page, my_id)
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
                    user_id: widget.user_id,
                    user_name: widget.user_name,
                    user_img: widget.user_img,
                    full_name: widget.full_name,
                    sex: widget.sex,
                    age: widget.age,
                    phone_no: widget.phone_no,
                    following: widget.following,
                    followers: widget.followers,
                    iFollow: widget.iFollow,
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
                                    forum_id: widget.pick_id,
                                    com_id: snapshot.data[index].comId,
                                    com_author: snapshot.data[index].comAuthor,
                                    com_body: snapshot.data[index].comBody,
                                    com_time: snapshot.data[index].comTime,
                                    com_authorImg: snapshot.data[index].userImg,
                                    user_id: snapshot.data[index].userId,
                                    user_name: snapshot.data[index].userName,
                                    user_img: snapshot.data[index].userImg,
                                    full_name: snapshot.data[index].fullName,
                                    followers: snapshot.data[index].followers,
                                    following: snapshot.data[index].following,
                                    iFollow: snapshot.data[index].iFollow,
                                    age: snapshot.data[index].age,
                                    sex: snapshot.data[index].sex,
                                    phone_no: snapshot.data[index].phoneNo,
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
