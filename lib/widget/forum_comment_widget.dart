import 'package:flutter/material.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wow/blocs/forum_bloc.dart';
import 'package:wow/screen/view_user_profile_screen.dart';
import 'package:wow/utils.dart';

class ForumCommentWidget extends StatefulWidget {
  String com_id;
  String com_author;
  String com_authorImg;
  String com_body;
  String com_time;
  String forum_id;
  String commenter_id;
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

  ForumCommentWidget({
    this.com_id,
    this.com_author,
    this.com_authorImg,
    this.com_body,
    this.com_time,
    this.forum_id,
    this.commenter_id,
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
  _ForumCommentWidgetState createState() => _ForumCommentWidgetState();
}

class _ForumCommentWidgetState extends State<ForumCommentWidget> {
  GlobalKey btnKey = GlobalKey();
  GlobalKey btnKey2 = GlobalKey();
  GlobalKey btnKey3 = GlobalKey();

  var selected_id;
  var selected_menu;
  var selected_author;
  var selected_key;

  final forumBloc = ForumBloc();

  String my_id, my_full_name, my_email, my_image, user;

  _initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isUserLogin = prefs.getBool('isUserLogin');
    var user_id = prefs.getString('user_id');
    var user_full_name = prefs.getString('full_name');
    var user_email = prefs.getString('email');
    var user_img = prefs.getString('user_img');

    setState(() {
      user = user_id;
      my_full_name = user_full_name;
      my_email = user_email;
      my_image = user_img;
    });
  }

  @override
  void initState() {
    super.initState();
    _initUserDetail();
  }

  _showModalBottomSheetReport(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 600.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: Text(
                    'Please select a Problem',
                    style: TextStyle(
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: [
                        InkWell(
                          onTap: () async {
                            await forumBloc.handleCommentProblemReporting(
                              id: widget.com_id,
                              user: user,
                              report_type: 'nudity',
                              forum_id: widget.forum_id,
                              context: context,
                            );
                            Navigator.pop(context);
                          },
                          child: Card(
                            elevation: 4.0,
                            color: Colors.redAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 5.0,
                                ),
                                height: 30.0,
                                width: double.infinity,
                                child: Text(
                                  'Nudity',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await forumBloc.handleCommentProblemReporting(
                              id: widget.com_id,
                              user: user,
                              report_type: 'violence',
                              forum_id: widget.forum_id,
                              context: context,
                            );
                            Navigator.pop(context);
                          },
                          child: Card(
                            elevation: 4.0,
                            color: Colors.redAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 5.0,
                                ),
                                height: 30.0,
                                width: double.infinity,
                                child: Text(
                                  'Violence',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await forumBloc.handleCommentProblemReporting(
                              id: widget.com_id,
                              user: user,
                              report_type: 'harassment',
                              forum_id: widget.forum_id,
                              context: context,
                            );
                            Navigator.pop(context);
                          },
                          child: Card(
                            elevation: 4.0,
                            color: Colors.redAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 5.0,
                                ),
                                height: 30.0,
                                width: double.infinity,
                                child: Text(
                                  'Harassment',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await forumBloc.handleCommentProblemReporting(
                              id: widget.com_id,
                              user: user,
                              report_type: 'suicide_or_self_injury',
                              forum_id: widget.forum_id,
                              context: context,
                            );
                            Navigator.pop(context);
                          },
                          child: Card(
                            elevation: 4.0,
                            color: Colors.redAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 5.0,
                                ),
                                height: 30.0,
                                width: double.infinity,
                                child: Text(
                                  'Suicide or Self-injury',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await forumBloc.handleCommentProblemReporting(
                              id: widget.com_id,
                              user: user,
                              report_type: 'false_information',
                              forum_id: widget.forum_id,
                              context: context,
                            );
                            Navigator.pop(context);
                          },
                          child: Card(
                            elevation: 4.0,
                            color: Colors.redAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 5.0,
                                ),
                                height: 30.0,
                                width: double.infinity,
                                child: Text(
                                  'False Information',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await forumBloc.handleCommentProblemReporting(
                              id: widget.com_id,
                              user: user,
                              report_type: 'hate_speech',
                              forum_id: widget.forum_id,
                              context: context,
                            );
                            Navigator.pop(context);
                          },
                          child: Card(
                            elevation: 4.0,
                            color: Colors.redAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 5.0,
                                ),
                                height: 30.0,
                                width: double.infinity,
                                child: Text(
                                  'Hate Speech',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await forumBloc.handleCommentProblemReporting(
                              id: widget.com_id,
                              user: user,
                              report_type: 'spam',
                              forum_id: widget.forum_id,
                              context: context,
                            );
                            Navigator.pop(context);
                          },
                          child: Card(
                            elevation: 4.0,
                            color: Colors.redAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 5.0,
                                ),
                                height: 30.0,
                                width: double.infinity,
                                child: Text(
                                  'Spam',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  _showModalBottomSheetBlockUser(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 250.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Are you sure you want to Block this User',
                        style: TextStyle(
                          fontSize: 23.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '(${selected_author})?',
                        style: TextStyle(
                          fontSize: 23.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          'If you block this User, you won\'t be able to see this user comment',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      elevation: 4,
                      color: Colors.redAccent,
                      child: Text(
                        'No, Cancel',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: 'Raleway',
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        await forumBloc.handleCommentBlockUser(
                          id: widget.com_id,
                          user: user,
                          context: context,
                        );
                        Navigator.pop(context);
                      },
                      elevation: 4,
                      color: Colors.green,
                      child: Text(
                        'Yes, Continue',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: 'Raleway',
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  _showModalBottomSheetDeletePost(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Are you sure you want to Delete this Comment?',
                        style: TextStyle(
                          fontSize: 23.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'If you delete this Comment, you won\'t see it again',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      elevation: 4,
                      color: Colors.redAccent,
                      child: Text(
                        'No, Cancel',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: 'Raleway',
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        await forumBloc.handleDeleteComment(
                          id: widget.com_id,
                          user: user,
                          context: context,
                          forum_id: widget.forum_id,
                        );
                        Navigator.pop(context);
                      },
                      elevation: 4,
                      color: Colors.green,
                      child: Text(
                        'Yes, Continue',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: 'Raleway',
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              top: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ViewUserProfileScreen(
                            user_id: widget.user_id,
                            user_name: widget.user_name,
                            user_img: widget.user_img,
                            full_name: widget.full_name,
                            sex: widget.sex,
                            age: widget.age,
                            phone_no: widget.phone_no,
                            following_count: widget.following,
                            follower_count: widget.followers,
                            iFollow: widget.iFollow,
                          );
                        },
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundColor: firstColor,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.com_authorImg),
                      radius: 48.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ViewUserProfileScreen(
                              user_id: widget.user_id,
                              user_name: widget.user_name,
                              user_img: widget.user_img,
                              full_name: widget.full_name,
                              sex: widget.sex,
                              age: widget.age,
                              phone_no: widget.phone_no,
                              following_count: widget.following,
                              follower_count: widget.followers,
                              iFollow: widget.iFollow,
                            );
                          },
                        ),
                      );
                    },
                    child: Text(
                      widget.com_author,
                      style: TextStyle(
                        fontSize: 20.0,
                        height: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_vert_outlined,
                    size: 30,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    popUpComment();
                    setState(() {
                      selected_id = widget.com_id;
                      selected_author = widget.com_author;
                    });
                  },
                  key: btnKey,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.com_body,
              style: TextStyle(
                fontSize: 20.0,
                height: 2,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              widget.com_time,
              style: TextStyle(
                fontSize: 20.0,
                height: 2,
                color: Colors.red.shade400,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void popUpComment() {
    PopupMenu commentMenu = PopupMenu(
      context: context,
      // backgroundColor: Colors.grey,
      // lineColor: Colors.tealAccent,
      maxColumn: 3,
      items: [
        MenuItem(
          title: 'Report',
          image: Icon(
            Icons.warning_amber_rounded,
            color: Colors.white,
          ),
        ),
        MenuItem(
          title: 'Block User',
          image: Icon(
            Icons.block_rounded,
            color: Colors.white,
          ),
        ),
        MenuItem(
          title: 'Delete',
          image: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ],
      onClickMenu: onClickMenu,
      stateChanged: stateChanged,
      onDismiss: onDismiss,
    );
    commentMenu.show(widgetKey: btnKey);
  }

  onClickMenu(MenuItemProvider item) {
    // print('Click menu -> ${item.menuTitle}');
    if (item.menuTitle == 'Report') {
      setState(() {
        selected_menu = 'report';
        _showModalBottomSheetReport(context);
      });
    } else if (item.menuTitle == 'Delete') {
      setState(() {
        selected_menu = 'delete';
        _showModalBottomSheetDeletePost(context);
      });
    } else if (item.menuTitle == 'Block User') {
      setState(() {
        selected_menu = 'block';
        _showModalBottomSheetBlockUser(context);
      });
    }
    //print('Quote Id => $selected_id');
    // print('Quote Name => $selected_menu');
    // print('Quote Name => $selected_author');
    //perform Operation to QuoteBloc
  }

  void onDismiss() {
    //print('Menu is dismiss');
  }

  stateChanged(bool isShow) {
    //print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  void checkState(BuildContext context) {
    final snackBar = new SnackBar(content: new Text('这是一个SnackBar!'));

    Scaffold.of(context).showSnackBar(snackBar);
  }
}
