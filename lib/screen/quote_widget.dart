import 'package:flutter/material.dart';
import 'package:wow/utils.dart';


class QuoteWidget extends StatelessWidget {
  NetworkImage imageName;
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
        horizontal: 9.0,
        vertical: 9.0,
      ),
      height: 800.0,
      width: double.infinity,
      child: Card(
        elevation: 5.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageName,
                    fit: BoxFit.cover,
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
              ),
              child: Text(
                quoteDesc,
                style: TextStyle(
                  fontSize: 17.0,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Oxygen',
                ),
                maxLines: 5,
              ),
            ),
            FlatButton(
                onPressed: null,
                child: Text(
                  'Read More',
                  style: TextStyle(
                    fontSize: 17.0,
                    color: firstColor,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}