import 'package:cinemapp_practice_project/MovieAPI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/CreditsModel.dart';
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
                    child: Image.network("https://image.tmdb.org/t/p/w500${movie.backdropPath}",
                      fit: BoxFit.fitHeight,
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
                    "${getGenres(movie.genres)}",
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
                      Text("${movie.voteCount} reviews",
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
                      Text("${movie.overview}", style: TextStyle(fontSize: 14))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
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
                              child: MovieCastWidget(movie.id))),
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
  String getGenres(List<Genre> list) {
    final List<String> genres = [];
    for (var genre in list) {
      genres.add(genre.name);
    }

    return genres.join(", ");
  }
}

class ActorsCardWidget extends StatelessWidget {
  Cast actor;
  ActorsCardWidget(this.actor);



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
                decoration: new BoxDecoration(),
                child: Image.network("https://image.tmdb.org/t/p/w300${actor.profilePath}",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 6.0),
            child: Text("${actor.name}"),
          )
        ],
      ),
    );
  }
}
class MovieCastWidget extends StatelessWidget {

  int movieID;
  MovieCastWidget(this.movieID);
  @override
  Widget build(BuildContext context) {
    return Container(
      child:FutureBuilder(
        future: MovieApi.getMovieActors(this.movieID),
        builder:(context, snapshot) {
            final actors = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.none:
                print("no data");
                break;
              case ConnectionState.active:
                print("no data1");
                break;

              case ConnectionState.done:
                if (!snapshot.hasData) {
                  print("YES YES YES ${snapshot.data}");
                  return Text("No data");
                } else {
                  print("${actors.length}");
                  return buildActors(actors);
                }
            }
            return Center(child: CircularProgressIndicator());
          },

      ),
    );
  }

  Widget buildActors(List<Cast> actors) => GridView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      gridDelegate:
      SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          childAspectRatio: 1.8,
          crossAxisSpacing: 10,
          mainAxisSpacing: 8),
      itemBuilder: (context, index) {
        final actor = actors[index];
        return ActorsCardWidget(actor);
      },
    );}
