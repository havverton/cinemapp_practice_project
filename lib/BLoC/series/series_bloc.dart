import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinemapp_practice_project/models/SeriesModel.dart';
import 'package:cinemapp_practice_project/services/SeriesRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SeriesListBLoC extends Bloc<SeriesListEvent, SeriesListState> {
  SeriesListBLoC(this.seriesRepository) : super(SeriesEmptyListState());
  final SeriesRepository seriesRepository;

  @override
  Stream<SeriesListState> mapEventToState(SeriesListEvent event) async* {
    List<int> _loadedMoviesId = List.empty();
    List<Series> _loadedMoviesList = [];
    if (event.page == 1) yield SeriesLoadingListState();
    try {
      if (event is SeriesLoadPopularEvent) {
        _loadedMoviesId = await seriesRepository.getPopularMoviesID(event.page);
      } else if (event is SeriesLoadTopRatedEvent) {
        _loadedMoviesId = await seriesRepository.getTopRatedMoviesID(event.page);
      }
      await Future.wait(_loadedMoviesId.map((id) async {
        var series = await seriesRepository.getSeriesInfo(id);
        _loadedMoviesList.add(series);
      }));
      yield SeriesLoadedListState(loadedMovies: _loadedMoviesList);
    } catch (_) {
        throw _;
      yield SeriesListErrorState();
    }
  }
}

abstract class SeriesListEvent{
  int page;
  SeriesListEvent(this.page);
}

class SeriesLoadPopularEvent extends SeriesListEvent{
  int page;
  SeriesLoadPopularEvent({ required this.page}) : super(page);
}
class SeriesLoadTopRatedEvent extends SeriesListEvent{
  int page;
  SeriesLoadTopRatedEvent({ required this.page}) : super(page);
}


abstract class SeriesListState {}

class SeriesEmptyListState extends SeriesListState {}

class SeriesLoadingListState extends SeriesListState {}

class SeriesLoadedListState extends SeriesListState {
  List<Series> loadedMovies;

  SeriesLoadedListState({required this.loadedMovies});
}

class SeriesListErrorState extends SeriesListState {}


