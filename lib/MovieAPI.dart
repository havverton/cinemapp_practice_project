import 'dart:convert';

import 'package:cinemapp_practice_project/models/MovieModel.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

import 'models/CreditsModel.dart';
import 'models/MovieModel.dart';
import 'models/MovieResponseModel.dart';

class MovieApi {
  static const apikey = "6e466b67854a32b973cf8e3f9dc31068";

  static Future<List<Movie>> getResponse() async {
    // final url =
    //     "https://api.themoviedb.org/3/movie/popular?api_key=6e466b67854a32b973cf8e3f9dc31068&language=en-US&page=1";
    final _authority = "api.themoviedb.org";
    final _path = "/3/movie/popular";
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

  static Future<String> getJson() {
    return rootBundle.loadString('assets/test.json');
  }

  static Future<List<Movie>> getLocal() async {
    final body = await json.decode(await MovieApi.getJson());
//print("Body: $body");
    var answer = MovieResponse.fromJson(body);
    return answer.results;
  }

  static Future<List<int>> getPopularIDs() async {
   final _authority = "api.themoviedb.org";
    final _path = "/3/movie/popular";
    final _params = {
      "api_key": "6e466b67854a32b973cf8e3f9dc31068",
      "language": "en-US",
      "page": "1"
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

  static Future<List<Movie>> getPopularInfo() async {
    List<int> idList = await MovieApi.getPopularIDs();
    List<Movie> movieList = [];
    for (var id in idList) {
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
      movieList.add(answer);
    }
    return movieList;
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
}
