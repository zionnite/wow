import 'package:flutter/material.dart';
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

  ForumDetailScreen({
    this.pick_id,
    this.imageName,
    this.forumTitle,
    this.forumDesc,
    this.comment_counter,
    this.author,
    this.authorImg,
    this.time_ago,
  });

  @override
  _ForumDetailScreenState createState() => _ForumDetailScreenState();
}

class _ForumDetailScreenState extends State<ForumDetailScreen> {
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
                        child: Column(
                          children: [
                            Card(
                              elevation: 3,
                              color: Colors.white70,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'i love the work christ has set for me i love the work christ has set for me i love the work christ has set for me i love the work christ has set for me i love the work christ has set for me ',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        height: 2,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '2hrs ago',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        height: 2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              elevation: 3,
                              color: Colors.white70,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'i love the work christ has set for me i love the work christ has set for me i love the work christ has set for me i love the work christ has set for me i love the work christ has set for me ',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        height: 2,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '2hrs ago',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        height: 2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              elevation: 3,
                              color: Colors.white70,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'i love the work christ has set for me i love the work christ has set for me i love the work christ has set for me i love the work christ has set for me i love the work christ has set for me ',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        height: 2,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '2hrs ago',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        height: 2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              elevation: 3,
                              color: Colors.white70,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'i love the work christ has set for me i love the work christ has set for me i love the work christ has set for me i love the work christ has set for me i love the work christ has set for me ',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        height: 2,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '2hrs ago',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        height: 2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
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
}
