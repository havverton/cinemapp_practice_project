import 'dart:core';

import 'package:cinemapp_practice_project/models/MovieModel.dart';


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

/*  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };*/
}
