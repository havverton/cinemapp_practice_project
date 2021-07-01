// To parse this JSON data, do
//
//     final movie = movieFromJson(jsonString);

import 'package:cinemapp_practice_project/models/MovieModel.dart';

class Series {
  Series(
      {required this.backdropPath,
      required this.episodeRunTime,
      required this.genres,
      required this.id,
      //required this.inProduction,
      //required this.languages,
      //required this.lastAirDate,
      //required this.lastEpisodeToAir,
      required this.name,
      //this.nextEpisodeToAir,
      //required   this.networks,
      //required    this.numberOfEpisodes,
      // required this.numberOfSeasons,
      //required this.originCountry,
      //required this.originalLanguage,
      //required this.originalName,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.seasons,
      //required  this.spokenLanguages,
      // required  this.status,
      //required  this.tagline,
      // required  this.type,
      required this.voteAverage,
      required this.voteCount,
    //  this.isFavorite,
      this.mainGenres});

  String backdropPath;
  List<int> episodeRunTime;
  List<Genre> genres;
  int id;

  // bool inProduction;
  //List<String> languages;
  // DateTime lastAirDate;
  //LastEpisodeToAir lastEpisodeToAir;
  String name;

  //dynamic nextEpisodeToAir;
  //List<Network> networks;
  //int numberOfEpisodes;
  //int numberOfSeasons;
  //List<String> originCountry;
  //String originalLanguage;
  //String originalName;
  String overview;
  double popularity;
  String posterPath;
  List<Season> seasons;

  // List<SpokenLanguage> spokenLanguages;
  //String status;
  //String tagline;
  //String type;
  double voteAverage;
  int voteCount;
 // bool? isFavorite = false;
  String? mainGenres = "";

  factory Series.fromJson(Map<String, dynamic> json) => Series(
      backdropPath: json["backdrop_path"],
      episodeRunTime: json["episode_run_time"] == null
          ? List.empty()
          : List<int>.from(json["episode_run_time"].map((x) => x)),
      genres: json["genres"] == null
          ? List.empty()
          : List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
      id: json["id"],
      //inProduction: json["in_production"],
      //languages: List<String>.from(json["languages"].map((x) => x)),
      // lastAirDate: DateTime.parse(json["last_air_date"]),
      //  lastEpisodeToAir: LastEpisodeToAir.fromJson(json["last_episode_to_air"]),
      name: json["name"],
      //nextEpisodeToAir: json["next_episode_to_air"],
      // networks: List<Network>.from(json["networks"].map((x) => Network.fromJson(x))),
      // numberOfEpisodes: json["number_of_episodes"],
      // numberOfSeasons: json["number_of_seasons"],
      // originCountry: List<String>.from(json["origin_country"].map((x) => x)),
      //originalLanguage: json["original_language"],
      //originalName: json["original_name"],
      overview: json["overview"],
      popularity: json["popularity"].toDouble(),
      posterPath: json["poster_path"] == null ? '' : json["poster_path"],
      seasons: json["seasons"] == null
          ? List<Season>.empty()
          : List<Season>.from(json["seasons"].map((x) => Season.fromJson(x))),
      // status: json["status"],
      //tagline: json["tagline"],
      // type: json["type"],
      voteAverage: json["vote_average"].toDouble(),
      voteCount: json["vote_count"],
     // isFavorite: false,
      mainGenres: "");
}

class LastEpisodeToAir {
  LastEpisodeToAir({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  DateTime airDate;
  int episodeNumber;
  int id;
  String name;
  String overview;
  String productionCode;
  int seasonNumber;
  String? stillPath;
  int voteAverage;
  int voteCount;

  factory LastEpisodeToAir.fromJson(Map<String, dynamic> json) =>
      LastEpisodeToAir(
        airDate: DateTime.parse(json["air_date"]),
        episodeNumber: json["episode_number"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "air_date":
            "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
        "episode_number": episodeNumber,
        "id": id,
        "name": name,
        "overview": overview,
        "production_code": productionCode,
        "season_number": seasonNumber,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

class Network {
  Network({
    required this.name,
    required this.id,
    required this.logoPath,
    required this.originCountry,
  });

  String name;
  int id;
  String logoPath;
  String originCountry;

  factory Network.fromJson(Map<String, dynamic> json) => Network(
        name: json["name"],
        id: json["id"],
        logoPath: json["logo_path"],
        originCountry: json["origin_country"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "logo_path": logoPath,
        "origin_country": originCountry,
      };
}

class Season {
  Season({
   // required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  //DateTime airDate;
  int episodeCount;
  int id;
  String name;
  String? overview;
  String posterPath;
  int seasonNumber;

  factory Season.fromJson(Map<String, dynamic> json) => Season(
        //airDate: DateTime.parse(json["air_date"]),
        episodeCount: json["episode_count"],
        id: json["id"],
        name: json["name"] == null ? "" : json["name"],
        overview: json["overview"] ,
        posterPath: json["poster_path"] == null ? "" : json["poster_path"],
        seasonNumber: json["season_number"],
      );

 /* Map<String, dynamic> toJson() => {
      //  "air_date":
       //     "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
        "episode_count": episodeCount,
        "id": id,
        "name": name,
        "overview": overview,
       // "poster_path": posterPath,
        "season_number": seasonNumber,
      };*/
}

class SpokenLanguage {
  SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  String englishName;
  String iso6391;
  String name;

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
        englishName: json["english_name"],
        iso6391: json["iso_639_1"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "english_name": englishName,
        "iso_639_1": iso6391,
        "name": name,
      };
}
