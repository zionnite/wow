import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:wow/blocs/QouteBloc.dart';
import 'package:wow/blocs/app_bloc.dart';
import 'package:wow/blocs/bloc_provider.dart';
import 'package:wow/blocs/forum_bloc.dart';
import 'package:wow/model/Forum.dart';
import 'package:wow/model/ForumComment.dart';
import 'package:wow/model/Quote.dart';
import 'package:wow/screen/forum_screen.dart';
import 'package:wow/screen/quote_detail_screen.dart';
import 'package:wow/screen/quote_screen.dart';
import 'package:wow/screen/search_result_screen.dart';
import 'package:wow/screen/send_private_message.dart';

import 'package:wow/utils.dart';
import 'package:wow/widget/quote_widget.dart';
import '../CustomShapeClipper.dart';
import '../widget/forum_list_widget.dart';
import 'forum_detail_screen.dart';

class HomeScreenTopPart extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenTopPartState createState() => _HomeScreenTopPartState();
}

class _HomeScreenTopPartState extends State<HomeScreenTopPart> {
  String searchTerm;
  AppBloc appBloc;
  QuoteBloc quoteBloc;
  ForumBloc forumBloc;
  //final QuoteBloc allQuoteBloc = QuoteBloc();

  bool _showStatus = false;
  String _statusMsg;
  TextEditingController searchTermController = TextEditingController();

  @override
  void initState() {
    appBloc = BlocProvider.of<AppBloc>(context);
    quoteBloc = BlocProvider.of<QuoteBloc>(context);
    forumBloc = BlocProvider.of<ForumBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    //allQuoteBloc.dispose();
    appBloc.dispose();
    quoteBloc.dispose();
    forumBloc.dispose();
    searchTermController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                          height: 20.0,
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            child: TextField(
                              controller: searchTermController,
                              onChanged: (text) {
                                setState(() {
                                  searchTerm = text;
                                  //forumBloc.searchSink.add(searchTerm);
                                });
                              },
                              style: dropDownMenuItemStyle,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 32.0, vertical: 14.0),
                                border: InputBorder.none,
                                hintText: 'Enter Search Term',
                              ),
                            ),
                          ),
                        ),
                        (_showStatus == true)
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14.0),
                                child: Text(
                                  _statusMsg,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : Container(),
                        Container(
                          margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
                          child: InkWell(
                            onTap: () {
                              if (!searchTermController.text.isEmpty) {
                                setState(() {
                                  searchTermController.text = '';
                                  _showStatus = false;
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ResultSearchScreen(
                                        searchTerm: searchTerm,
                                      );
                                    },
                                  ),
                                );
                              } else {
                                setState(() {
                                  setState(() {
                                    _showStatus = true;
                                    _statusMsg =
                                        'Search Term Field can\'t be empty!';
                                  });
                                });
                              }
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(250),
                              ),
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
                        ),
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
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, ForumScreen.id);
                        },
                        child: Container(
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
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 12.0),
                  height: 200.0,
                  child: StreamBuilder<List<Forum>>(
                    stream: forumBloc.allforumStream,
                    builder: (context, AsyncSnapshot<List<Forum>> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.error != null &&
                            snapshot.data.length > 0) {
                          return _buildErrorWidget(snapshot.error);
                        }
                        return ListView.builder(
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            if (snapshot.data[index].id == null ||
                                snapshot.data[index].id == "") {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'There is no Trending topics to display at the moment',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              );
                            }
                            return GestureDetector(
                              onTap: () async {
                                //ForumBloc comment_detail =
                                // await forumBloc
                                //     .getCommentById(snapshot.data[index].id);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ForumDetailScreen(
                                        pick_id: snapshot.data[index].id,
                                        imageName: snapshot.data[index].image,
                                        forumTitle: snapshot.data[index].title,
                                        forumDesc: snapshot.data[index].desc,
                                        comment_counter:
                                            snapshot.data[index].commentCounter,
                                        authorImg:
                                            snapshot.data[index].authorImage,
                                        author: snapshot.data[index].author,
                                        time_ago: snapshot.data[index].time,
                                        //forumBloc: forumBloc,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: forumList(
                                imageName: snapshot.data[index].image,
                                title: snapshot.data[index].title,
                                user_name: snapshot.data[index].author,
                                time_ago: snapshot.data[index].time,
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
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, QuoteScreen.id);
                          },
                          child: Container(
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
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    StreamBuilder<List<Quote>>(
                      stream: quoteBloc.allQuoteStream,
                      builder: (context, AsyncSnapshot<List<Quote>> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.error != null &&
                              snapshot.data.length > 0) {
                            return _buildErrorWidget(snapshot.error);
                          }

                          return ListView.builder(
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                //check if id is not null here
                                if (snapshot.data[index].id == null ||
                                    snapshot.data[index].id == "") {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Quote is not available at the moment',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  );
                                }
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return QuoteDetailScreen(
                                            image_Name:
                                                snapshot.data[index].image,
                                            quote_Title:
                                                snapshot.data[index].title,
                                            quote_Desc:
                                                snapshot.data[index].desc,
                                            author_name:
                                                snapshot.data[index].author,
                                            author_Img: snapshot
                                                .data[index].authorImage,
                                            isBackground_Link: snapshot
                                                .data[index].isBackground,
                                            background_Link: snapshot
                                                .data[index].backgroundLink,
                                            timer_ago:
                                                snapshot.data[index].time,
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
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: DraggableFab(
        child: FloatingActionButton(
          backgroundColor: firstColor,
          onPressed: () {
            Navigator.pushNamed(context, SendPrivateMessage.id);
          },
          child: Icon(
            Icons.message,
          ),
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
