import 'package:cinemapp_practice_project/models/CreditsModel.dart';
import 'package:cinemapp_practice_project/models/MovieModel.dart';
import 'package:cinemapp_practice_project/models/SeriesModel.dart';
import 'package:cinemapp_practice_project/services/SeriesProvider.dart';

class SeriesRepository{
  SeriesProvider _seriesProvider = SeriesProvider();
  Future<List<int>> getPopularMoviesID(int page) => _seriesProvider.getPopularIDs(page);
  Future<List<int>> getTopRatedMoviesID(int page) => _seriesProvider.getTopRatedIDs(page);
  Future<Series> getSeriesInfo(int id) async {
    var series =  await  _seriesProvider.getSeriesInfo(id);
   series.mainGenres = _getGenres(series.genres );
    return series;
  }
  String getLowPosterURL(String posterPath) => _seriesProvider.getImageLink(posterPath,92).toString();
  String getHighPosterURL(String posterPath) => _seriesProvider.getImageLink(posterPath,342).toString();
  String getBackDropURL(String posterPath) => _seriesProvider.getImageLink(posterPath,780).toString();
  Future<String> getBackDrop(String posterPath) async => await _seriesProvider.getImageBytes(posterPath, 342);
  Future<List<Cast>> getActors(int seriesID) => _seriesProvider.getSeriesActors(seriesID);

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