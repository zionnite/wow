import 'package:flutter/material.dart';
import 'package:wow/screen/quote_detail_screen.dart';
import 'package:wow/widget/app_title_widget.dart';
import 'package:wow/widget/quote_widget.dart';

import '../bottom_navigation.dart';

class QuoteScreen extends StatefulWidget {
  static const String id = 'quote_screen';
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            appTitleWidget(
              title: 'Quote',
              toNav: Nav.id,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, QuoteDetailScreen.id);
              },
              child: QuoteWidget(
                imageName:
                    'https://miro.medium.com/max/2400/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
                quoteTitle: 'Forum Testing',
                quoteDesc: 'just another testing',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
