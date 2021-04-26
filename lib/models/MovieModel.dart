import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

class Movie{
  Movie({
    this.adult,
    this.genres,
    this.id,
    this.overview,
    //this.popularity,
    this.runtime,
    this.title,
    //this.voteAverage,
    this.voteCount,
    this.posterImg,
  });


  bool adult = false;
  String genres;
  int id;
  String overview = "";
  //double popularity = 0.0;
  int runtime = 0;
  String title = "";
  //double voteAverage = 0.0;
  int voteCount = 0;
  Uint8List posterImg;

  Map<String, dynamic> toDB() => {
    "runtime": runtime == null ? null : runtime,
    "title": title == null ? null : title,
    "voteCount": voteCount == null ? null : voteCount,
    //"adult": voteCount == null ? null : adult,
    "genres": genres == null ? null : genres,
    "overview": overview == null ? null : overview,
    //"popularity": popularity == null ? null : popularity,
    //"voteAverage": voteAverage == null ? null : voteAverage,
    "posterImg": posterImg == null ? null : posterImg,
  };
}