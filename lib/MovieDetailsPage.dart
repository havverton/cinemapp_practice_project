import 'package:cinemapp_practice_project/models/CreditsModel.dart';
import 'package:cinemapp_practice_project/network/MovieAPI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/MovieModel.dart';

class MovieDetailsWidget extends StatelessWidget {
  final Movie movie;

  const MovieDetailsWidget({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scrollbar(

      child: Container(
        color: Color(0xFF191926),
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(

              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: 2,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Hero(
                        tag: movie.id,
                        child: DecoratedBox(
                          child: Image.memory(movie.posterImg),
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
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(

                  top: 1,
                  left: 1,
                  child: GestureDetector(
                    onTap:() => Navigator.pop(context),
                    child: Container(
                      margin: EdgeInsets.only(top: 59.0,left: 10.0),
                      child: Row(
                        children: [
                          Icon(Icons.chevron_left,color: Color(0xFF565665),),
                          Text("Back",style: TextStyle(color: Color(0xFF565665)),)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),

            Container(
              margin: EdgeInsets.only(left: 10.0,right:10.0,),

              alignment: Alignment.bottomCenter,
              child: Flex(
                mainAxisSize: MainAxisSize.min,
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      "${movie.title}",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        "${movie.genres}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFFF3466),
                        ),
                      ),
                    ),
                  ),
                 Flexible(
                    child: Container(
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
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xFF6D6D80)))
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("STORYLINE",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          Text("${movie.overview}",
                              style: TextStyle(fontSize: 14))
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10.0),
                            child: Text("Cast",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                          ),
                    SizedBox(
                        width: double.infinity,
                        height: 150,
                        child: MovieCastWidget(movie.id)
                    ),

                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
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
                child: Image.network(
                  "https://image.tmdb.org/t/p/w185${actor.profilePath}",
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
      child: FutureBuilder(
        future: MovieApi.getMovieActors(this.movieID),
        builder: (context, snapshot) {
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
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            childAspectRatio: 1.75,
            crossAxisSpacing: 5,
            mainAxisSpacing: 8),
        itemBuilder: (context, index) {
          final actor = actors[index];
          return ActorsCardWidget(actor);
        },
      );
}
