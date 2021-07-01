import 'dart:core';

import 'package:cinemapp_practice_project/models/MovieModel.dart';
import 'package:cinemapp_practice_project/models/SeriesModel.dart';


class MovieResponse {
  MovieResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x)))  ,
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

}
class SeriesResponse {
  SeriesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Series> results;
  int totalPages;
  int totalResults;

  factory SeriesResponse.fromJson(Map<String, dynamic> json) => SeriesResponse(
    page: json["page"],
    results: List<Series>.from(json["results"].map((x) => Series.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

}
