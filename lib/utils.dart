import 'package:flutter/material.dart';

Color firstColor = Color(0xFFFFD700);
Color secondColor = Color(0xFFFFA500);

const TextStyle dropDownMenuItemStyle =
    TextStyle(color: Colors.black, fontSize: 16.0);

ThemeData appTheme = ThemeData(
  primaryColor: Color(0xFFFFA000),
  fontFamily: 'Oxygen',
  canvasColor: Colors.transparent,
  scaffoldBackgroundColor: Colors.white,
);

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenHeight(
  BuildContext context, {
  double dividedBy = 1,
  double reducedBy,
}) {
  return (screenSize(context).height - reducedBy) / dividedBy;
}

double screenWidth(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).width / dividedBy;
}

double screenHeightExcludingToolbar(BuildContext context,
    {double dividedBy = 1}) {
  return screenHeight(context, dividedBy: dividedBy, reducedBy: kToolbarHeight);
}
