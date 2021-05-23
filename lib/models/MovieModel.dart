import 'dart:typed_data';

class Movie {
  Movie(
      {this.adult,
      this.genres,
      this.movie_id,
      this.overview,
      //this.popularity,
      this.runtime,
      this.title,
      this.posterPath,
      this.voteCount,
      this.category,
      this.isFavorite,
      this.backdropPath,
      this.poster,
      this.backdrop});

  bool adult = false;
  bool isFavorite = false;
  String genres;
  int movie_id;
  String overview = "";
  int runtime = 0;
  String title = "";
  String posterPath;
  int voteCount = 0;
  String backdropPath;
  String poster;
  String backdrop;
  Category category = Category.nothing;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        adult: json["adult"] == null ? null : json["adult"],
        genres: json["genres"] == null
            ? null
            : List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x)))
                .first.name,
        movie_id: json["id"] == null ? null : json["id"],
        overview: json["overview"] == null ? null : json["overview"],
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
        backdropPath: json["backdrop_path"] == null ? null : json["backdrop_path"],
        runtime: json["runtime"] == null ? null : json["runtime"],
        title: json["title"] == null ? null : json["title"],
        voteCount: json["vote_count"] == null ? null : json["vote_count"],

        isFavorite: false,
      );

  Map<String, dynamic> toDB() => {
        "movie_id": movie_id == null ? null : movie_id,
        "runtime": runtime == null ? null : runtime,
        "title": title == null ? null : title,
        "voteCount": voteCount == null ? null : voteCount,
        "adult": adult == true ? 1 : 0,
        "genres": genres == null ? null : genres,
        "overview": overview == null ? null : overview,
        //"voteAverage": voteAverage == null ? null : voteAverage,
        "category": category == null ? null : category.toString(),
        "isFavorite": isFavorite == true ? 1 : 0,
        "poster" : poster == null ? null : poster,
        "backdrop" : backdrop == null ? null : backdrop
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

enum Category { popular, top_rated, upcoming, nothing }
