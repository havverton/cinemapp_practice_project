import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MovieCardWidget.dart';
import 'models/MovieModel.dart';

class MovieDetailsWidget extends StatelessWidget {
  final Movie movie;

  const MovieDetailsWidget({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Color(0xFF191926),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: AlignmentDirectional(-1, 1),
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: 1.25,
                  child: DecoratedBox(
                    position: DecorationPosition.foreground,
                    decoration: new BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color(0xFF191926),
                            Color(0xDD191926),
                            Color(0xAA191926)
                          ]),
                    ),
                    child: Image.asset(
                      "assets/images/tenet_poster.jpg",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: -30,
                  right: 16,
                  left: 16,
                  child: Container(
                    child: Text(
                      "${movie.title}",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ))
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 40, 16, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    "Action",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFFF3466),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Color(0xFFFF3466),
                        size: 14,
                      ),
                      Icon(Icons.star, color: Color(0xFFFF3466), size: 14),
                      Icon(Icons.star, color: Color(0xFFFF3466), size: 14),
                      Icon(Icons.star, color: Color(0xFFFF3466), size: 14),
                      Icon(Icons.star, color: Color(0xFFFF3466), size: 14),
                      Text("10 reviews",
                          style:
                              TextStyle(fontSize: 14, color: Color(0xFF6D6D80)))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("STORYLINE",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      Text(
                          "${movie.overview}",
                          style: TextStyle(fontSize: 14))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 4,0,0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Cast",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      SafeArea(
                          child: SizedBox(
                              width: double.infinity,
                              height: 150,
                              child: GridView(
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 250,
                                        childAspectRatio: 1.8 ,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 8),
                                children: [
                                  ActorsCardWidget(),
                                  ActorsCardWidget(),
                                  ActorsCardWidget(),
                                  ActorsCardWidget(),
                                  ActorsCardWidget(),
                                  ActorsCardWidget(),
                                  ActorsCardWidget(),
                                ],
                              )
                          )
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}

class ActorsCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Container(
            child: AspectRatio(
              aspectRatio: 1,
              child: DecoratedBox(
                position: DecorationPosition.foreground,
                decoration: new BoxDecoration(
                ),
                child: Image.asset(
                  "assets/images/tenet_poster.jpg",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 6.0),
            child: Text("David Rubenstein"),
          )
        ],
      ),
    );
  }


}