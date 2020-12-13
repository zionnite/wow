import 'package:flutter/material.dart';
import 'package:wow/blocs/quote_bloc.dart';
import 'package:wow/model/Quote.dart';
import 'package:wow/model/model_response/quote_response.dart';

import 'package:wow/utils.dart';
import '../CustomShapeClipper.dart';
import 'forum_list_widget.dart';
import 'quote_widget.dart';

class HomeScreenTopPart extends StatefulWidget {
  @override
  _HomeScreenTopPartState createState() => _HomeScreenTopPartState();
}

class _HomeScreenTopPartState extends State<HomeScreenTopPart> {
  @override
  void initState() {
    super.initState();
    quoteBloc..getQuotes();
  }

  @override
  void dispose() {}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: CustomShapeClipper(),
                child: Container(
                  height: 450.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [firstColor, secondColor],
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70.0,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Icon(
                      //         Icons.location_on,
                      //         color: Colors.white,
                      //       ),
                      //       Icon(
                      //         Icons.settings,
                      //         color: Colors.white,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          'How can we Help You\n Today?',
                          style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.white,
                            fontFamily: 'NerkoOne',
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.0),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          child: TextField(
                            onChanged: (text) {},
                            style: dropDownMenuItemStyle,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 32.0, vertical: 14.0),
                              border: InputBorder.none,
                            ),
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
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18.0, horizontal: 50),
                              child: Text(
                                'Search',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            elevation: 5.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Trending Topic',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                        color: Colors.black12,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 8.0),
                        child: Text(
                          'View All',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 12.0),
                height: 200.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    forumList(),
                    forumList(),
                    forumList(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Quotes',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          color: Colors.black12,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 8.0),
                          child: Text(
                            'View All',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  StreamBuilder<QuoteResponse>(
                    stream: quoteBloc.subject.stream,
                    builder: (context, AsyncSnapshot<QuoteResponse> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.error != null &&
                            snapshot.data.error.length > 0) {
                          return _buildErrorWidget(snapshot.data.error);
                        }
                        return _QuoteWidget(snapshot.data);
                      } else if (snapshot.hasError) {
                        return _buildErrorWidget(snapshot.error);
                      } else {
                        return _buildLoadingWidget();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
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

  Widget _QuoteWidget(QuoteResponse data) {
    List<Quote> quotes = data.quotes;
    if (quotes.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'No Quotes is Available at the Moment',
            ),
          ],
        ),
      );
    } else {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: quotes.length,
        itemBuilder: (context, index) {
          print(quotes[index].title);
          return QuoteWidget(
            imageName: quotes[index].image_name,
            quoteTitle: quotes[index].title,
            quoteDesc: quotes[index].desc,
          );
        },
      );
    }
  }
}

// QuoteWidget(
// imageName: NetworkImage(quotes.),
// quoteTitle: 'title',
// quoteDesc:
// 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
// )
