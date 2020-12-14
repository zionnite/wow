import 'package:flutter/material.dart';
import 'package:wow/blocs/QouteBloc.dart';
import 'package:wow/model/Quote.dart';

import 'package:wow/utils.dart';
import '../CustomShapeClipper.dart';
import 'forum_list_widget.dart';
import '../widget/quote_widget.dart';

class HomeScreenTopPart extends StatefulWidget {
  @override
  _HomeScreenTopPartState createState() => _HomeScreenTopPartState();
}

class _HomeScreenTopPartState extends State<HomeScreenTopPart> {
  QuoteBloc allQuoteBloc = QuoteBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    allQuoteBloc.dispose();
  }

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
                  StreamBuilder(
                      stream: allQuoteBloc.allQuoteStream,
                      builder: (context, AsyncSnapshot<List<Quote>> snapshot) {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (contex, index) {
                              return QuoteWidget(
                                imageName:
                                    NetworkImage(snapshot.data[index].image),
                                quoteTitle: snapshot.data[index].title,
                                quoteDesc: snapshot.data[index].desc,
                              );
                            });
                      }),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//
