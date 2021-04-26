import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wow/blocs/forum_bloc.dart';
import 'package:wow/utils.dart';

class ForumWidget extends StatefulWidget {
  String pick_id;
  String imageName;
  String quoteTitle;
  String quoteDesc;
  String comment_counter;
  String author;

  ForumWidget({
    this.pick_id,
    this.imageName,
    this.quoteTitle,
    this.quoteDesc,
    this.comment_counter,
    this.author,
  });

  @override
  _ForumWidgetState createState() => _ForumWidgetState();
}

class _ForumWidgetState extends State<ForumWidget> {
  PopupMenu menu;
  GlobalKey btnKey = GlobalKey();
  GlobalKey btnKey2 = GlobalKey();
  GlobalKey btnKey3 = GlobalKey();
  var selected_id;
  var selected_menu;

  String author;
  String authorImg;
  String time_ago;

  final forumBloc = ForumBloc();
  //TODO:// CHANGE USER NAME
  final String user = 'zionnite';

  _showModalBottomSheetReport(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 600.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: Text(
                    'Please select a Problem',
                    style: TextStyle(
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: [
                        InkWell(
                          onTap: () async {
                            await forumBloc.handleProblemReporting(
                              id: widget.pick_id,
                              user: user,
                              report_type: 'nudity',
                              context: context,
                            );
                            Navigator.pop(context);
                          },
                          child: Card(
                            elevation: 4.0,
                            color: Colors.redAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 5.0,
                                ),
                                height: 30.0,
                                width: double.infinity,
                                child: Text(
                                  'Nudity',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await forumBloc.handleProblemReporting(
                              id: widget.pick_id,
                              user: user,
                              report_type: 'violence',
                              context: context,
                            );
                            Navigator.pop(context);
                          },
                          child: Card(
                            elevation: 4.0,
                            color: Colors.redAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 5.0,
                                ),
                                height: 30.0,
                                width: double.infinity,
                                child: Text(
                                  'Violence',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await forumBloc.handleProblemReporting(
                              id: widget.pick_id,
                              user: user,
                              report_type: 'harassment',
                              context: context,
                            );
                            Navigator.pop(context);
                          },
                          child: Card(
                            elevation: 4.0,
                            color: Colors.redAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 5.0,
                                ),
                                height: 30.0,
                                width: double.infinity,
                                child: Text(
                                  'Harassment',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await forumBloc.handleProblemReporting(
                              id: widget.pick_id,
                              user: user,
                              report_type: 'suicide_or_self_injury',
                              context: context,
                            );
                            Navigator.pop(context);
                          },
                          child: Card(
                            elevation: 4.0,
                            color: Colors.redAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 5.0,
                                ),
                                height: 30.0,
                                width: double.infinity,
                                child: Text(
                                  'Suicide or Self-injury',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await forumBloc.handleProblemReporting(
                              id: widget.pick_id,
                              user: user,
                              report_type: 'false_information',
                              context: context,
                            );
                            Navigator.pop(context);
                          },
                          child: Card(
                            elevation: 4.0,
                            color: Colors.redAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 5.0,
                                ),
                                height: 30.0,
                                width: double.infinity,
                                child: Text(
                                  'False Information',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await forumBloc.handleProblemReporting(
                              id: widget.pick_id,
                              user: user,
                              report_type: 'hate_speech',
                              context: context,
                            );
                            Navigator.pop(context);
                          },
                          child: Card(
                            elevation: 4.0,
                            color: Colors.redAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 5.0,
                                ),
                                height: 30.0,
                                width: double.infinity,
                                child: Text(
                                  'Hate Speech',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await forumBloc.handleProblemReporting(
                              id: widget.pick_id,
                              user: user,
                              report_type: 'spam',
                              context: context,
                            );
                            Navigator.pop(context);
                          },
                          child: Card(
                            elevation: 4.0,
                            color: Colors.redAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 5.0,
                                ),
                                height: 30.0,
                                width: double.infinity,
                                child: Text(
                                  'Spam',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  _showModalBottomSheetBlockUser(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              height: 250.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 20.0,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Are you sure you want to Block this User',
                          style: TextStyle(
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '(${widget.author})?',
                          style: TextStyle(
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            'If you block this User, you won\'t be able to see this user post',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        elevation: 4,
                        color: Colors.redAccent,
                        child: Text(
                          'No, Cancel',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: 'Raleway',
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () async {
                          await forumBloc.handleBlockUser(
                            id: widget.pick_id,
                            user: user,
                            context: context,
                          );
                          Navigator.pop(context);
                        },
                        elevation: 4,
                        color: Colors.green,
                        child: Text(
                          'Yes, Continue',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: 'Raleway',
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  _showModalBottomSheetDeletePost(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              height: 200.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 20.0,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Are you sure you want to Delete this Post?',
                          style: TextStyle(
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'If you delete this post, you won\'t see it again',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        elevation: 4,
                        color: Colors.redAccent,
                        child: Text(
                          'No, Cancel',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: 'Raleway',
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () async {
                          await forumBloc.handlePostDelete(
                            id: widget.pick_id,
                            user: user,
                            context: context,
                          );
                          Navigator.pop(context);
                        },
                        elevation: 4,
                        color: Colors.green,
                        child: Text(
                          'Yes, Continue',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: 'Raleway',
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(9.0),
        ),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 9.0,
        vertical: 9.0,
      ),
      height: 400.0,
      width: double.infinity,
      child: Card(
        elevation: 5.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    child: CachedNetworkImage(
                      imageUrl: widget.imageName,
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                      fadeInDuration: Duration(milliseconds: 500),
                      fadeInCurve: Curves.easeIn,
                      placeholder: (context, progressText) => Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10.0,
                    right: 5.0,
                    child: IconButton(
                      icon: Icon(
                        Icons.more_vert_outlined,
                        size: 40,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        maxColumn(widget.pick_id);
                        setState(() {
                          selected_id = widget.pick_id;
                        });
                      },
                      key: btnKey,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                top: 18.0,
                bottom: 10.0,
              ),
              child: Text(
                widget.quoteTitle,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Divider(
                height: 1.0,
                color: Colors.black12,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                top: 5.0,
                bottom: 5.0,
                right: 8.0,
              ),
              child: SelectableLinkify(
                onOpen: _onOpen,
                text: this.widget.quoteDesc,
                style: TextStyle(
                  fontSize: 17.0,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Oxygen',
                ),
                maxLines: 5,
              ),
            ),
            Row(
              children: [
                FlatButton(
                  onPressed: null,
                  child: Text(
                    'Read More',
                    style: TextStyle(
                      fontSize: 17.0,
                      color: firstColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: 30.0,
                ),
                (widget.comment_counter != '0')
                    ? Text(
                        '${widget.comment_counter} Comment',
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.black54,
                        ),
                      )
                    : Text(
                        'Comment',
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.black54,
                        ),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }

  void maxColumn(String id) {
    PopupMenu menu = PopupMenu(
      context: context,
      // backgroundColor: Colors.grey,
      // lineColor: Colors.tealAccent,
      maxColumn: 3,
      items: [
        MenuItem(
          title: 'Report',
          image: Icon(
            Icons.warning_amber_rounded,
            color: Colors.white,
          ),
        ),
        MenuItem(
          title: 'Block User',
          image: Icon(
            Icons.block_rounded,
            color: Colors.white,
          ),
        ),
        MenuItem(
          title: 'Delete',
          image: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ],
      onClickMenu: onClickMenu,
      stateChanged: stateChanged,
      onDismiss: onDismiss,
    );
    menu.show(widgetKey: btnKey);
  }

  onClickMenu(MenuItemProvider item) {
    // print('Click menu -> ${item.menuTitle}');
    if (item.menuTitle == 'Report') {
      setState(() {
        selected_menu = 'report';
        _showModalBottomSheetReport(context);
      });
    } else if (item.menuTitle == 'Delete') {
      setState(() {
        selected_menu = 'delete';
        _showModalBottomSheetDeletePost(context);
      });
    } else if (item.menuTitle == 'Block User') {
      setState(() {
        selected_menu = 'block';
        _showModalBottomSheetBlockUser(context);
      });
    }
    //print('Quote Id => $selected_id');
    print('Quote Name => $selected_menu');
    //perform Operation to QuoteBloc
  }

  void onDismiss() {
    print('Menu is dismiss');
  }

  stateChanged(bool isShow) {
    print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  void checkState(BuildContext context) {
    final snackBar = new SnackBar(content: new Text('这是一个SnackBar!'));

    Scaffold.of(context).showSnackBar(snackBar);
  }
}
