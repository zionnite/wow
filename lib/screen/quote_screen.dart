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
            Text(
              'Categories',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.redAccent.shade400,
              ),
            ),
            Container(
              height: 100.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15.0),
                    child: GestureDetector(
                      onTap: () {
                        print('search clicked');
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(250),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 18.0, horizontal: 50),
                          child: Text(
                            'Pains Pains Pains',
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
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15.0),
                    child: GestureDetector(
                      onTap: () {
                        print('search clicked');
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(250),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 18.0, horizontal: 50),
                          child: Text(
                            'Grief',
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
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15.0),
                    child: GestureDetector(
                      onTap: () {
                        print('search clicked');
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(250),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 18.0, horizontal: 50),
                          child: Text(
                            'Pains',
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
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15.0),
                    child: GestureDetector(
                      onTap: () {
                        print('search clicked');
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(250),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 18.0, horizontal: 50),
                          child: Text(
                            'Grief',
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
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return QuoteDetailScreen(
                        image_Name: 'snapshot.data[index].image',
                        quote_Title: 'snapshot.data[index].title',
                        quote_Desc: 'snapshot.data[index].desc',
                        author_name: 'snapshot.data[index].author',
                        author_Img: 'snapshot.data[index].authorImage',
                        isBackground_Link: 'snapshot.data[index].isBackground',
                        background_Link: 'snapshot.data[index].backgroundLink',
                        timer_ago: 'snapshot.data[index].time',
                        dis_type: 'snapshot.data[index].type',
                      );
                    },
                  ),
                );
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
