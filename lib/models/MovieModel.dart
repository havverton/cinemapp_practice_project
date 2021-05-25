class Movie {
  Movie(
      {required this.adult,
      required this.genres,
        this.mainGenres,
      required this.movieId,
      required this.overview,
      //this.popularity,
      required this.runtime,
      required this.title,
      this.posterPath,
      required this.voteCount,
      required this.isFavorite,
      this.backdropPath,
      this.poster,
      this.backdrop});

  bool adult = false;
  bool isFavorite = false;
  List<Genre>? genres;
  String? mainGenres;
  int movieId;
  String overview = "";
  int runtime = 0;
  String title = "";
  String? posterPath;
  int voteCount = 0;
  String? backdropPath;
  String? poster;
  String? backdrop;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        adult: json["adult"],
        genres: json["genres"] == null ? null : List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        movieId: json["id"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        backdropPath: json["backdrop_path"],
        runtime: json["runtime"] == null ? 0 : json["runtime"],
        title: json["title"] == null ? null : json["title"],
        voteCount: json["vote_count"] == null ? null : json["vote_count"],
        isFavorite: false,
      );

  Map<String, dynamic> toDB() => {
        "movie_id": movieId,
        "runtime": runtime,
        "title": title,
        "voteCount": voteCount,
        "adult": adult == true ? 1 : 0,
        "mainGenres": mainGenres,
        "overview": overview,
        //"voteAverage": voteAverage == null ? null : voteAverage,
        "isFavorite": isFavorite == true ? 1 : 0,
        "poster": poster,
        "backdrop": backdrop
      };
}

class Genre {
  Genre({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

enum Category { popular, top_rated, upcoming, nothing }
