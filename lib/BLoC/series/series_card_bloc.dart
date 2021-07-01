import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinemapp_practice_project/models/SeriesModel.dart';
import 'package:cinemapp_practice_project/services/SeriesRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinemapp_practice_project/db/movie_local_db.dart' as favDB;

class SeriesCardFavoriteBLoC extends Bloc<SeriesCardEvent, SeriesCardState> {
  SeriesCardFavoriteBLoC(this.movieRepository) : super(UnknownFavoriteState());

  final SeriesRepository movieRepository;

  @override
  Stream<SeriesCardState> mapEventToState(SeriesCardEvent event) async* {
    yield NotFavoriteState();/*
    //bool favorite = await favDB.isFavoriteMovie(event.movie.id);
    if (event is AddToFavoriteEvent) {
     */
  }/* if (favorite) {
        //event.movie.isFavorite = false;
        //await favDB.removeFromFavorites(event.movie);
        yield NotFavoriteState();
      } else {
        var movie = event.movie;
        //movie.isFavorite = true;
        // movie.backdrop = await movieRepository.getBackDrop(movie.backdropPath);
        //movie.poster = await movieRepository.getBackDrop(movie.posterPath);
        //  await favDB.addFavorites(movie);
        yield InFavoriteState();
      }*//*
    } else if (event is CheckFavoriteEvent) {
      if (favorite) {
        yield InFavoriteState();
      } else {
        yield NotFavoriteState();
      }
    }
  }*/
}

class SeriesCardPosterBLoC extends Bloc<SeriesCardEvent, SeriesCardState> {
  SeriesCardPosterBLoC(this.movieRepository) : super(PosterEmptyState());

  final SeriesRepository movieRepository;

  @override
  Stream<SeriesCardState> mapEventToState(SeriesCardEvent event) async* {
    if (event is LoadPosterEvent) {
      var loadedImageURL =
      movieRepository.getLowPosterURL(event.movie.posterPath);
      var loadedLowImage = CachedNetworkImage(
        imageUrl: loadedImageURL,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      );
      yield PosterLowLoadedState(loadedImage: loadedLowImage);

      loadedImageURL =
          movieRepository.getHighPosterURL(event.movie.posterPath);
      var loadedHighImage = CachedNetworkImage(
        imageUrl: loadedImageURL,
        //placeholder: (context, url) =>
        errorWidget: (context, url, error) => Icon(Icons.error),
      );
      yield PosterHighLoadedState(loadedImage: loadedHighImage);
    }
  }
}
abstract class SeriesCardEvent {
  late Series movie;
}

class AddToFavoriteEvent extends SeriesCardEvent {
  Series movie;

  AddToFavoriteEvent(this.movie);
}

class CheckFavoriteEvent extends SeriesCardEvent {
  Series movie;

  CheckFavoriteEvent(this.movie);
}

class LoadPosterEvent extends SeriesCardEvent {
  Series movie;

  LoadPosterEvent(this.movie);
}


abstract class SeriesCardState {
  late bool isFavorite;
}

abstract class SeriesCardPosterState {}

class NotFavoriteState extends SeriesCardState {
  bool isFavorite = false;
}

class UnknownFavoriteState extends SeriesCardState {}

class InFavoriteState extends SeriesCardState {
  bool isFavorite = true;
}

class PosterEmptyState extends SeriesCardState {}

//class PosterLoadingState extends MoviesCardState{}
class PosterLowLoadedState extends SeriesCardState {
  late CachedNetworkImage loadedImage;

  PosterLowLoadedState({required this.loadedImage});
}

class PosterHighLoadedState extends SeriesCardState {
  late CachedNetworkImage loadedImage;

  PosterHighLoadedState({required this.loadedImage});
}


