
import 'dart:convert';

Credits creditsFromJson(String str) => Credits.fromJson(json.decode(str));

String creditsToJson(Credits data) => json.encode(data.toJson());

class Credits {
  Credits({
    required this.id,
    required this.cast,
    required this.crew,
  });

  int id;
  List<Cast> cast;
  List<Cast> crew;

  factory Credits.fromJson(Map<String, dynamic> json) => Credits(
    id: json["id"],
    cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
    crew: List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
    "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
  };
}

class Cast {
  Cast({
   // required this.adult,
    required this.gender,
    required this.id,
    //required this.knownForDepartment,
    required this.name,
    this.originalName,
    required this.popularity,
    this.profilePath,
     this.castId,
    this.character,
    this.creditId,
    this.order,
    //required this.department,
     this.job,
  });

 // bool adult;
  int gender;
  int id;
  //Department knownForDepartment;
  String name;
  String? originalName;
  double popularity;
  String? profilePath;
  int? castId;
  String? character;
  String? creditId;
  int? order;
  //Department department;
  String? job;

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
    //adult: json["adult"],
    gender: json["gender"],
    id: json["id"],
    //knownForDepartment: departmentValues.map[json["known_for_department"]]!,
    name: json["name"],
    originalName: json["original_name"]== null ? null : json["original_name"],
    popularity: json["popularity"].toDouble(),
    profilePath: json["profile_path"] == null ? null : json["profile_path"],
    castId: json["cast_id"] == null ? null : json["cast_id"],
    character: json["character"] == null ? null : json["character"],
    creditId: json["credit_id"],
    order: json["order"] == null ? null : json["order"],
    //department: departmentValues.map[json["department"]]!,
    job: json["job"] == null ? null : json["job"],
  );

  Map<String, dynamic> toJson() => {
   // "adult": adult,
    "gender": gender,
    "id": id,
   // "known_for_department": departmentValues.reverse[knownForDepartment],
    "name": name,
    "original_name": originalName,
    "popularity": popularity,
    "profile_path": profilePath,
    "cast_id":  castId,
    "character":  character,
    "credit_id": creditId,
    "order":  order,
  //  "department":  departmentValues.reverse[department],
    "job":  job,
  };
}

enum Department { ACTING, PRODUCTION, VISUAL_EFFECTS, CAMERA, SOUND, DIRECTING, WRITING, ART, EDITING, CREW, COSTUME_MAKE_UP, LIGHTING }

final departmentValues = EnumValues({
  "Acting": Department.ACTING,
  "Art": Department.ART,
  "Camera": Department.CAMERA,
  "Costume & Make-Up": Department.COSTUME_MAKE_UP,
  "Crew": Department.CREW,
  "Directing": Department.DIRECTING,
  "Editing": Department.EDITING,
  "Lighting": Department.LIGHTING,
  "Production": Department.PRODUCTION,
  "Sound": Department.SOUND,
  "Visual Effects": Department.VISUAL_EFFECTS,
  "Writing": Department.WRITING
});

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

   EnumValues(this.map);

  Map<T, String> get reverse {
    return reverseMap;
  }
}
