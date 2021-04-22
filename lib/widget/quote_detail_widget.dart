import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wow/blocs/QouteBloc.dart';
import 'package:wow/services/ApiService.dart';

import '../utils.dart';

class QuoteDetailWidget extends StatefulWidget {
  String imageName;
  String quoteTitle;
  String quoteDesc;
  String author;
  String authorImg;
  String isBackgroundLink;
  String backgroundLink;
  String time_ago;
  String type;
  String quote_id;

  QuoteDetailWidget({
    this.imageName,
    this.quoteTitle,
    this.quoteDesc,
    this.author,
    this.authorImg,
    this.isBackgroundLink,
    this.backgroundLink,
    this.time_ago,
    this.type,
    this.quote_id,
  });

  @override
  _QuoteDetailWidgetState createState() => _QuoteDetailWidgetState();
}

class _QuoteDetailWidgetState extends State<QuoteDetailWidget> {
  final quoteBloc = QuoteBloc();

  int yes_counter = 0;
  int no_counter = 0;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    currentYesCounter();
    currentNoCounter();
    //callYesCounter();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // callYesCounter() {
  //   getQuoteYesCounter(1).then(
  //     (value) => {
  //       quoteBloc.handleYesCounter(value),
  //     },
  //   );
  // }

  currentYesCounter() {
    setState(() {
      _isLoading = true;
    });
    getCurrentQuoteYesCounter(widget.quote_id).then((value) {
      if (mounted) {
        setState(
          () {
            yes_counter = value;
            _isLoading = false;
          },
        );
      }
    });
  }

  currentNoCounter() {
    setState(() {
      _isLoading = true;
    });
    getCurrentQuoteNoCounter(widget.quote_id).then((value) {
      if (mounted) {
        setState(
          () {
            no_counter = value;
            _isLoading = false;
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _launched;
    return Column(
      children: [
        // Text(widget.quote_id),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(9.0),
            ),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 9.0,
            vertical: 9.0,
          ),
          width: double.infinity,
          child: Card(
            elevation: 5.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: CachedNetworkImage(
                    imageUrl: widget.imageName,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    fadeInDuration: Duration(milliseconds: 500),
                    fadeInCurve: Curves.easeIn,
                    placeholder: (context, progressText) => Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25.0, left: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundColor: firstColor,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(widget.authorImg),
                            radius: 48.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 12.0, right: 3.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.author,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.time_ago,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: 'Raleway',
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: IconButton(
                                        icon: Icon(Icons.share_rounded),
                                        onPressed: () async {
                                          Share.share(widget.quoteDesc,
                                              subject: 'Women Of Worth');

                                          // final RenderBox box =
                                          //     context.findRenderObject();
                                          // if (Platform.isAndroid) {
                                          //   var url = widget.imageName;
                                          //   var response =
                                          //       await get(Uri.parse(url));
                                          //   final documentDirectory =
                                          //       (await getExternalStorageDirectory())
                                          //           .path;
                                          //   File imgFile = new File(
                                          //       '$documentDirectory/wow.png');
                                          //   File imgFile2 = new File(
                                          //       '$documentDirectory/wow.png');
                                          //   imgFile.writeAsBytesSync(
                                          //       response.bodyBytes);
                                          //   Share.shareFiles([
                                          //     '${new File('$documentDirectory/wow.png')}'
                                          //   ],
                                          //       subject: 'URL File Share',
                                          //       text:
                                          //           'Hello, check your share files!',
                                          //       sharePositionOrigin:
                                          //           box.localToGlobal(
                                          //                   Offset.zero) &
                                          //               box.size);
                                          // } else {
                                          //   Share.share(
                                          //       'Hello, check your share files!',
                                          //       subject: 'URL File Share',
                                          //       sharePositionOrigin:
                                          //           box.localToGlobal(
                                          //                   Offset.zero) &
                                          //               box.size);
                                          // }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
                    bottom: 25.0,
                    right: 8.0,
                  ),
                  child: SelectableLinkify(
                    onOpen: _onOpen,
                    text: this.widget.quoteDesc,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Oxygen',
                      height: 2.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: 15.0,
            right: 15.0,
            top: 8.0,
            bottom: 15.0,
          ),
          child: Column(
            children: [
              Text(
                'Whats the Quote helpful',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        int counter = await quoteBloc.handleYesCounter(
                            widget.quote_id, yes_counter, 'zionnite');

                        setState(() {
                          yes_counter = counter;
                          _isLoading = false;
                          if (no_counter > 0) {
                            no_counter--;
                          }
                        });
                      },
                      child: Card(
                        color: Colors.white70,
                        elevation: 10.0,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, left: 20.0, right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.thumb_up,
                                color: Colors.green,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Yes',
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Expanded(
                                child: (_isLoading == true)
                                    ? Text('Loading...')
                                    : Text(
                                        '${yes_counter}',
                                        style: TextStyle(
                                          color: Colors.green,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text('|'),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        int counter = await quoteBloc.handleNoCounter(
                            widget.quote_id, yes_counter, 'zionnite');

                        setState(() {
                          no_counter = counter;
                          _isLoading = false;
                          if (yes_counter > 0) {
                            yes_counter--;
                          }
                        });
                      },
                      child: Card(
                        color: Colors.white70,
                        elevation: 10.0,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, left: 20.0, right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.thumb_down,
                                color: Colors.deepOrangeAccent,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'No',
                                style: TextStyle(
                                  color: Colors.deepOrangeAccent,
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Expanded(
                                child: (_isLoading == true)
                                    ? Text('Loading...')
                                    : Text(
                                        '${no_counter}',
                                        style: TextStyle(
                                          color: Colors.deepOrangeAccent,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        (widget.isBackgroundLink == 'true')
            ? Column(
                children: [
                  Text(
                    'More External Resource',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 50.0),
                    child: GestureDetector(
                      onTap: () {
                        _launchUniversalLinkIos(widget.backgroundLink);
                      },
                      child: Card(
                        color: Colors.redAccent,
                        elevation: 10.0,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, left: 20.0, right: 20.0),
                          child: Text(
                            'Know More',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Container(),
      ],
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

Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
  if (snapshot.hasError) {
    return Text('Error: ${snapshot.error}');
  } else {
    return const Text('');
  }
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
