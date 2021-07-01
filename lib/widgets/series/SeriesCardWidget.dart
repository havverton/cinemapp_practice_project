import 'dart:convert';

import 'package:cinemapp_practice_project/BLoC/series/series_bloc.dart';
import 'package:cinemapp_practice_project/BLoC/series/series_card_bloc.dart';
import 'package:cinemapp_practice_project/models/SeriesModel.dart';
import 'package:cinemapp_practice_project/pages/SeriesDetailsPage.dart';
import 'package:cinemapp_practice_project/services/MovieRepository.dart';
import 'package:cinemapp_practice_project/services/SeriesRepository.dart';
import 'package:cinemapp_practice_project/widgets/RatingBarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'file:///D:/Flutter_Projects/cinemapp_practice_project/lib/utilities/constants.dart';

class _SeriesCardWidgetState extends State<SeriesCardWidget>
    with AutomaticKeepAliveClientMixin {
  final Series movie;

  _SeriesCardWidgetState(this.movie);

  @override
  bool get wantKeepAlive => false;

  SeriesRepository movieRepository = SeriesRepository();

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [BlocProvider(
        create: (context) => SeriesCardPosterBLoC(movieRepository),),
        BlocProvider(
          create: (context) => SeriesCardFavoriteBLoC(movieRepository),),
      ],
      child: Container(
        width: 197,
        height: 296,
        child: GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SeriesDetailsWidget(
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
                            tag: movie.id,
                            child: DecoratedBox(
                              child: Container(
                                width: 166,
                                height: 248,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: BlocBuilder<SeriesCardPosterBLoC,
                                      SeriesCardState>(
                                          builder: (context, state) {
                                          if (state is PosterLowLoadedState) {
                                            return state.loadedImage;
                                          } else if (state
                                              is PosterHighLoadedState) {
                                            return state.loadedImage;
                                          } else if (state
                                              is PosterEmptyState) {
                                            BlocProvider.of<SeriesCardPosterBLoC>(context)
                                                .add(LoadPosterEvent(movie));
                                            return CircularProgressIndicator();
                                          }
                                          return CircularProgressIndicator();
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
                        right: 1,
                        child: GestureDetector(
                          onTap: () => BlocProvider.of<SeriesCardFavoriteBLoC>(context)
                              .add(AddToFavoriteEvent(movie)),
                          child: BlocBuilder<SeriesCardFavoriteBLoC,
                              SeriesCardState>(builder: (context, state) {
                            bool test;
                            if (state is InFavoriteState) {
                              test = true;
                            } else if (state is NotFavoriteState) {
                              test = false;
                            } else {
                              BlocProvider.of<SeriesCardFavoriteBLoC>(context)
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
                                "${movie.mainGenres}",
                                style: TextStyle(
                                    fontSize: 10, color: kSecondaryColor),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 2.0),
                              child: Row(
                                children: [
                                  RatingBarWidget(movie.voteAverage),
                                  Text("${movie.voteCount} votes",
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
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${(movie.name.length < 30) ? movie.name : (movie.name.substring(0, 27) + "...")}",
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
                        "${movie.seasons.length} seasons",
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF565665),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                ],
              ),
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}

class SeriesCardWidget extends StatefulWidget {
  final Series _movie;

  SeriesCardWidget(this._movie);

  @override
  State<StatefulWidget> createState() => _SeriesCardWidgetState(_movie);
}
