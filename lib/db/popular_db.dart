import 'package:cinemapp_practice_project/models/MovieJSONModel.dart';
import 'package:cinemapp_practice_project/models/MovieModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


  Future<Database> openDB() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'popular_movie4.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE popular12("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              " title TEXT,"
              "runtime INTEGER,"
              " voteCount INTEGER,"
              "adult TEXT,"
          "overview TEXT,"
          //"popularity REAL,"
          //"voteAverage INTEGER,"
          "genres TEXT,"
          "posterImg TEXT)"

        );
      },
      version: 1,
    );
    return database;
  }
  Future<void> insert(List<Movie> movies, final database) async {
    final Database db = await database;
    for(var movie in movies){
    await db.insert(
      'popular12',
      movie.toDB(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}

  Future<List<Movie>> readDB(final database) async {
    // Get a reference to the database.
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('popular12');
    print("В базе: ${maps.length}");
    return List<Movie>.generate(maps.length, (i) {
        return Movie(
        id: maps[i]['id'],
        title: maps[i]['title'],
        runtime: maps[i]['runtime'],
        voteCount: maps[i]['voteCount'],
        adult: maps[i]['adult'],
        overview: maps[i]['overview'],
       // popularity: maps[i]['popularity'],
        genres: maps[i]['genres'],
        posterImg: maps[i]['posterImg'],
      );
    }
    );
  }
