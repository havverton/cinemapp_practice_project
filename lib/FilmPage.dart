import 'package:cinemapp_practice_project/MovieAPI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MovieCardWidget.dart';
import 'models/MovieModel.dart';

class FilmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 5),
          color: Colors.black54,
          child: FutureBuilder<List<Movie>>(
            future: MovieApi.getPopularInfo(),
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
        return MovieCardWidget2(movie);
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.635,
        mainAxisSpacing: 15.0,
      ),
      itemCount: movies.length,
      physics: BouncingScrollPhysics());
}
