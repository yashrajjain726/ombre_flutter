import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ombre_flutter/constants/colors.constants.dart';
import 'package:ombre_flutter/screens/fav_artist_screen.dart';
import 'package:ombre_flutter/screens/home_screen.dart';
import 'package:ombre_flutter/screens/search_screen.dart';
import 'package:ombre_flutter/screens/trending_artist_screen.dart';

import 'constants/size.constants.dart';

class DashBoardScreen extends StatefulWidget {
  static const screenId = 'dashboard_screen';
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int _currentTabIndex = 0;
  final List<Widget> screens = const [
    HomeScreen(),
    TrendingArtistScreen(),
    FavArtistScreen(),
    SearchScreen()
  ];
  final List<Widget> icons = const [
    Icon(Icons.home),
    Icon(Icons.add),
    Icon(Icons.chair),
    Icon(Icons.search)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentTabIndex],
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: primaryColor,
        backgroundColor: Colors.transparent,
        color: secondaryColor,
        height: size65,
        items: icons,
        index: _currentTabIndex,
        onTap: (index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
      ),
    );
  }
}
