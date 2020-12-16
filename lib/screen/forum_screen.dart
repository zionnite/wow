import 'package:flutter/material.dart';
import 'package:wow/widget/app_title_widget.dart';
import 'package:wow/widget/forum_widget.dart';

import '../bottom_navigation.dart';

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
            ForumWidget(
              imageName:
                  'https://miro.medium.com/max/2400/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
              quoteTitle: 'Forum Testing',
              quoteDesc: 'just another testing',
            ),
            ForumWidget(
              imageName:
                  'https://miro.medium.com/max/2400/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
              quoteTitle: 'Forum Testing',
              quoteDesc: 'just another testing',
            ),
            ForumWidget(
              imageName:
                  'https://miro.medium.com/max/2400/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
              quoteTitle: 'Forum Testing',
              quoteDesc: 'just another testing',
            ),
          ],
        ),
      ),
    );
  }
}
