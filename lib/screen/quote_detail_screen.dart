import 'package:flutter/material.dart';
import 'package:wow/widget/appBarCustomize.dart';
import 'package:wow/widget/app_title_widget.dart';
import 'package:wow/widget/quote_detail_widget.dart';

class QuoteDetailScreen extends StatefulWidget {
  static const String id = 'quote_detail_screen';
  @override
  _QuoteDetailScreenState createState() => _QuoteDetailScreenState();
}

class _QuoteDetailScreenState extends State<QuoteDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // appTitleWidget(
              //   title: '',
              //   toNav: null,
              // ),
              QuoteDetailWidget(
                imageName:
                    'https://miro.medium.com/max/2400/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
                quoteTitle: 'Does True Love Exist',
                quoteDesc:
                    'From our Reserch, we can perfectly say that true love exist',
                author: 'Zionnite',
                authorImg:
                    'https://miro.medium.com/max/2400/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
                isBackgroundLink: 'true',
                backgroundLink: 'http://facebook.com/nosakhare.endurance.7/',
                time_ago: '12hrs ago',
                type: 'Pain',
              ),
            ],
          ),
        ));
  }
}
