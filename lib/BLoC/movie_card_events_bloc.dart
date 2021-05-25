import 'package:cinemapp_practice_project/models/MovieModel.dart';

abstract class MovieCardEvent {
  late Movie movie;
}

class AddToFavoriteEvent extends MovieCardEvent {
  Movie movie;

  AddToFavoriteEvent(this.movie);
}

class CheckFavoriteEvent extends MovieCardEvent {
  Movie movie;

  CheckFavoriteEvent(this.movie);
}

class LoadPosterEvent extends MovieCardEvent {
  Movie movie;

  LoadPosterEvent(this.movie);
}
