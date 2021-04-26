import 'dart:typed_data';


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
    this.isFavorite
  });


  bool adult = false;
  String genres;
  int id;
  String overview = "";
  int runtime = 0;
  String title = "";
  //double voteAverage = 0.0;
  int voteCount = 0;
  Uint8List posterImg;
  bool isFavorite = false;

  Map<String, dynamic> toDB() => {
    "runtime": runtime == null ? null : runtime,
    "title": title == null ? null : title,
    "voteCount": voteCount == null ? null : voteCount,
    "adult": adult == null ? null : adult,
    "genres": genres == null ? null : genres,
    "overview": overview == null ? null : overview,
    //"voteAverage": voteAverage == null ? null : voteAverage,
    "posterImg": posterImg == null ? null : posterImg,
    "isFavorite": isFavorite == true ? 1 : 0,
  };
}