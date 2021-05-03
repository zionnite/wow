import 'dart:io';

import 'package:draggable_fab/draggable_fab.dart';
// import 'package:fancy_dialog/fancy_dialog.dart';
// import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wow/blocs/QouteBloc.dart';
import 'package:wow/blocs/app_bloc.dart';
import 'package:wow/blocs/bloc_provider.dart';
import 'package:wow/blocs/forum_bloc.dart';
import 'package:wow/model/Category.dart';
import 'package:wow/model/Forum.dart';
import 'package:wow/model/ForumComment.dart';
import 'package:wow/model/Quote.dart';
import 'package:wow/screen/forum_screen.dart';
import 'package:wow/screen/profile_screen.dart';
import 'package:wow/screen/quote_detail_screen.dart';
import 'package:wow/screen/quote_screen.dart';
import 'package:wow/screen/search_result_screen.dart';
import 'package:wow/screen/send_private_message.dart';
import 'package:wow/screen/story_screen.dart';
import 'package:wow/screen/users_screen.dart';
import 'package:wow/services/ApiService.dart';
import 'package:wow/services/user_details.dart';

import 'package:wow/utils.dart';
import 'package:wow/widget/quote_widget.dart';
import '../CustomShapeClipper.dart';
import '../bottom_navigation.dart';
import '../widget/forum_list_widget.dart';
import 'about_screen.dart';
import 'category_screen.dart';
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
  bool isNewUpdate = true;

  bool _showStatus = false;
  String _statusMsg;
  TextEditingController searchTermController = TextEditingController();

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  GlobalKey<ScaffoldState> fancyDialog = GlobalKey();

  String my_id, my_full_name, my_email, my_image;

  _initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isUserLogin = prefs.getBool('isUserLogin');
    var user_id = prefs.getString('user_id');
    var user_full_name = prefs.getString('full_name');
    var user_email = prefs.getString('email');
    var user_img = prefs.getString('user_img') ?? null;

    setState(() {
      my_id = user_id;
      my_full_name = user_full_name;
      my_email = user_email;
      my_image = user_img;
    });
  }

  @override
  void initState() {
    appBloc = BlocProvider.of<AppBloc>(context);
    quoteBloc = BlocProvider.of<QuoteBloc>(context);
    forumBloc = BlocProvider.of<ForumBloc>(context);
    super.initState();
    _initUserDetail();
  }

  Future<Widget> showPop() async {
    final int UPDATED_WOW_APP_VERSION = await isAppHasNewUpdate();
    var AndroidAppLink = await iosStoreLink();
    var iosAppLink = await iosStoreLink();
    if (UPDATED_WOW_APP_VERSION > CURRENT_WOW_APP_VERSION) {
      return showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
          key: fancyDialog,
          image: Image.asset(
            'assets/images/updates.gif',
            fit: BoxFit.cover,
          ),
          title: Text(
            'New App Update!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
          ),
          entryAnimation: EntryAnimation.BOTTOM_RIGHT,
          description: Text(
            'New App Update is available on the Store, click on the Button to update to the new version',
            textAlign: TextAlign.center,
          ),
          buttonOkText: Text(
            'Update Now',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onOkButtonPressed: () {
            if (Platform.isIOS) {
              _launchUniversalLinkIos(iosAppLink);
            }
            if (Platform.isAndroid) {
              _launchUniversalLinkIos(AndroidAppLink);
            }
          },
        ),
      );
    }
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
      backgroundColor: Colors.white,
      key: _drawerKey,
      drawer: Drawer(
        child: Container(
          margin: EdgeInsets.only(top: 0.0),
          color: secondColor,
          child: ListView(
            children: [
              new UserAccountsDrawerHeader(
                margin: EdgeInsets.only(top: 1),
                decoration: BoxDecoration(
                  color: secondColor,
                ),
                accountName: (my_full_name != null)
                    ? Text(
                        '${my_full_name}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NerkoOne',
                          fontSize: 25.0,
                        ),
                      )
                    : Text(''),
                accountEmail: new Text(
                  '${my_email}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'NerkoOne',
                    fontSize: 20.0,
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: (my_image == null)
                      ? AssetImage('assets/images/splash.png')
                      : NetworkImage(my_image),
                ),
                otherAccountsPictures: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.close,
                        size: 23,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.white,
                height: 3.0,
              ),
              Container(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Home',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      trailing: Icon(
                        Icons.home,
                        size: 28,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, Nav.id);
                      },
                    ),
                    ListTile(
                      title: Text(
                        'Quote',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      trailing: Icon(
                        Icons.menu_book_rounded,
                        size: 28,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, QuoteScreen.id);
                      },
                    ),
                    ListTile(
                      title: Text(
                        'Forum',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      trailing: Icon(
                        Icons.all_inbox_outlined,
                        size: 28,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, ForumScreen.id);
                      },
                    ),
                    ListTile(
                      title: Text(
                        'Status',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      trailing: Icon(
                        Icons.album_sharp,
                        size: 28,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, StoryScreen.id);
                      },
                    ),
                    ListTile(
                      title: Text(
                        'Users',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      trailing: Icon(
                        Icons.people_alt_rounded,
                        size: 28,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, UsersScreen.id);
                      },
                    ),
                    ListTile(
                      title: Text(
                        'Contact Us',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      trailing: Icon(
                        Icons.message,
                        size: 28,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, SendPrivateMessage.id);
                      },
                    ),
                    ListTile(
                      title: Text(
                        'About WOW',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      trailing: Icon(
                        Icons.error,
                        size: 28,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, AboutScreen.id);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // (mounted) ? showPop() : Container(),
            Stack(
              children: [
                ClipPath(
                  clipper: CustomShapeClipper(),
                  child: Container(
                    height: 500.0,
                    width: double.infinity,
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
                        Column(
                          children: [
                            SizedBox(
                              height: 20.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      showPop();
                                      _drawerKey.currentState.openDrawer();
                                    },
                                    icon: Icon(
                                      Icons.menu,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.error,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, AboutScreen.id);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
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
                                color: Colors.white,
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
                                    hintText:
                                        'What would you like to search for?',
                                  ),
                                ),
                              ),
                            ),
                            (_showStatus == true)
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14.0),
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
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       left: 8.0, right: 8.0, top: 8.0),
                        //   child: Text(
                        //     'Please Click a Category or Scroll this way for more!',
                        //     style: TextStyle(
                        //       fontSize: 20.0,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //     textAlign: TextAlign.center,
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 8.0),
                        //   child: Icon(
                        //     Icons.arrow_forward,
                        //     color: Colors.white,
                        //     size: 40.0,
                        //   ),
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 2.0),
                        //   child: Container(
                        //     height: 100.0,
                        //     child: StreamBuilder<List<Category>>(
                        //       stream: quoteBloc.categoryStream,
                        //       builder: (context,
                        //           AsyncSnapshot<List<Category>> snapshot) {
                        //         if (snapshot.hasData) {
                        //           if (snapshot.error != null &&
                        //               snapshot.data.length > 0) {
                        //             return _buildErrorWidget(snapshot.error);
                        //           }
                        //           return ListView.builder(
                        //             physics: ClampingScrollPhysics(),
                        //             scrollDirection: Axis.horizontal,
                        //             shrinkWrap: true,
                        //             itemCount: snapshot.data.length,
                        //             itemBuilder: (context, index) {
                        //               return Container(
                        //                 margin: EdgeInsets.symmetric(
                        //                     vertical: 15.0),
                        //                 child: GestureDetector(
                        //                   onTap: () {
                        //                     //QuoteBloc categories_data = await quoteBloc
                        //                     //  .getQuoteById(snapshot.data[index].catId);
                        //                     Navigator.push(
                        //                       context,
                        //                       MaterialPageRoute(
                        //                         builder: (context) {
                        //                           return CategoryScreen(
                        //                             cat_id: snapshot
                        //                                 .data[index].catId,
                        //                             cat_name: snapshot
                        //                                 .data[index].catName,
                        //                           );
                        //                         },
                        //                       ),
                        //                     );
                        //                   },
                        //                   child: Card(
                        //                     shape: RoundedRectangleBorder(
                        //                       borderRadius:
                        //                           BorderRadius.circular(250),
                        //                     ),
                        //                     child: Padding(
                        //                       padding:
                        //                           const EdgeInsets.symmetric(
                        //                               vertical: 18.0,
                        //                               horizontal: 50),
                        //                       child: Text(
                        //                         snapshot.data[index].catName,
                        //                         style: TextStyle(
                        //                           fontSize: 18.0,
                        //                           fontWeight: FontWeight.bold,
                        //                         ),
                        //                       ),
                        //                     ),
                        //                     elevation: 5.0,
                        //                   ),
                        //                 ),
                        //               );
                        //             },
                        //           );
                        //         } else if (snapshot.hasError) {
                        //           return _buildErrorWidget(snapshot.error);
                        //         } else {
                        //           return _buildLoadingWidget();
                        //         }
                        //       },
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 18.0),
              child: Text(
                'Please Click a Category or Scroll this way for more!',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(
                Icons.arrow_forward,
                color: Colors.black,
                size: 40.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0),
              child: Container(
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
                                elevation: 8.0,
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
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20.0),
              child: Text(
                'Scroll Down for More!',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.arrow_downward_rounded,
                color: Colors.black,
                size: 40.0,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Random Quote',
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
                Container(
                  margin: EdgeInsets.symmetric(vertical: 12.0),
                  height: 200.0,
                  child: StreamBuilder<List<Quote>>(
                    stream: quoteBloc.listRandomQuoteStream,
                    builder: (context, AsyncSnapshot<List<Quote>> snapshot) {
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

                                // print(snapshot.data[index].id);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return QuoteDetailScreen(
                                        quote_id: snapshot.data[index].id,
                                        image_Name: snapshot.data[index].image,
                                        quote_Title: snapshot.data[index].title,
                                        quote_Desc: snapshot.data[index].desc,
                                        author_name:
                                            snapshot.data[index].author,
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
                                            quote_id: snapshot.data[index].id,
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
            (isNewUpdate) ? Text('Hello') : Container(),
          ],
        ),
      ),
      // floatingActionButton: DraggableFab(
      //   child: FloatingActionButton(
      //     backgroundColor: firstColor,
      //     onPressed: () {
      //       Navigator.pushNamed(context, SendPrivateMessage.id);
      //     },
      //     child: Icon(
      //       Icons.message,
      //     ),
      //   ),
      // ),
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

Future<void> _onOpen(LinkableElement link) async {
  if (await canLaunch(link.url)) {
    await launch(link.url);
  } else {
    throw 'Could not launch $link';
  }
}

Future<void> _launchUniversalLinkIos(String url) async {
  if (await canLaunch(url)) {
    final bool nativeAppLaunchSucceeded = await launch(
      url,
      forceSafariVC: false,
      universalLinksOnly: true,
    );
    if (!nativeAppLaunchSucceeded) {
      await launch(
        url,
        forceSafariVC: true,
      );
    }
  }
}
