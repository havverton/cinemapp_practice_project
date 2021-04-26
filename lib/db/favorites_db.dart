import 'package:cinemapp_practice_project/models/MovieJSONModel.dart';
import 'package:cinemapp_practice_project/models/MovieModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> openFavoritesDB() async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'movies_favorites.db'),
    onCreate: (db, version) {
      return db.execute("CREATE TABLE favorites("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "title TEXT,"
          "runtime INTEGER,"
          "voteCount INTEGER,"
          "adult TEXT,"
          "overview TEXT,"
          "genres TEXT,"
          "posterImg TEXT,"
          "isFavorite INTEGER)");
    },
    version: 1,
  );
  return database;
}

Future<void> insert(Movie movie) async {
  final Database db = await openFavoritesDB();
    await db.insert(
      'favorites',
      movie.toDB(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    db.close();
}
Future<void> deleteMovie(Movie movie) async {
  final Database db = await openFavoritesDB();
  await db.delete("favorites", where: 'title = ?', whereArgs: ['${movie.title}']);
  db.close();
}



Future<List<Movie>> readDB(final database) async {
  // Get a reference to the database.
  final Database db = await database;
  final List<Map<String, dynamic>> maps = await db.query('favorites');
  print("В базе: ${maps.length}");
  return List<Movie>.generate(maps.length, (i) {
    return Movie(
      id: maps[i]['id'],
      title: maps[i]['title'],
      runtime: maps[i]['runtime'],
      voteCount: maps[i]['voteCount'],
      adult: maps[i]['adult'],
      overview: maps[i]['overview'],
      genres: maps[i]['genres'],
      posterImg: maps[i]['posterImg'],
      isFavorite: (maps[i]['isFavorite']) == 1 ? true : false
    );
  });
}
Future<bool> isFavoriteMovie(final database, MovieJSON movie) async{
  final Database db = await database;
  List<Map> list = await db.query('favorites', columns: ['title'], where: '"title" = ?', whereArgs: ['${movie.title}']);
  return list.length >0;
}
