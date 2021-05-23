

import 'package:cinemapp_practice_project/models/MovieModel.dart';
import 'package:flutter/foundation.dart';

abstract class MoviesState{}

class MoviesEmptyListState extends MoviesState{}
class MoviesLoadingListState extends MoviesState{}
class MoviesLoadedListState extends MoviesState{
  List<Movie> loadedMovies;
  MoviesLoadedListState({@required this.loadedMovies});
}
class MoviesListErrorState extends MoviesState{}