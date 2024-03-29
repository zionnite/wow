import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wow/utils.dart';

class QuoteWidget extends StatelessWidget {
  String imageName;
  String quoteTitle;
  String quoteDesc;
  QuoteWidget({this.imageName, this.quoteTitle, this.quoteDesc});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(9.0),
        ),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 2.0,
        vertical: 3.0,
      ),
      height: 500.0,
      width: double.infinity,
      child: Card(
        elevation: 5.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: 100.0,
                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //     image: imageName,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                child: CachedNetworkImage(
                  imageUrl: imageName,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                  fadeInDuration: Duration(milliseconds: 500),
                  fadeInCurve: Curves.easeIn,
                  placeholder: (context, progressText) => Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
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
                bottom: 5.0,
                right: 8.0,
              ),
              child: Text(
                this.quoteDesc,
                style: TextStyle(
                  fontSize: 17.0,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Oxygen',
                  height: 2.0,
                ),
                maxLines: 5,
              ),
            ),
            InkWell(
                onTap: null,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15, top: 8.0, bottom: 15),
                  child: Text(
                    'Read More',
                    style: TextStyle(
                      fontSize: 17.0,
                      color: firstColor,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
