import 'package:flutter/material.dart';
import 'package:wow/utils.dart';

class ResultSearchScreen extends StatefulWidget {
  String searchTerm;

  ResultSearchScreen({this.searchTerm});

  @override
  _ResultSearchScreenState createState() => _ResultSearchScreenState();
}

class _ResultSearchScreenState extends State<ResultSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Result Page',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3),
              child: Text(
                'Result search for ("${widget.searchTerm}")',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.deepOrangeAccent,
                ),
              ),
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
