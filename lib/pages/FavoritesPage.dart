
import 'package:cinemapp_practice_project/MovieCardWidget.dart';
import 'package:cinemapp_practice_project/models/MovieModel.dart';
import 'package:cinemapp_practice_project/models/MovieProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cinemapp_practice_project/db/favorites_db.dart' as favDB;
import 'package:sqflite/sqflite.dart';




class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}
class _FavoritesPageState extends State<FavoritesPage>{

  final database = favDB.openFavoritesDB();
  Future<List<Movie>> testtest() async{
  var test = favDB.readDB(database);
  return  test;
}
  @override
  Widget build(BuildContext context) =>
      Scaffold(
        body: Container(
          color: Color(0xFF191926),
          child: FutureBuilder<List<Movie>>(
            future:  favDB.readDB(database),
            //future: MovieProvider().getPopular(),
            builder: (context, snapshot) {
              final movies = snapshot.data;
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.none:
                  print("no data");
                  break;
                case ConnectionState.active:

                  print("no data1");
                  break;

                case ConnectionState.done:
                  if (!snapshot.hasData) {
                    print("YES YES YES ${snapshot.data}");

                    return Text("No data");
                  } else {
                    print("${movies.length}");
                    //storeMovie(movies);
                    //read(database);
                    return buildMovies(movies);
                  }
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      );

  Widget buildMovies(List<Movie> movies) =>
      GridView.builder(
          itemBuilder: (context, index) {
            final movie = movies[index];
            //storeMovie(movie);
            return MovieCardWidget(movie);
          },

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.635,
            mainAxisSpacing: 15.0,
          ),
          itemCount: movies.length,
          physics: BouncingScrollPhysics());

}
