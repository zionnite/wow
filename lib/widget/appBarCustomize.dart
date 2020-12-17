import 'package:flutter/material.dart';

import '../utils.dart';

class AppBarCustomize extends StatelessWidget implements PreferredSize {
  String toNav;
  AppBarCustomize({this.toNav});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      child: new Container(
        padding: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: new Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 20.0, bottom: 0.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  Navigator.popAndPushNamed(context, toNav);
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
          gradient: new LinearGradient(colors: [firstColor, secondColor]),
          // boxShadow: [
          //   new BoxShadow(
          //     color: Colors.grey[500],
          //     blurRadius: 20.0,
          //     spreadRadius: 1.0,
          //   ),
          // ],
        ),
      ),
      // preferredSize: new Size(MediaQuery.of(context).size.width, 150.0),
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize
  //Size get preferredSize => throw UnimplementedError();
  Size get preferredSize => const Size.fromHeight(100);
}
