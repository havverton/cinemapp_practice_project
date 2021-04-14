import 'package:cinemapp_practice_project/FilmPage.dart';
import 'package:cinemapp_practice_project/models/MovieModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MovieCardWidget.dart';

void main() {
  runApp(Cinemapp());
}

class Cinemapp extends StatelessWidget {

 // final Movie movie = Movie(true,1,[1],"ololo",1,1,"test test","");
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: Typography.whiteRedmond),
      home: Container(
        color: Color(0xFF191947),
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
                      MovieCardWidget(movie),
                      MovieCardWidget(movie),
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

