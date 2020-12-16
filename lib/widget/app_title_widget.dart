import 'package:flutter/material.dart';

import '../CustomShapeClipper.dart';
import '../bottom_navigation.dart';
import '../utils.dart';

class appTitleWidget extends StatelessWidget {
  String title;
  String toNav;
  appTitleWidget({this.title, this.toNav});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            PreferredSize(
              child: new Container(
                padding: new EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top),
                child: new Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 20.0, bottom: 0.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        } else {
                          Navigator.popAndPushNamed(context, Nav.id);
                        }
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 40.0,
                      ),
                    ),
                  ),
                ),
                decoration: new BoxDecoration(
                  gradient:
                      new LinearGradient(colors: [firstColor, secondColor]),
                  // boxShadow: [
                  //   new BoxShadow(
                  //     color: Colors.grey[500],
                  //     blurRadius: 20.0,
                  //     spreadRadius: 1.0,
                  //   ),
                  // ],
                ),
              ),
              preferredSize: new Size(MediaQuery.of(context).size.width, 150.0),
            ),
            ClipPath(
              clipper: CustomShapeClipper(),
              child: Container(
                padding: EdgeInsets.only(top: 20.0),
                height: 180.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [firstColor, secondColor],
                  ),
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 45.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
