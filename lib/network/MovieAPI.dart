import 'dart:convert';
import 'dart:ui';

import 'file:///D:/Flutter_Projects/cinemapp_practice_project/lib/shit/MovieJSONModel.dart';
import 'package:cinemapp_practice_project/models/MovieModel.dart';
import 'package:cinemapp_practice_project/models/MovieResponseModel.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

import '../models/CreditsModel.dart';


class MovieApi {
  static const apikey = "6e466b67854a32b973cf8e3f9dc31068";

/*  static Future<List<Movie>> getResponse() async {
    // final url =
    //     "https://api.themoviedb.org/3/movie/popular?api_key=6e466b67854a32b973cf8e3f9dc31068&language=en-US&page=1";
    final _authority = "api.themoviedb.org";
    final _path = "/3/movie/top_rated";
    final _params = {
      "api_key": "6e466b67854a32b973cf8e3f9dc31068",
      "language": "en-US",
      "page": "1"
    };
    final _uri = Uri.https(_authority, _path, _params);

    final response = await http.get(_uri);
    final body = json.decode(response.body);
    //print("Body: $body");
    var answer = MovieResponse.fromJson(body);
    return answer.results;
  }
  */


  static Future<List<int>> getPopularIDs(int page) async {
   final _authority = "api.themoviedb.org";
    final _path = "/3/movie/popular";
    final _params = {
      "api_key": "6e466b67854a32b973cf8e3f9dc31068",
      "language": "en-US",
      "page": "$page"
    };
    final _uri = Uri.https(_authority, _path, _params);
    List<int> idList = [];

    final response = await http.get(_uri);
    final body = json.decode(response.body);
    //print("Body: $body");
    var answer = MovieResponse.fromJson(body);
    var results = answer.results;
    results.forEach((element) {
      idList.add(element.id);
    });
    print("Id загружены: ${idList.length}");
    return idList;
  }
  static Future<List<int>> getTopRatedIDs(int page) async {
    final _authority = "api.themoviedb.org";
    final _path = "/3/movie/top_rated";
    final _params = {
      "api_key": "6e466b67854a32b973cf8e3f9dc31068",
      "language": "en-US",
      "page": "$page"
    };
    final _uri = Uri.https(_authority, _path, _params);
    List<int> idList = [];

    final response = await http.get(_uri);
    final body = json.decode(response.body);
    //print("Body: $body");
    var answer = MovieResponse.fromJson(body);
    var results = answer.results;
    results.forEach((element) {
      idList.add(element.id);
    });
    print("Id загружены: ${idList.length}");
    return idList;
  }


  static Future<Movie> getMoviesInfo(int id) async {
    List<Movie> movieList = [];
      final _authority = "api.themoviedb.org";
      final _path = "3/movie/$id";
      final _params = {
        "api_key": "6e466b67854a32b973cf8e3f9dc31068",
        "language": "en-US",
      };
      final _uri = Uri.https(_authority, _path, _params);
      final response = await http.get(_uri);
      final body = json.decode(response.body);
      var answer = Movie.fromJson(body);

    return answer;
  }

  static Future<List<Cast>> getMovieActors(int movieID) async{
    final _authority = "api.themoviedb.org";
    final _path = "3/movie/$movieID/credits";
    final _params = {
      "api_key": "6e466b67854a32b973cf8e3f9dc31068",
      "language": "en-US",
    };
    final _uri = Uri.https(_authority, _path, _params);
    final response = await http.get(_uri);
    final body = json.decode(response.body);

    var answer = Credits.fromJson(body);

    return answer.cast;

  }

    static Uri getPoster(String posterPath){
    //var image = Image.network("https://image.tmdb.org/t/p/w500$posterPath");
    final _authority = "image.tmdb.org";
    final _path = "t/p/w500$posterPath";
    var _uri = Uri.https(_authority, _path);
    return _uri;
  }
}
