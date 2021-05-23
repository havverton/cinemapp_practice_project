

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinemapp_practice_project/models/MovieModel.dart';
import 'package:flutter/foundation.dart';

abstract class MoviesCardState{
  bool isFavorite;
}
abstract class MoviesCardPosterState{}

class NotFavoriteState extends MoviesCardState{
  bool isFavorite = false;
}
class UnknownFavoriteState extends MoviesCardState{
}
class InFavoriteState extends MoviesCardState{
  bool isFavorite = true;
}


class PosterEmptyState extends MoviesCardState{}
//class PosterLoadingState extends MoviesCardState{}
class PosterLowLoadedState extends MoviesCardState{
   CachedNetworkImage loadedImage;
  PosterLowLoadedState({@required this.loadedImage});
}
class PosterHighLoadedState extends MoviesCardState{
  CachedNetworkImage loadedImage;
  PosterHighLoadedState({@required this.loadedImage});
}
