import 'package:cinemapp_practice_project/BLoC/cards/movie_card_bloc.dart';
import 'package:cinemapp_practice_project/BLoC/cards/movie_card_events_bloc.dart';
import 'package:cinemapp_practice_project/BLoC/cards/movie_card_states_bloc.dart';
import 'package:cinemapp_practice_project/models/MovieModel.dart';
import 'package:cinemapp_practice_project/services/MovieRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsFavouriteButton extends StatefulWidget {
  final Movie movie;

  const DetailsFavouriteButton(this.movie) : super();

  @override
  _DetailsFavouriteButtonState createState() =>
      _DetailsFavouriteButtonState(this.movie);
}

class _DetailsFavouriteButtonState extends State<DetailsFavouriteButton> {
  bool isDisabled = false;
  MovieRepository movieRepository = MovieRepository();
  Movie movie;

  _DetailsFavouriteButtonState(this.movie);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext newContext) =>
      MovieCardFavoriteBLoC(movieRepository),
      child: Builder(builder: (providerContext) {
        BlocProvider.of<MovieCardFavoriteBLoC>(
            providerContext)
            .add(CheckFavoriteEvent(movie));
        return BlocBuilder<MovieCardFavoriteBLoC, MoviesCardState>(
          //bloc: MovieCardFavoriteBLoC(movieRepository),
          builder: (providerContext, state) {


            return AnimatedContainer(
                width: state is InFavoriteState ? 60 : 180,
                height: 60,
                duration: (Duration(milliseconds: 120)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: state is InFavoriteState
                      ? Container(
                          decoration: BoxDecoration(
                             color: Colors.grey,
                          ),
                          child: InkWell(
                            onTap: () => {
                              BlocProvider.of<MovieCardFavoriteBLoC>(
                                      providerContext)
                                  .add(AddToFavoriteEvent(movie)),
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(Icons.star),
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors:[Color(0xFF8036E7), Color(0xFFFF3365)],
                          )),
                          child: InkWell(
                            onTap: () => {
                              BlocProvider.of<MovieCardFavoriteBLoC>(
                                      providerContext)
                                  .add(AddToFavoriteEvent(movie)),
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Add to favourites"),
                            ),
                          ),
                        ),
                ));
          },
        );
      }),
    );
  }
}

