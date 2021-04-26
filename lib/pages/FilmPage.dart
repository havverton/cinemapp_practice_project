
import 'package:cinemapp_practice_project/MovieCardWidget.dart';
import 'package:cinemapp_practice_project/models/MovieModel.dart';
import 'package:cinemapp_practice_project/models/MovieProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cinemapp_practice_project/db/popular_db.dart' as popularDB;
import 'package:sqflite/sqflite.dart';




class FilmPage extends StatefulWidget {
  @override
  _FilmPageState createState() => _FilmPageState();
}
class _FilmPageState extends State<FilmPage>{

  final database = popularDB.openDB();
  Future<List<Movie>> testtest() async{
  var test = popularDB.readDB(database);
  return  test;
}

  void storeMovie(List<Movie> movies) {
    popularDB.insert(movies, database);
  }
  @override
  Widget build(BuildContext context) =>
      Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 5),
          color: Color(0xFF191926),
          child: FutureBuilder<List<Movie>>(
            //future: testtest(),
            future: MovieProvider().getPopular(),
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
