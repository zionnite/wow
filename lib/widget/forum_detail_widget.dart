import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wow/blocs/forum_bloc.dart';
import 'package:wow/screen/view_user_profile_screen.dart';

import '../utils.dart';

class ForumDetailWidget extends StatefulWidget {
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

  ForumDetailWidget({
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
  _ForumDetailWidgetState createState() => _ForumDetailWidgetState();
}

class _ForumDetailWidgetState extends State<ForumDetailWidget> {
  PopupMenu menu;
  GlobalKey btnKey = GlobalKey();
  GlobalKey btnKey2 = GlobalKey();
  GlobalKey btnKey3 = GlobalKey();
  var selected_id;
  var selected_menu;

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
                            await forumBloc.handleProblemReporting(
                              id: widget.pick_id,
                              user: user,
                              report_type: 'nudity',
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
                            await forumBloc.handleProblemReporting(
                              id: widget.pick_id,
                              user: user,
                              report_type: 'violence',
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
                            await forumBloc.handleProblemReporting(
                              id: widget.pick_id,
                              user: user,
                              report_type: 'harassment',
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
                            await forumBloc.handleProblemReporting(
                              id: widget.pick_id,
                              user: user,
                              report_type: 'suicide_or_self_injury',
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
                            await forumBloc.handleProblemReporting(
                              id: widget.pick_id,
                              user: user,
                              report_type: 'false_information',
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
                            await forumBloc.handleProblemReporting(
                              id: widget.pick_id,
                              user: user,
                              report_type: 'hate_speech',
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
                            await forumBloc.handleProblemReporting(
                              id: widget.pick_id,
                              user: user,
                              report_type: 'spam',
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
          return SingleChildScrollView(
            child: Container(
              height: 350.0,
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
                          '(${widget.author})?',
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
                            'If you block this User, you won\'t be able to see this user post',
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 50,
                            child: Material(
                              borderRadius: BorderRadius.circular(25.0),
                              shadowColor: Colors.red.shade300,
                              color: Colors.red,
                              elevation: 7.0,
                              child: Center(
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
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () async {
                            await forumBloc.handleBlockUser(
                              id: widget.pick_id,
                              user: user,
                              context: context,
                            );
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 50,
                            child: Material(
                              borderRadius: BorderRadius.circular(25.0),
                              shadowColor: Colors.green.shade300,
                              color: Colors.green,
                              elevation: 7.0,
                              child: Center(
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
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  _showModalBottomSheetDeletePost(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              height: 350.0,
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
                          'Are you sure you want to Delete this Post?',
                          style: TextStyle(
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'If you delete this post, you won\'t see it again',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 50,
                            child: Material(
                              borderRadius: BorderRadius.circular(25.0),
                              shadowColor: Colors.red.shade300,
                              color: Colors.red,
                              elevation: 7.0,
                              child: Center(
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
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () async {
                            await forumBloc.handlePostDelete(
                              id: widget.pick_id,
                              user: user,
                              context: context,
                            );
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 50,
                            child: Material(
                              borderRadius: BorderRadius.circular(25.0),
                              shadowColor: Colors.green.shade300,
                              color: Colors.green,
                              elevation: 7.0,
                              child: Center(
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
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(9.0),
            ),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 9.0,
            vertical: 9.0,
          ),
          width: double.infinity,
          child: Card(
            elevation: 5.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      child: CachedNetworkImage(
                        imageUrl: widget.imageName,
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                        fadeInDuration: Duration(milliseconds: 500),
                        fadeInCurve: Curves.easeIn,
                        placeholder: (context, progressText) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10.0,
                      right: 5.0,
                      child: IconButton(
                        icon: Icon(
                          Icons.more_vert_outlined,
                          size: 40,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          maxColumn(widget.pick_id);
                          setState(() {
                            selected_id = widget.pick_id;
                          });
                        },
                        key: btnKey,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 25.0, left: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        child: Container(
                          child: CircleAvatar(
                            radius: 50.0,
                            backgroundColor: firstColor,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(widget.authorImg),
                              radius: 48.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Column(
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
                                            user_name: widget.author,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Text(
                                    widget.author,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  widget.time_ago,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    top: 18.0,
                    bottom: 10.0,
                  ),
                  child: Text(
                    widget.forumTitle,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
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
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    top: 5.0,
                    bottom: 25.0,
                    right: 8.0,
                  ),
                  child: SelectableLinkify(
                    onOpen: _onOpen,
                    text: widget.forumDesc,
                    style: TextStyle(
                      fontSize: 17.0,
                      height: 2,
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
      ],
    );
  }

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }

  void maxColumn(String id) {
    PopupMenu menu = PopupMenu(
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
    menu.show(widgetKey: btnKey);
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
    //perform Operation to QuoteBloc
  }

  void onDismiss() {
    // print('Menu is dismiss');
  }

  stateChanged(bool isShow) {
    // print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  void checkState(BuildContext context) {
    final snackBar = new SnackBar(content: new Text('这是一个SnackBar!'));

    Scaffold.of(context).showSnackBar(snackBar);
  }
}
