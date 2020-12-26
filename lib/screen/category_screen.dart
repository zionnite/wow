import 'package:flutter/material.dart';
import 'package:wow/blocs/QouteBloc.dart';
import 'package:wow/blocs/bloc_provider.dart';
import 'package:wow/model/Quote.dart';
import 'package:wow/screen/quote_detail_screen.dart';
import 'package:wow/services/ApiService.dart';
import 'package:wow/utils.dart';
import 'package:wow/widget/quote_widget.dart';

class CategoryScreen extends StatefulWidget {
  String cat_id, cat_name;

  CategoryScreen({this.cat_id, this.cat_name});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final quoteBloc = QuoteBloc();
  ScrollController _controller;
  int current_page = 1;
  bool isLoading = false;
  @override
  void initState() {
    //quoteBloc = BlocProvider.of<QuoteBloc>(context);
    quoteBloc.getQuoteById(widget.cat_id, current_page);
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
      getQuoteByCatId(widget.cat_id, current_page).then((value) => {
            quoteBloc.handleCatListenPerPage(value),
          });

      //});
    }
  }

  Future<void> handleRefresh() async {
    setState(() {
      current_page = 1;
    });
    await getQuoteByCatId(widget.cat_id, current_page).then((value) => {
          quoteBloc.handleCatRefresh(value),
        });
  }

  @override
  void dispose() {
    quoteBloc.dispose();
    super.dispose();
  }

  getCategoryQuote() async {
    await quoteBloc.getQuoteById(widget.cat_id, current_page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: firstColor,
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
      body: RefreshIndicator(
        onRefresh: handleRefresh,
        child: SingleChildScrollView(
          controller: _controller,
          child: Column(
            children: [
              Text(
                widget.cat_name,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.red,
                ),
              ),
              StreamBuilder<List<Quote>>(
                stream: quoteBloc.listQuoteCatStream,
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
                              snapshot.data[index].id == "") {
                            return Center(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  margin: EdgeInsets.only(),
                                  padding: EdgeInsets.all(10.0),
                                  child: Text('No more Data '),
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
