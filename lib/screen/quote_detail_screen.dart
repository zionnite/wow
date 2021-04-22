import 'package:flutter/material.dart';
import 'package:wow/widget/quote_detail_widget.dart';

class QuoteDetailScreen extends StatefulWidget {
  static const String id = 'quote_detail_screen';
  final String image_Name,
      quote_Title,
      quote_Desc,
      author_name,
      author_Img,
      isBackground_Link,
      background_Link,
      timer_ago,
      dis_type,
      quote_id;
  QuoteDetailScreen({
    this.image_Name,
    this.quote_Title,
    this.quote_Desc,
    this.author_name,
    this.author_Img,
    this.isBackground_Link,
    this.background_Link,
    this.timer_ago,
    this.dis_type,
    this.quote_id,
  });

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
              QuoteDetailWidget(
                quote_id: widget.quote_id,
                imageName: widget.image_Name,
                quoteTitle: widget.quote_Title,
                quoteDesc: widget.quote_Desc,
                author: widget.author_name,
                authorImg: widget.author_Img,
                isBackgroundLink: widget.isBackground_Link,
                backgroundLink: widget.background_Link,
                time_ago: widget.timer_ago,
                type: widget.dis_type,
              ),
            ],
          ),
        ));
  }
}
