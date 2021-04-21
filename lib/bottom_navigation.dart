import 'package:flutter/material.dart';
import 'package:wow/screen/forum_screen.dart';
import 'package:wow/screen/profile_screen.dart';
import 'package:wow/screen/quote_screen.dart';
import 'package:wow/screen/story_screen.dart';
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
    StoryScreen(),
    ProfileScreen(),
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
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Colors.white,
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: Colors.red,
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: new TextStyle(
                  color: Colors.yellow,
                ),
              ),
        ), // sets the inactive color of the `BottomNavigationBar`
        child: BottomNavigationBar(
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
                Icons.all_inbox_outlined,
              ),
              label: 'Forum',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.album_sharp,
              ),
              label: 'Story',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.people_alt_rounded,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
          selectedFontSize: 15.0,
          unselectedFontSize: 15.0,
          selectedItemColor: firstColor,
          unselectedItemColor: Colors.grey,
        ),
      ),
      // bottomNavigationBar:
    );
  }
}
