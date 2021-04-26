import 'package:flutter/material.dart';

class BioDetailWidget extends StatefulWidget {
  String user_name;
  String user_full_name;
  String age;

  BioDetailWidget({
    this.user_name,
    this.user_full_name,
    this.age,
  });

  @override
  _BioDetailWidgetState createState() => _BioDetailWidgetState();
}

class _BioDetailWidgetState extends State<BioDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
        right: 15.0,
        left: 15.0,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.user_name,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0.0,
              vertical: 5.0,
            ),
            child: Divider(
              // color: Colors.grey,
              height: 1.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Full Name',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.user_full_name,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0.0,
              vertical: 5.0,
            ),
            child: Divider(
              height: 1.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Age',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.age,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
