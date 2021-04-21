import 'package:cinemapp_practice_project/MovieAPI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'MovieDetailsPage.dart';
import 'models/MovieModel.dart';

class _MovieCardWidgetState2 extends State<MovieCardWidget2> {
  final Movie movie;

  _MovieCardWidgetState2(this.movie);

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: 197,
        height: 296,
        child: GestureDetector(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => MovieDetailsWidget(movie: movie,))),

          child:Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: EdgeInsets.symmetric(horizontal: 7.0),
          color: Color(0xFF191926),
          child:  Column(children: [
              Stack(fit: StackFit.loose,
                  alignment: Alignment.topCenter,

                  children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                    child: DecoratedBox(
                      child: Image.network("https://image.tmdb.org/t/p/w500${movie.posterPath}",fit: BoxFit.cover,),
                      position: DecorationPosition.foreground,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.center,
                              colors: [Color(0xFF191926),
                                Color(0xDD191926),
                                Color(0x44191926)])),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -1,
                  left: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            "${getGenres(movie.genres)}",
                            style:
                                TextStyle(fontSize: 10, color: Color(0xFFFF3466)),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 2.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Color(0xFFFF3466),
                                size: 10,
                              ),
                              Icon(Icons.star, color: Color(0xFFFF3466), size: 10),
                              Icon(Icons.star, color: Color(0xFFFF3466), size: 10),
                              Icon(Icons.star, color: Color(0xFFFF3466), size: 10),
                              Icon(Icons.star, color: Color(0xFFFF3466), size: 10),
                              Text("${movie.voteCount} reviews",
                                  style: TextStyle(
                                      fontSize: 10, color: Color(0xFF6D6D80)))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ]),
              Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${(movie.title.length < 25) ? movie.title : (movie.title.substring(0, 20) + "...")}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(6, 0, 6, 8),
                    child: Text(
                      "${movie.runtime} mins",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )),
            ]),
          ),
        ),
      );

  }

  String getGenres(List<Genre> list) {
    final List<String> genres = [];
    for (var genre in list) {
      genres.add(genre.name);
    }
    if (genres.length > 3) {
      genres.removeRange(3, genres.length);
    }
    return genres.join(", ");
  }
}

class MovieCardWidget2 extends StatefulWidget {
  final Movie _movie;

  MovieCardWidget2(this._movie);

  @override
  State<StatefulWidget> createState() => _MovieCardWidgetState2(_movie);
}
