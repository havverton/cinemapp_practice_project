import 'package:cinemapp_practice_project/models/MovieModel.dart';

abstract class MovieListState {}

class MoviesEmptyListState extends MovieListState {}

class MoviesLoadingListState extends MovieListState {}

class MoviesLoadedListState extends MovieListState {
  List<Movie> loadedMovies;

  MoviesLoadedListState({required this.loadedMovies});
}

class MoviesListErrorState extends MovieListState {}
