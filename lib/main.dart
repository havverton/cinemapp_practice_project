import 'file:///D:/Flutter_Projects/cinemapp_practice_project/lib/pages/FilmPage.dart';
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
      home: Container(
          margin: EdgeInsets.symmetric(horizontal: 7.0),
          color: Color(0xFF191926),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  onPressed: () => {print("ololo")},
                  child: Text("123"),
                ),
              ),
              Expanded(
                child: FilmPage(),
                /*child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.58,
                    children: [
                      MovieCardWidget2(movie),

                    ],

                  ),*/
              )
            ],
          )
          //child: MovieCardWidget(),
          /*child: GridView.extent (
        maxCrossAxisExtent: 200,

          children: [
            Column(
              children: [
                MovieCardWidget(),
                MovieCardWidget(),
              ],
            ),
            Column(
              children: [
                MovieCardWidget(),
                MovieCardWidget(),
              ],
            ),
            Container(
              color: Colors.red
            ),
            MovieCardWidget(),
            MovieCardWidget(),
            MovieCardWidget(),

            MovieCardWidget(),
            MovieCardWidget(),
            MovieCardWidget(),
          ],
        ),*/
          ),
    );
  }
}
