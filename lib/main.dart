import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MovieCardWidget.dart';

void main() {
  runApp(Cinemapp());
}

class Cinemapp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        color: Color(0xFF191947),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 0.55,
          children: [
            MovieCardWidget( "avengers", "12 reviews",),
            MovieCardWidget("ololo", "12 reviews",),
            MovieCardWidget("ololo", "12 reviews",),
            MovieCardWidget("ololo", "12 reviews",),
            MovieCardWidget("ololo", "12 reviews",),
            MovieCardWidget("ololo", "12 reviews",),
            MovieCardWidget("ololo", "12 reviews",),
          ],

        ),
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

