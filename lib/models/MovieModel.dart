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
    this.posterPath,
    this.voteCount,
    this.category
  });


  bool adult = false;
  String genres;
  int id;
  String overview = "";
  int runtime = 0;
  String title = "";
  String posterPath;
  int voteCount = 0;
  Category category = Category.nothing;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
      adult: json["adult"] == null ? null : json["adult"],
      genres: json["genres"] == null
          ? null
          : List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x)))
              .toString(),
      id: json["id"] == null ? null : json["id"],
      overview: json["overview"] == null ? null : json["overview"],
    posterPath : json["poster_path"] == null ? null : json["poster_path"],
      runtime: json["runtime"] == null ? null : json["runtime"],
      title: json["title"] == null ? null : json["title"],
      voteCount: json["vote_count"] == null ? null : json["vote_count"],
    );


  Map<String, dynamic> toDB() => {
    "runtime": runtime == null ? null : runtime,
    "title": title == null ? null : title,
    "voteCount": voteCount == null ? null : voteCount,
    "adult": adult == true ? 1 : 0,
    "genres": genres == null ? null : genres,
    "overview": overview == null ? null : overview,
    //"voteAverage": voteAverage == null ? null : voteAverage,
    "category": category == null? null : category.toString(),
  };
}


class Genre {
  Genre({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}

enum Category{popular,top_rated, upcoming, nothing}