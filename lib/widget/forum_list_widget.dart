import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class forumList extends StatelessWidget {
  String imageName, title, user_name, time_ago;
  forumList({this.imageName, this.title, this.user_name, this.time_ago});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2.0),
            width: 200.0,
            child: CachedNetworkImage(
              imageUrl: imageName,
              fit: BoxFit.cover,
              height: 200,
              fadeInDuration: Duration(milliseconds: 500),
              fadeInCurve: Curves.easeIn,
              placeholder: (context, progressText) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            bottom: 0.0,
            width: 200,
            height: 60.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black,
                    Colors.black.withOpacity(0.1),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 10.0,
            bottom: 10.0,
            right: 10.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        user_name,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    time_ago,
                    style: TextStyle(fontSize: 14.0, color: Colors.black),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
