import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinemapp_practice_project/BLoC/movie_card_events_bloc.dart';
import 'package:cinemapp_practice_project/BLoC/movie_card_states_bloc.dart';
import 'package:cinemapp_practice_project/db/movie_local_db.dart' as favDB;
import 'package:cinemapp_practice_project/services/MovieRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieCardFavoriteBLoC extends Bloc<MovieCardEvent, MoviesCardState> {
  MovieCardFavoriteBLoC(this.movieRepository) : super(UnknownFavoriteState());

  final MovieRepository movieRepository;

  @override
  Stream<MoviesCardState> mapEventToState(MovieCardEvent event) async* {
    bool favorite = await favDB.isFavoriteMovie(event.movie.movieId);
    if (event is AddToFavoriteEvent) {
      if (favorite) {
        event.movie.isFavorite = false;
        await favDB.removeFromFavorites(event.movie);
        print("Fav: $favorite");
        yield NotFavoriteState();
      } else {
        var movie = event.movie;
        movie.isFavorite = true;
        // movie.backdrop = await movieRepository.getBackDrop(movie.backdropPath);
        //movie.poster = await movieRepository.getBackDrop(movie.posterPath);
        print("${movie.poster}");
        await favDB.addFavorites(movie);
        yield InFavoriteState();
      }
    } else if (event is CheckFavoriteEvent) {
      if (favorite) {
        yield InFavoriteState();
      } else {
        yield NotFavoriteState();
      }
    }
  }
}

class MovieCardPosterBLoC extends Bloc<MovieCardEvent, MoviesCardState> {
  MovieCardPosterBLoC(this.movieRepository) : super(PosterEmptyState());

  final MovieRepository movieRepository;

  @override
  Stream<MoviesCardState> mapEventToState(MovieCardEvent event) async* {
    if (event is LoadPosterEvent) {
      var loadedImageURL =
          movieRepository.getLowPosterURL(event.movie.posterPath!);
      var loadedLowImage = CachedNetworkImage(
        imageUrl: loadedImageURL,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      );
      yield PosterLowLoadedState(loadedImage: loadedLowImage);

      loadedImageURL =
          movieRepository.getHighPosterURL(event.movie.posterPath!);
      var loadedHighImage = CachedNetworkImage(
        imageUrl: loadedImageURL,
        //placeholder: (context, url) =>
        errorWidget: (context, url, error) => Icon(Icons.error),
      );
      yield PosterHighLoadedState(loadedImage: loadedHighImage);
    }
  }
}
