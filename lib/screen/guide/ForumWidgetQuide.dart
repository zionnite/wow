import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wow/blocs/forum_bloc.dart';
import 'package:wow/screen/terms_n_condition.dart';
import 'package:wow/utils.dart';

import '../users_screen.dart';

class ForumWidgetQuide extends StatefulWidget {
  String pick_id;
  String imageName;
  String quoteTitle;
  String quoteDesc;
  String comment_counter;
  String author;

  ForumWidgetQuide({
    this.pick_id,
    this.imageName,
    this.quoteTitle,
    this.quoteDesc,
    this.comment_counter,
    this.author,
  });

  @override
  _ForumWidgetQuideState createState() => _ForumWidgetQuideState();
}

class _ForumWidgetQuideState extends State<ForumWidgetQuide> {
  PopupMenu menu;
  GlobalKey btnKey = GlobalKey();
  GlobalKey btnKey2 = GlobalKey();
  GlobalKey btnKey3 = GlobalKey();
  var selected_id;
  var selected_menu;

  String author;
  String authorImg;
  String time_ago;

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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(9.0),
        ),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 2.0,
        vertical: 9.0,
      ),
      height: 600.0,
      width: double.infinity,
      child: Card(
        elevation: 5.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
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
                widget.quoteTitle,
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
                bottom: 5.0,
                right: 8.0,
              ),
              child: SelectableLinkify(
                onOpen: _onOpen,
                text: this.widget.quoteDesc,
                style: TextStyle(
                  fontSize: 17.0,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Oxygen',
                ),
                //maxLines: 5,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('forumQuide', true);
                      Navigator.popAndPushNamed(context, UsersScreen.id);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 10.0, bottom: 10),
                      child: Text(
                        'Ok, Understood',
                        style: TextStyle(
                          fontSize: 17.0,
                          color: firstColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Terms_N_Conditions(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 10.0, bottom: 10),
                      child: Text(
                        'See Terms & Condition',
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }
}
