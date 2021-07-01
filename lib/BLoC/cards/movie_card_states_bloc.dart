import 'package:cached_network_image/cached_network_image.dart';

abstract class MoviesCardState {
  late bool isFavorite;
}

abstract class MoviesCardPosterState {}

class NotFavoriteState extends MoviesCardState {
  bool isFavorite = false;
}

class UnknownFavoriteState extends MoviesCardState {}

class InFavoriteState extends MoviesCardState {
  bool isFavorite = true;
}

class PosterEmptyState extends MoviesCardState {}

//class PosterLoadingState extends MoviesCardState{}
class PosterLowLoadedState extends MoviesCardState {
  late CachedNetworkImage loadedImage;

  PosterLowLoadedState({required this.loadedImage});
}

class PosterHighLoadedState extends MoviesCardState {
  late CachedNetworkImage loadedImage;

  PosterHighLoadedState({required this.loadedImage});
}
