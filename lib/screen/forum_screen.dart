import 'package:flutter/material.dart';
import 'package:wow/screen/forum_make_post.dart';
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
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            appTitleWidget(
              title: 'Forum',
              toNav: Nav.id,
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
                      'Create Topic',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  elevation: 5.0,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ForumDetailScreen(
                        pick_id: '1',
                        imageName: '',
                        forumTitle: '',
                        forumDesc: '',
                        comment_counter: '',
                        authorImg: '',
                        author: '',
                        time_ago: '',
                      );
                    },
                  ),
                );
              },
              child: ForumWidget(
                imageName:
                    'https://miro.medium.com/max/2400/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
                quoteTitle: 'Forum Testing',
                quoteDesc: 'just another testing',
                comment_counter: '23',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
