import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wow/blocs/bloc_provider.dart';
import 'package:wow/blocs/forum_bloc.dart';
import 'package:wow/model/Forum.dart';
import 'package:wow/screen/forum_make_post.dart';
import 'package:wow/screen/guide/ForumWidgetQuide.dart';
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

  String my_id, my_full_name, my_email, my_image;
  bool forum_quide;

  _initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isForumQuide = prefs.getBool('forumQuide');
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
      forum_quide = isForumQuide;
    });

    forumBloc.forumPerPage(current_page, my_id);
    _controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void initState() {
    // forumBloc = BlocProvider.of<ForumBloc>(context);

    _initUserDetail();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page++;
      });

      // Future.delayed(new Duration(seconds: 4), () {
      getAllForumPerPage(current_page, my_id).then((value) => {
            forumBloc.handleListenPerPage(value),
          });

      //});
    }
  }

  Future<void> handleRefresh() async {
    setState(() {
      current_page = 1;
    });
    await getAllForumPerPage(current_page, my_id).then((value) => {
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
                    elevation: 8.0,
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
                                          user_id: snapshot.data[index].userId,
                                          user_img:
                                              snapshot.data[index].userImg,
                                          user_name:
                                              snapshot.data[index].userName,
                                          full_name:
                                              snapshot.data[index].fullName,
                                          phone_no:
                                              snapshot.data[index].phoneNo,
                                          sex: snapshot.data[index].sex,
                                          age: snapshot.data[index].age,
                                          followers:
                                              snapshot.data[index].followers,
                                          following:
                                              snapshot.data[index].following,
                                          iFollow: snapshot.data[index].iFollow,

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
              /*Display this when User is New and Needs a Quite*/
              (forum_quide == null)
                  ? ForumWidgetQuide(
                      pick_id: '11',
                      imageName:
                          'https://osherwomen.com/gallary/images/fff95f1198b8ec1874d31b73c6bfa5ac.jpg',
                      quoteTitle: 'How Forum Work',
                      quoteDesc:
                          'This Post is for you, as a guide to teach you how the forum works.\n\nYour Forum timeline is probably empty, All Posts that appear Here in your Timeline are post of USERS you FOLLOWED or the post you made but bear in mind that all post must conform to our privacy and Terms & Condition else your membership will be taken away from you.\n\nBy Registering on this App you agree to our Terms and Conditions',
                      comment_counter: '0',
                      author: 'wow App',
                    )
                  : Container(),
            ],
          ),
        ),
      ),
      // floatingActionButton: DraggableFab(
      //   child: FloatingActionButton(
      //     backgroundColor: firstColor,
      //     onPressed: () {
      //       Navigator.pushNamed(context, SendPrivateMessage.id);
      //     },
      //     child: Icon(
      //       Icons.message,
      //     ),
      //   ),
      // ),
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
