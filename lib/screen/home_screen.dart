import 'package:flutter/material.dart';
import 'package:wow/blocs/bloc_provider.dart';
import 'package:wow/blocs/forum_bloc.dart';
import 'package:wow/blocs/home_bloc.dart';
import 'package:wow/blocs/quote_bloc.dart';
import 'package:wow/model/Quote.dart';
import 'package:wow/utils.dart';
import '../CustomShapeClipper.dart';
import 'forum_list_widget.dart';
import 'quote_widget.dart';


class HomeScreenTopPart extends StatefulWidget {
  @override
  _HomeScreenTopPartState createState() => _HomeScreenTopPartState();
}

class _HomeScreenTopPartState extends State<HomeScreenTopPart> {
  HomescreenBloc _homescreenBloc;
  QuteBloc _quteBloc;
  ForumBloc _forumBloc;

  @override
  void initState() {
    super.initState();
    _homescreenBloc = BlocProvider.of<HomescreenBloc>(context);
    _quteBloc = BlocProvider.of<QuteBloc>(context);
    _forumBloc = BlocProvider.of<ForumBloc>(context);
  }

  @override
  void dispose() {
    _homescreenBloc.dispose();
    _quteBloc.dispose();
    _forumBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: HomescreenBloc(),
      child: SingleChildScrollView(
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
                    StreamBuilder<List<Quote>>(
                      stream: _homescreenBloc.quoteListStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Quote>> snapshot) {
                        // print(snapshot);
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return QuoteWidget(
                                imageName:
                                    NetworkImage(snapshot.data[index].image_name),
                                quoteTitle: snapshot.data[index].title,
                                quoteDesc: snapshot.data[index].desc,
                              );
                            },
                          );
                        }
                        return Container();
                      },
                    ),

                    // QuoteWidget(
                    //   imageName: NetworkImage(
                    //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXiHrNih0QXbPhdelcPvlCymWGI8M0JrEZlw&usqp=CAU'),
                    //   quoteTitle: 'title',
                    //   quoteDesc:
                    //       'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                    // ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


