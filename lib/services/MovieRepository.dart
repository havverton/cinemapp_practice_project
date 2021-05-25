import 'package:cinemapp_practice_project/models/CreditsModel.dart';
import 'package:cinemapp_practice_project/models/MovieModel.dart';
import 'package:cinemapp_practice_project/services/MovieProvider.dart';

class MovieRepository{
  MovieProvider _movieProvider = MovieProvider();
  Future<List<int>> getPopularMoviesID(int page) => _movieProvider.getPopularIDs(page);
  Future<List<int>> getTopRatedMoviesID(int page) => _movieProvider.getTopRatedIDs(page);
  Future<Movie> getMovieInfo(int id) async {
    var movie =  await  _movieProvider.getMoviesInfo(id);
    movie.mainGenres = _getGenres(movie.genres ?? List.empty());
    return movie;
  }
  String getLowPosterURL(String posterPath) => _movieProvider.getImageLink(posterPath,92).toString();
  String getHighPosterURL(String posterPath) => _movieProvider.getImageLink(posterPath,342).toString();
  String getBackDropURL(String posterPath) => _movieProvider.getImageLink(posterPath,780).toString();
  Future<String> getBackDrop(String posterPath) async => await _movieProvider.getImageBytes(posterPath, 342);
  Future<List<Cast>> getActors(int movieID) => _movieProvider.getMovieActors(movieID);

  String _getGenres(List<Genre> genres) {
    var genresList = List<String>.empty(growable: true);
    if (genres.length > 3) {
      genres.removeRange(3, genres.length);
    }
    for (var genre in genres) {
      genresList.add(genre.name);
    }
    return genresList.join(", ").toString();
  }
}