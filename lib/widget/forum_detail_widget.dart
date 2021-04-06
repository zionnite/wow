import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils.dart';

class ForumDetailWidget extends StatefulWidget {
  String imageName;
  String forumTitle;
  String forumDesc;
  String comment_counter;
  String author;
  String authorImg;
  String time_ago;

  ForumDetailWidget({
    this.imageName,
    this.forumTitle,
    this.forumDesc,
    this.comment_counter,
    this.author,
    this.authorImg,
    this.time_ago,
  });

  @override
  _ForumDetailWidgetState createState() => _ForumDetailWidgetState();
}

class _ForumDetailWidgetState extends State<ForumDetailWidget> {
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
                Container(
                  margin: EdgeInsets.only(top: 25.0, left: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundColor: firstColor,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(widget.authorImg),
                            radius: 48.0,
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
                                Text(
                                  widget.author,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w800,
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
}
