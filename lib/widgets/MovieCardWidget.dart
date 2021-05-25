import 'dart:convert';

import 'package:cinemapp_practice_project/BLoC/movie_card_bloc.dart';
import 'package:cinemapp_practice_project/BLoC/movie_card_events_bloc.dart';
import 'package:cinemapp_practice_project/BLoC/movie_card_states_bloc.dart';
import 'package:cinemapp_practice_project/models/MovieModel.dart';
import 'package:cinemapp_practice_project/services/MovieRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'file:///D:/Flutter_Projects/cinemapp_practice_project/lib/pages/MovieDetailsPage.dart';
import 'file:///D:/Flutter_Projects/cinemapp_practice_project/lib/utilities/constants.dart';

class _MovieCardWidgetState extends State<MovieCardWidget>
    with AutomaticKeepAliveClientMixin {
  final Movie movie;

  _MovieCardWidgetState(this.movie);

  @override
  bool get wantKeepAlive => false;

  MovieRepository movieRepository = MovieRepository();

  @override
  Widget build(BuildContext context) {
    final MovieCardFavoriteBLoC movieCardFavoriteBLoC =
        BlocProvider.of<MovieCardFavoriteBLoC>(context);
    return BlocProvider(
      create: (context) => MovieCardPosterBLoC(movieRepository),
      child: Container(
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                        child: Hero(
                            tag: movie.movieId,
                            child: DecoratedBox(
                              child: Container(
                                width: 166,
                                height: 248,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: movie.isFavorite
                                      ? Image.memory(
                                          base64Decode(movie.poster!))
                                      : BlocBuilder<MovieCardPosterBLoC,
                                              MoviesCardState>(
                                          builder: (context, state) {
                                          if (state is PosterLowLoadedState) {
                                            return state.loadedImage;
                                          } else if (state
                                              is PosterHighLoadedState) {
                                            return state.loadedImage;
                                          } else if (state
                                              is PosterEmptyState) {
                                            context
                                                .read<MovieCardPosterBLoC>()
                                                .add(LoadPosterEvent(movie));
                                            return CircularProgressIndicator();
                                          }
                                          return Image.memory(
                                              base64Decode(movie.poster!));
                                        }),
                                ),
                              ),
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
                          onTap: () => movieCardFavoriteBLoC
                              .add(AddToFavoriteEvent(movie)),
                          child: BlocBuilder<MovieCardFavoriteBLoC,
                              MoviesCardState>(builder: (context, state) {
                            bool test;
                            if (state is InFavoriteState) {
                              test = true;
                            } else if (state is NotFavoriteState) {
                              test = false;
                            } else {
                              movieCardFavoriteBLoC
                                  .add(CheckFavoriteEvent(movie));
                              test = false;
                            }
                            return Container(
                              margin: EdgeInsets.only(top: 8.0, right: 6.0),
                              child: Icon((Icons.favorite),
                                  color: test
                                      ? Color(0xBFFF4D79)
                                      : Color(0xBFFFFFFF),
                                  size: 18),
                            );
                          }),
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
                                          fontSize: 10,
                                          color: Color(0xFF6D6D80)))
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
      ),
    );
  }
}

class MovieCardWidget extends StatefulWidget {
  final Movie _movie;

  MovieCardWidget(this._movie);

  @override
  State<StatefulWidget> createState() => _MovieCardWidgetState(_movie);
}
