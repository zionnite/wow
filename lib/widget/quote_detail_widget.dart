import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils.dart';

class QuoteDetailWidget extends StatelessWidget {
  String imageName;
  String quoteTitle;
  String quoteDesc;
  String author;
  String authorImg;
  String isBackgroundLink;
  String backgroundLink;
  String time_ago;
  String type;

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
  });

  @override
  Widget build(BuildContext context) {
    Future<void> _launched;
    return Column(
      children: [
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
                  height: 500.0,
                  child: CachedNetworkImage(
                    imageUrl: imageName,
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
                            backgroundImage: NetworkImage(authorImg),
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
                                  author,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  time_ago,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'Raleway',
                                  ),
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
                    quoteTitle,
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
                    text: this.quoteDesc,
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
        (isBackgroundLink == 'true')
            ? Container(
                margin: EdgeInsets.only(bottom: 50.0),
                child: GestureDetector(
                  onTap: () {
                    _launchUniversalLinkIos(backgroundLink);
                  },
                  child: Card(
                    color: Colors.white70,
                    elevation: 10.0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8.0, left: 20.0, right: 20.0),
                      child: Text(
                        'Know More',
                        style: TextStyle(
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ),
                  ),
                ),
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
