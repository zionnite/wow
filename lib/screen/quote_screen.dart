import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:wow/blocs/QouteBloc.dart';
import 'package:wow/blocs/bloc_provider.dart';
import 'package:wow/model/Category.dart';
import 'package:wow/model/Quote.dart';
import 'package:wow/screen/category_screen.dart';
import 'package:wow/screen/quote_detail_screen.dart';
import 'package:wow/screen/send_private_message.dart';
import 'package:wow/services/ApiService.dart';
import 'package:wow/utils.dart';
import 'package:wow/widget/app_title_widget.dart';
import 'package:wow/widget/quote_widget.dart';

import '../bottom_navigation.dart';

class QuoteScreen extends StatefulWidget {
  static const String id = 'quote_screen';
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  final quoteBloc = QuoteBloc();
  ScrollController _controller;
  int current_page = 1;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    quoteBloc.quotePerPage(current_page);
    //quoteBloc.quotes();
    _controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      //quoteBloc.quotePerPage(1);
      setState(() {
        isLoading = true;
        current_page++;
      });

      // Future.delayed(new Duration(seconds: 4), () {
      getAllQuotesByPage(current_page).then((value) => {
            quoteBloc.handleListenPerPage(value),
          });

      //});
    }
  }

  Future<void> handleRefresh() async {
    setState(() {
      current_page = 1;
    });
    await getAllQuotesByPage(1).then((value) => {
          quoteBloc.handleListenRefresh(value),
        });
  }

  @override
  void dispose() {
    super.dispose();
    //quoteBloc.dispose();
    quoteBloc.quoteCatController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: handleRefresh,
        child: SingleChildScrollView(
          controller: _controller,
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
                              onTap: () {
                                //QuoteBloc categories_data = await quoteBloc
                                //  .getQuoteById(snapshot.data[index].catId);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return CategoryScreen(
                                        cat_id: snapshot.data[index].catId,
                                        cat_name: snapshot.data[index].catName,
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
                stream: quoteBloc.perPageStream,
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
                        if (snapshot.data[index].id == null ||
                            snapshot.data[index].id == '') {
                          //isLoading = false;
                          return (isLoading)
                              ? Text(
                                  'No more data',
                                  textAlign: TextAlign.center,
                                )
                              : Container();
                        }
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
                      },
                    );
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

class MyLoader extends StatelessWidget {
  final double width;
  final double height;

  MyLoader(this.width, this.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: CircularProgressIndicator(
            strokeWidth: 3.0,
          ),
        ),
      ),
    );
  }
}
