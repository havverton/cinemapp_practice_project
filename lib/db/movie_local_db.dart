import 'package:cinemapp_practice_project/models/MovieJSONModel.dart';
import 'package:cinemapp_practice_project/models/MovieModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> openDB() async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'movies_test1.db'),
    onCreate: (db, version) {
      db.execute("CREATE TABLE favorites("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          " title TEXT,"
          "runtime INTEGER,"
          " voteCount INTEGER,"
          "adult INTEGER,"
          "overview TEXT,"
          "genres TEXT,"
          "posterImg TEXT,"
          "isFavorite INTEGER,"
          "category INTEGER)");
      return db.execute("CREATE TABLE movies("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          " title TEXT,"
          "runtime INTEGER,"
          " voteCount INTEGER,"
          "adult INTEGER,"
          "overview TEXT,"
          "genres TEXT,"
          "posterImg TEXT,"
          "isFavorite INTEGER,"
          "category INTEGER)");
    },
    version: 2,
  );
  return database;
}
void createMovieTable() async {
  final db = await openDB();

      return await db.execute("CREATE TABLE movies("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          " title TEXT,"
          "runtime INTEGER,"
          " voteCount INTEGER,"
          "adult INTEGER,"
          "overview TEXT,"
          "genres TEXT,"
          "posterImg TEXT,"
          "isFavorite INTEGER,"
          "category INTEGER)");

}
void recreateTable()async {
  var db = await openDB();
  await db.execute("DROP TABLE IF EXISTS movies");
  createMovieTable();
}
Future<List<Movie>> getPopular() async{
  var database =  await openDB();
  final List<Map<String, dynamic>> maps = await  database.query('movies', columns: ['category'], where: '"category" = ?', whereArgs: ['1']);
  print("В базе популярных: ${maps.length}");
  return List<Movie>.generate(maps.length, (i) {
    print("${maps[i]}");
    return Movie(
        id: maps[i]['id'],
        title: maps[i]['title'],
        runtime: maps[i]['runtime'],
        voteCount: maps[i]['voteCount'],
        adult: maps[i]['adult'],
        overview: maps[i]['overview'],
        genres: maps[i]['genres'],
        posterImg: maps[i]['posterImg'],
        isFavorite: maps[i]['isFavorite'],
        category: maps[i]['category']
    );
  });
}
Future<List<Movie>> getTopRated() async{
  var database =  await openDB();
  final List<Map<String, dynamic>> maps = await  database.query('movies', columns: ['category'], where: '"category" = ?', whereArgs: ['2']);
  print("В базе популярных: ${maps.length}");
  return List<Movie>.generate(maps.length, (i) {
    print("${maps[i]}");
    return Movie(
        id: maps[i]['id'],
        title: maps[i]['title'],
        runtime: maps[i]['runtime'],
        voteCount: maps[i]['voteCount'],
        adult: maps[i]['adult'],
        overview: maps[i]['overview'],
        genres: maps[i]['genres'],
        posterImg: maps[i]['posterImg'],
        isFavorite: maps[i]['isFavorite'],
        category: maps[i]['category']
    );
  });
}


Future<void> insertList(List<Movie> movies, final database) async {
  final Database db = await database;
  for (var movie in movies) {
    await db.insert(
      'movies',
      movie.toDB(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}
  Future<void> insert(Movie movie, final database) async {
    final Database db = await database;
    await db.insert(
      'movies',
      movie.toDB(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
Future<void> addFavorites(Movie movie) async {
  final Database db = await openDB();
  await db.insert(
    'favorites',
    movie.toDB(),
    conflictAlgorithm: ConflictAlgorithm.ignore,
  );
}

Future<void> removeFromFavorites(Movie movie) async {
  final Database db = await openDB();
  await db.delete("favorites", where: 'title = ?', whereArgs: ['${movie.title}']);
  db.close();
}


  Future<List<Movie>> readDB(final database) async {
    // Get a reference to the database.
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('movies');
    print("В базе: ${maps.length}");
    return List<Movie>.generate(maps.length, (i) {
      return Movie(
          id: maps[i]['id'],
          title: maps[i]['title'],
          runtime: maps[i]['runtime'],
          voteCount: maps[i]['voteCount'],
          adult: maps[i]['adult'] == 1 ? true : false,
          overview: maps[i]['overview'],
          genres: maps[i]['genres'],
          posterImg: maps[i]['posterImg'],
          isFavorite: maps[i]['isFavorite'] == 1 ? true : false,
          category: maps[i]['category']
      );
    });
  }

Future<List<Movie>> readFavorites() async {
  // Get a reference to the database.
  final Database db = await openDB();
  final List<Map<String, dynamic>> maps = await db.query('favorites');
  print("В favorites: ${maps.length}");
  return List<Movie>.generate(maps.length, (i) {
    return Movie(
        id: maps[i]['id'],
        title: maps[i]['title'],
        runtime: maps[i]['runtime'],
        voteCount: maps[i]['voteCount'],
        adult: maps[i]['adult'] == 1 ? true : false,
        overview: maps[i]['overview'],
        genres: maps[i]['genres'],
        posterImg: maps[i]['posterImg'],
        isFavorite: maps[i]['isFavorite'] == 1 ? true : false,
        category: maps[i]['category']
    );
  });
}

Future<bool> isFavoriteMovie(MovieJSON movie) async{
  final Database db = await openDB();
  List<Map> list = await db.query('favorites', columns: ['title'], where: '"title" = ?', whereArgs: ['${movie.title}']);
  return list.length >0;
}