import 'file:///D:/Flutter_Projects/cinemapp_practice_project/lib/pages/FilmPage.dart';
import 'package:cinemapp_practice_project/pages/FavoritesPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Cinemapp());
}

class Cinemapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: Typography.whiteRedmond),
      home: MainScaffold()
    );
  }
}

class MainScaffold extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold>{
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF191926),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF191926),
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
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
          ),
        ],
        //currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFFF3365),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,

      ),
      body: Container(
          color: Color(0xFF191926),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  onPressed: () => {},
                  child: Text("${_selectedIndex == 0 ? '123' : '4321'}"),
                ),
              ),
              Expanded(
                child: _selectedIndex == 0 ? FilmPage() : FavoritesPage(),
              )
            ],
          )
      ),
    );
  }

}