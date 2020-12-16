import 'package:flutter/material.dart';
import 'package:wow/screen/forum_screen.dart';
import 'package:wow/screen/quote_screen.dart';
import 'package:wow/utils.dart';

import 'screen/home_screen.dart';

class Nav extends StatefulWidget {
  static const String id = 'nav_screen';
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    HomeScreenTopPart(),
    QuoteScreen(),
    ForumScreen(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10.0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_book_rounded,
            ),
            label: 'Quote',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people_alt_rounded,
            ),
            label: 'Forum',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedFontSize: 20.0,
        unselectedFontSize: 20.0,
        selectedItemColor: firstColor,
      ),
    );
  }
}
