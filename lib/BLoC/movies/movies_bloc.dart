import 'package:cinemapp_practice_project/BLoC/movies/movies_events_bloc.dart';
import 'package:cinemapp_practice_project/BLoC/movies/movies_states_bloc.dart';
import 'package:cinemapp_practice_project/models/MovieModel.dart';
import 'package:cinemapp_practice_project/services/MovieRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieListBLoC extends Bloc<MovieListEvent, MovieListState> {
  MovieListBLoC(this.movieRepository) : super(MoviesEmptyListState());
  final MovieRepository movieRepository;

  @override
  Stream<MovieListState> mapEventToState(MovieListEvent event) async* {
    List<int> _loadedMoviesId = List.empty();
    List<Movie> _loadedMoviesList = [];
    if (event.page == 1) yield MoviesLoadingListState();
    try {
      if (event is MovieLoadPopularEvent) {
        _loadedMoviesId = await movieRepository.getPopularMoviesID(event.page);
      } else if (event is MovieLoadTopRatedEvent) {
        _loadedMoviesId = await movieRepository.getTopRatedMoviesID(event.page);
      } else if (event is MovieLoadUpcomingEvent) {
        _loadedMoviesId = await movieRepository.getUpcomingMoviesID(event.page);
      }
      await Future.wait(_loadedMoviesId.map((id) async {
        var movie = await movieRepository.getMovieInfo(id);
        _loadedMoviesList.add(movie);
      }));
      yield MoviesLoadedListState(loadedMovies: _loadedMoviesList);
    } catch (_) {
      yield MoviesListErrorState();
    }
  }
}
