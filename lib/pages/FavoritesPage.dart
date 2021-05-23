import 'package:cinemapp_practice_project/BLoC/movie_card_bloc.dart';
import 'package:cinemapp_practice_project/MovieCardWidget.dart';
import 'package:cinemapp_practice_project/db/movie_local_db.dart' as favDB;
import 'package:cinemapp_practice_project/models/MovieModel.dart';
import 'package:cinemapp_practice_project/services/MovieRepository.dart';
import 'package:cinemapp_practice_project/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final database = favDB.readFavorites();
  MovieRepository movieRepository = MovieRepository();


  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          color: kMainBackGrndColor,
          child: FutureBuilder<List<Movie>>(
            future: favDB.readFavorites(),
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
                    print("${movies.length} ");

                    return buildMovies(movies);
                  }
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      );

  Widget buildMovies(List<Movie> movies) => GridView.builder(
      itemBuilder: (context, index) {
        final movie = movies[index];
        //storeMovie(movie);
        return  BlocProvider<MovieCardFavoriteBLoC>(
            create: (context) => MovieCardFavoriteBLoC(movieRepository),
            child: MovieCardWidget(movie));
      },

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.635,
        mainAxisSpacing: 15.0,
      ),
      itemCount: movies.length,
      physics: BouncingScrollPhysics());
}
