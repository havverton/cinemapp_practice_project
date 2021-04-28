import 'dart:typed_data';

import 'package:cinemapp_practice_project/db/favorites_db.dart' as favDB;
import 'package:cinemapp_practice_project/network/MovieAPI.dart';
import 'package:http/http.dart' as http;
import 'MovieJSONModel.dart';
import 'MovieModel.dart';

class MovieProvider {
  Future<Movie> getPopular(int id)async {
    var movie = await  MovieApi.getPopularInfo(id);
    return     Movie(
            adult: movie.adult,
            id: movie.id,
            overview: movie.overview,
            runtime: movie.runtime,
            title: movie.title,
            //voteAverage: movie.voteAverage,
            voteCount: movie.voteCount,
            genres: getGenres(movie.genres),
            posterImg: await getPoster(movie.posterPath),
            isFavorite: (await isFavorite(movie))
          );
  }
  String getGenres(List<Genre> genres) {
    var genresList = List<String>.empty(growable: true);
    if (genres.length > 3) {
      genres.removeRange(3, genres.length);
    }

    for (var genre in genres) {
      genresList.add(genre.name);
    }

    return genresList.join(", ");
  }

  Future<Uint8List> getPoster(String posterPath) async {
   //var image = Image.network("https://image.tmdb.org/t/p/w500$posterPath");
    final _authority = "image.tmdb.org";
    final _path = "t/p/w185$posterPath";
    var _uri = Uri.https(_authority, _path);
    http.Response response = await http.get(_uri);
    var bodyBytes = response.bodyBytes;
    var base64 = bodyBytes.buffer.asUint8List();

    return base64;
  }
  Future<bool> isFavorite(MovieJSON movie) async{
    var database = favDB.openFavoritesDB();
    return await favDB.isFavoriteMovie(database, movie);
  }


}