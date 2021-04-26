import 'dart:core';

import 'MovieJSONModel.dart';

class MovieResponse {
  MovieResponse({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int page;
  List<MovieJSON> results;
  int totalPages;
  int totalResults;

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
        page: json["page"],
        results:
            List<MovieJSON>.from(json["results"].map((x) => MovieJSON.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
