import 'package:flutter/material.dart';
import 'package:wow/blocs/QouteBloc.dart';
import 'package:wow/blocs/bloc_provider.dart';
import 'package:wow/model/Category.dart';
import 'package:wow/model/Quote.dart';
import 'package:wow/screen/category_screen.dart';
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
  QuoteBloc quoteBloc;

  @override
  void initState() {
    quoteBloc = BlocProvider.of<QuoteBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    quoteBloc.dispose();
  }

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
              child: StreamBuilder<List<Category>>(
                stream: quoteBloc.categoryStream,
                builder: (context, AsyncSnapshot<List<Category>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.error != null && snapshot.data.length > 0) {
                      return _buildErrorWidget(snapshot.error);
                    }
                    return ListView.builder(
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 15.0),
                          child: GestureDetector(
                            onTap: () async {
                              QuoteBloc categories_data = await quoteBloc
                                  .getQuoteById(snapshot.data[index].catId);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return CategoryScreen(
                                      cat_id: snapshot.data[index].catId,
                                      cat_name: snapshot.data[index].catName,
                                      quoteBloc: categories_data,
                                    );
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
                                  snapshot.data[index].catName,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              elevation: 5.0,
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return _buildErrorWidget(snapshot.error);
                  } else {
                    return _buildLoadingWidget();
                  }
                },
              ),
            ),
            StreamBuilder<List<Quote>>(
              stream: quoteBloc.allQuoteStream,
              builder: (context, AsyncSnapshot<List<Quote>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.error != null && snapshot.data.length > 0) {
                    return _buildErrorWidget(snapshot.error);
                  }
                  return ListView.builder(
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return QuoteDetailScreen(
                                    image_Name: snapshot.data[index].image,
                                    quote_Title: snapshot.data[index].title,
                                    quote_Desc: snapshot.data[index].desc,
                                    author_name: snapshot.data[index].author,
                                    author_Img:
                                        snapshot.data[index].authorImage,
                                    isBackground_Link:
                                        snapshot.data[index].isBackground,
                                    background_Link:
                                        snapshot.data[index].backgroundLink,
                                    timer_ago: snapshot.data[index].time,
                                    dis_type: snapshot.data[index].type,
                                  );
                                },
                              ),
                            );
                          },
                          child: QuoteWidget(
                            imageName: snapshot.data[index].image,
                            quoteTitle: snapshot.data[index].title,
                            quoteDesc: snapshot.data[index].desc,
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  return _buildErrorWidget(snapshot.error);
                } else {
                  return _buildLoadingWidget();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
