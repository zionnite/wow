import 'package:flutter/material.dart';
import 'package:wow/blocs/QouteBloc.dart';
import 'package:wow/blocs/app_bloc.dart';
import 'package:wow/blocs/bloc_provider.dart';
import 'package:wow/model/Quote.dart';
import 'package:wow/screen/forum_screen.dart';
import 'package:wow/screen/quote_detail_screen.dart';
import 'package:wow/screen/quote_screen.dart';

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
  AppBloc appBloc;
  QuoteBloc quoteBloc;
  //final QuoteBloc allQuoteBloc = QuoteBloc();

  @override
  void initState() {
    appBloc = BlocProvider.of<AppBloc>(context);
    quoteBloc = BlocProvider.of<QuoteBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    //allQuoteBloc.dispose();
    appBloc.dispose();
    quoteBloc.dispose();
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
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ForumDetailScreen(
                                pick_id: '1',
                                imageName:
                                    'https://miro.medium.com/max/2400/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
                                forumTitle: 'bala',
                                forumDesc:
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Pellentesque elit ullamcorper dignissim cras tincidunt lobortis. Fringilla est ullamcorper eget nulla. Aliquet risus feugiat in ante. Eget mi proin sed libero enim sed faucibus turpis. Velit laoreet id donec ultrices tincidunt arcu. Neque gravida in fermentum et sollicitudin ac orci. Tellus integer feugiat scelerisque varius morbi enim nunc faucibus a. Vestibulum morbi blandit cursus risus at ultrices mi. Pellentesque eu tincidunt tortor aliquam nulla facilisi cras. Enim eu turpis egestas pretium aenean pharetra magna ac. Amet volutpat consequat mauris nunc Vitae congue eu consequat ac felis donec et odio pellentesque. Velit aliquet sagittis id consectetur purus ut faucibus. Ac feugiat sed lectus vestibulum mattis ullamcorper velit sed ullamcorper. Sed sed risus pretium quam vulputate dignissim. Nibh cras pulvinar mattis nunc. Vestibulum morbi blandit cursus risus at. Sed risus pretium quam vulputate. Dictum fusce ut placerat orci. Lacus vestibulum sed arcu non odio euismod lacinia. Lobortis elementum nibh tellus molestie nunc. Felis eget nunc lobortis mattis aliquam. Nullam vehicula ipsum a arcu cursus vitae.Dui id ornare arcu odio ut sem nulla pharetra diam. Purus non enim praesent elementum facilisis leo vel. Est pellentesque elit ullamcorper dignissim cras tincidunt lobortis feugiat. Non curabitur gravida arcu ac tortor dignissim. Porttitor lacus luctus accumsan tortor posuere. Sed id semper risus in hendrerit. Scelerisque eleifend donec pretium vulputate sapien nec. Lacus sed turpis tincidunt id aliquet risus feugiat in ante. Purus viverra accumsan in nisl. Facilisis mauris sit amet massa vitae tortor condimentum lacinia quis. Malesuada fames ac turpis egestas. Id semper risus in hendrerit gravida rutrum quisque non tellus.Et tortor consequat id porta nibh venenatis cras. Nunc lobortis mattis aliquam faucibus purus. Diam volutpat commodo sed egestas egestas fringilla phasellus. Nibh nisl condimentum id venenatis a. Vel turpis nunc eget lorem dolor sed viverra ipsum nunc. Pharetra et ultrices neque ornare aenean. Tellus orci ac auctor augue mauris augue neque. Pulvinar mattis nunc sed blandit libero volutpat sed. Semper risus in hendrerit gravida rutrum quisque non tellus. Pellentesque sit amet porttitor eget. Dolor magna eget est lorem ipsum. Eget duis at tellus at urna condimentum mattis pellentesque. Metus aliquam eleifend mi in nulla posuere sollicitudin. Egestas quis ipsum suspendisse ultrices gravida dictum. Blandit massa enim nec dui nunc.Facilisis mauris sit amet massa. Id nibh tortor id aliquet lectus proin nibh nisl. Pharetra diam sit amet nisl suscipit. Maecenas ultricies mi eget mauris pharetra et ultrices neque ornare. Condimentum lacinia quis vel eros donec. Iaculis urna id volutpat lacus laoreet non curabitur gravida. Erat pellentesque adipiscing commodo elit at imperdiet dui accumsan. Penatibus et magnis dis parturient montes nascetur ridiculus. Lacinia quis vel eros donec. Aliquet nibh praesent tristique magna sit amet purus. Dignissim suspendisse in est ante in nibh mauris cursus mattis. Tempor id eu nisl nunc mi ipsum. Mattis vulputate enim nulla aliquet porttitor lacus.',
                                comment_counter: '2',
                                authorImg:
                                    'https://miro.medium.com/max/2400/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
                                author: 'jake',
                                time_ago: '4hrs ago',
                              );
                            },
                          ),
                        );
                      },
                      child: forumList(
                        imageName:
                            'https://miro.medium.com/max/2400/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
                        title: 'I love you',
                        user_name: 'zionnite',
                        time_ago: '2hrs ago',
                      ),
                    ),
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
                                          quote_Desc: snapshot.data[index].desc,
                                          author_name:
                                              snapshot.data[index].author,
                                          author_Img:
                                              snapshot.data[index].authorImage,
                                          isBackground_Link:
                                              snapshot.data[index].isBackground,
                                          background_Link: snapshot
                                              .data[index].backgroundLink,
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

// QuoteWidget(
// imageName: NetworkImage(quotes.),
// quoteTitle: 'title',
// quoteDesc:
// 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
// )
}
