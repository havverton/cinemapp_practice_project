import 'file:///D:/Flutter_Projects/cinemapp_practice_project/lib/pages/MovieDetailsPage.dart';
import 'file:///D:/Flutter_Projects/cinemapp_practice_project/lib/utilities/constants.dart';
import 'package:cinemapp_practice_project/db/movie_local_db.dart' as favDB;
import 'package:cinemapp_practice_project/models/MovieModel.dart';
import 'package:cinemapp_practice_project/network/MovieAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class _MovieCardWidgetState extends State<MovieCardWidget> {
  final Movie movie;

  _MovieCardWidgetState(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 197,
      height: 296,
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetailsWidget(
                      movie: movie,
                    ))),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: EdgeInsets.symmetric(horizontal: 7.0),
          color: kMainBackGrndColor,
          child: Column(children: [
            Stack(
                fit: StackFit.loose,
                alignment: Alignment.topCenter,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                      child: Hero(
                          tag: movie.id,
                          child: DecoratedBox(
                            child: Image.network(MovieApi.getPoster(movie.posterPath).toString()),
                            position: DecorationPosition.foreground,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.center,
                                    colors: [
                                  Color(0xFF191926),
                                  Color(0xDD191926),
                                  Color(0x44191926)
                                ])),
                          )),
                    ),
                  ),
                  Positioned(
                    top: 1,
                    left: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        width: 24,
                        height: 24,
                        margin: EdgeInsets.only(top: 6.0, left: 6.0),
                        color: Color(0xE6191926),
                        alignment: Alignment.center,
                        child: Text(
                          "${movie.adult ? '18+' : '13+'}",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 1,
                      right: 1,
                      child: GestureDetector(
                        //onTap: () => _toggleFavorite(movie),
                        child: Container(
                          margin: EdgeInsets.only(top: 8.0, right: 6.0),
                          child: Icon((Icons.favorite),
                              color: /*movie.isFavorite
                                  ? Color(0xBFFF4D79)
                                  :*/ Color(0xBFFFFFFF),
                              size: 18),
                        ),
                      )),
                  Positioned(
                    bottom: -1,
                    left: 1,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              "${movie.genres}",
                              style: TextStyle(
                                  fontSize: 10, color: kSecondaryColor),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 2.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: kSecondaryColor,
                                  size: 10,
                                ),
                                Icon(Icons.star,
                                    color: kSecondaryColor, size: 10),
                                Icon(Icons.star,
                                    color: kSecondaryColor, size: 10),
                                Icon(Icons.star,
                                    color: kSecondaryColor, size: 10),
                                Icon(Icons.star,
                                    color: kSecondaryColor, size: 10),
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
            Expanded(
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
                      color: Color(0xFF565665),
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

  Image myImage;

/*  void _toggleFavorite(Movie movie) {
    if (movie.isFavorite) {
      setState(() {
        movie.isFavorite = false;
        favDB.removeFromFavorites(movie);
      });
    } else {
      setState(() {
        movie.isFavorite = true;
        favDB.addFavorites(movie);
      });
    }
  }*/

/*
  @override
  void initState() {
    super.initState();
    myImage = Image.asset("assets/images/tenet_poster.jpg");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(myImage.image, context);
  }
*/
}

class MovieCardWidget extends StatefulWidget {
  final Movie _movie;

  MovieCardWidget(this._movie);

  @override
  State<StatefulWidget> createState() => _MovieCardWidgetState(_movie);
}
