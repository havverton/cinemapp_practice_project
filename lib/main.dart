import 'package:cinemapp_practice_project/pages/FavoritesPage.dart';
import 'package:cinemapp_practice_project/pages/FilmPage.dart';
import 'package:cinemapp_practice_project/pages/SearchPage.dart';
import 'package:cinemapp_practice_project/pages/TVSeriesPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'file:///D:/Flutter_Projects/cinemapp_practice_project/lib/utilities/constants.dart';

void main() {
  runApp(Cinemapp());
}

class Cinemapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(textTheme: Typography.whiteRedmond),
        home: MainScaffold());
  }
}

class MainScaffold extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    FilmPage(),
    FavoritesPage(),
    TVSeriesPage(),
    SearchPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackGrndColor,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kMainBackGrndColor,
        unselectedItemColor: Colors.white24,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplay),
            label: 'TV Series',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
        selectedItemColor: Color(0xFFFF3365),
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
      body: _pages[_selectedIndex],
    );
  }
}

/*class TabNavigator extends StatelessWidget {
  TabNavigator({required this.navigatorKey, required this.tabItem});

  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}*/
