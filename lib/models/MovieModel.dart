class Movie {
  Movie(
      {required this.adult,
      this.genres,
        this.mainGenres,
      required this.movieId,
      required this.overview,
      required this.runtime,
      required this.title,
      this.posterPath,
      this.voteCount,
      required this.voteAverage,
      required this.isFavorite,
      this.backdropPath,
      this.poster,
      this.backdrop});

  bool adult;
  bool isFavorite;
  List<Genre>? genres;
  String? mainGenres;
  int movieId;
  String overview ;
  int runtime ;
  String title = "";
  String? posterPath;
  double voteAverage;
  int? voteCount;
  String? backdropPath;
  String? poster;
  String? backdrop;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        adult: json["adult"]  == null ? false : json["adult"],
        genres: json["genres"] == null ? List.empty() : List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        movieId: json["id"] == null ? 0 : json['id'],
        overview: json["overview"] == null ? '' : json['overview'],
        posterPath: json["poster_path"],
        backdropPath: json["backdrop_path"],
        runtime: json["runtime"] == null ? 0 : json["runtime"],
        title: json["title"] == null ? '' : json["title"],
        voteCount: json["vote_count"],
        voteAverage: json["vote_average"] is int ? json["vote_average"].toDouble() : json["vote_average"],
        isFavorite: false,
      );

  Map<String, dynamic> toDB() => {
        "movie_id": movieId,
        "runtime": runtime,
        "title": title,
        "voteCount": voteCount,
        "voteAverage": voteAverage,
        "adult": adult == true ? 1 : 0,
        "mainGenres": mainGenres,
        "overview": overview,
        "posterPath" : posterPath,
        "voteAverage": voteAverage ,
        "isFavorite": isFavorite == true ? 1 : 0,
        "poster": poster,
        "backdrop": backdrop,
        "backdropPath" : ""
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
