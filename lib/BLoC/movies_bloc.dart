import 'package:cinemapp_practice_project/BLoC/movies_events_bloc.dart';
import 'package:cinemapp_practice_project/BLoC/movies_states_bloc.dart';
import 'package:cinemapp_practice_project/models/MovieModel.dart';
import 'package:cinemapp_practice_project/services/MovieRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviePopularBLoC extends Bloc<MovieEvent, MoviesState> {
  MoviePopularBLoC(this.movieRepository) : super(MoviesEmptyListState());
  final MovieRepository movieRepository;

  @override
  Stream<MoviesState> mapEventToState(MovieEvent event) async* {
    if (event is MovieLoadPopularEvent) {
      if (event.page == 1) yield MoviesLoadingListState();
      try {
        final List<int> _loadedMoviesId =
            await movieRepository.getPopularMoviesID(event.page);
        List<Movie> _loadedMoviesList = [];
        await Future.wait(_loadedMoviesId.map((id) async {
          var movie = await movieRepository.getMovieInfo(id);
          _loadedMoviesList.add(movie);
        }));
        yield MoviesLoadedListState(loadedMovies: _loadedMoviesList);
      } catch (_) {
        yield MoviesListErrorState();
      }
    } else if (event is MovieLoadTopRatedEvent) {
      //yield MoviesLoadingListState();
      try {
        final List<int> _loadedMoviesId =
            await movieRepository.getTopRatedMoviesID(event.page);
        List<Movie> _loadedMoviesList = [];
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
}

class MovieTopRatedBLoC extends Bloc<MovieEvent, MoviesState> {
  MovieTopRatedBLoC(this.movieRepository) : super(MoviesEmptyListState());
  final MovieRepository movieRepository;

  @override
  Stream<MoviesState> mapEventToState(MovieEvent event) async* {
    if (event is MovieLoadPopularEvent) {
      if (event.page == 1) yield MoviesLoadingListState();
      try {
        final List<int> _loadedMoviesId =
            await movieRepository.getPopularMoviesID(event.page);
        List<Movie> _loadedMoviesList = [];
        await Future.wait(_loadedMoviesId.map((id) async {
          var movie = await movieRepository.getMovieInfo(id);
          _loadedMoviesList.add(movie);
        }));
        yield MoviesLoadedListState(loadedMovies: _loadedMoviesList);
      } catch (_) {
        yield MoviesListErrorState();
      }
    } else if (event is MovieLoadTopRatedEvent) {
      yield MoviesLoadingListState();
      try {
        final List<int> _loadedMoviesId =
            await movieRepository.getTopRatedMoviesID(event.page);
        List<Movie> _loadedMoviesList = [];
        await Future.wait(_loadedMoviesId.map((id) async {
          var movie = await movieRepository.getMovieInfo(id);
          _loadedMoviesList.add(movie);
        }));
        yield MoviesLoadedListState(loadedMovies: _loadedMoviesList);
      } catch (err) {
        print(err.toString());
        throw err;
        yield MoviesListErrorState();
      }
    }
  }
}
