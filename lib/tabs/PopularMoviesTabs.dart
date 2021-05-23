import 'dart:io';

import 'package:cinemapp_practice_project/BLoC/movie_card_bloc.dart';
import 'package:cinemapp_practice_project/BLoC/movies_bloc.dart';
import 'package:cinemapp_practice_project/BLoC/movies_events_bloc.dart';
import 'package:cinemapp_practice_project/BLoC/movies_states_bloc.dart';
import 'package:cinemapp_practice_project/MovieCardWidget.dart';
import 'package:cinemapp_practice_project/models/MovieModel.dart';
import 'package:cinemapp_practice_project/services/MovieRepository.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMovieTab extends StatefulWidget {
  @override
  _PopularMovieTabState createState() => _PopularMovieTabState();
}

class _PopularMovieTabState extends State<PopularMovieTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  int currentPage = 1;


  List<Movie> movieList = [];
  bool preload = false;
  var isConnected = false;

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  void checkConnection() async {
    try {
      final response = await InternetAddress.lookup("google.com");
      if (response.isNotEmpty) isConnected = true;
    } on SocketException catch (err) {
      isConnected = false;
    }
  }

  MovieRepository movieRepository = MovieRepository();

  Widget build(BuildContext context) {
    final MoviePopularBLoC movieBloc = BlocProvider.of<MoviePopularBLoC>(context);
    if (!preload) {
      movieBloc.add(MovieLoadPopularEvent());
      preload = true;
    }
    return BlocBuilder<MoviePopularBLoC, MoviesState>(builder: (context, state) {
      if (state is MoviesEmptyListState) {
        return Center(
          child: Text("Что то пошло не так"),
        );
      } else if (state is MoviesLoadingListState){
        return Center(child: CircularProgressIndicator());
      }else if (state is MoviesLoadedListState) {
        movieList.addAll(state.loadedMovies);
      }

      return GridView.builder(
          controller: _scrollController(movieBloc),
          dragStartBehavior: DragStartBehavior.down,
          itemBuilder: (context, index) {
            var movie = movieList[index];

            return  BlocProvider<MovieCardFavoriteBLoC>(
                create: (context) => MovieCardFavoriteBLoC(movieRepository),
                child: MovieCardWidget(movie));
            },

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.635,
            mainAxisSpacing: 15.0,
          ),
          itemCount: movieList.length,
          physics: BouncingScrollPhysics());
    });
  }

  ScrollController _scrollController(MoviePopularBLoC movieBloc) {
    ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("LOADING");

        int page = movieList.length == 0 ? 1 : (movieList.length ~/ 20) + 1;
        print("Current page: $page");
        movieBloc.add(MovieLoadPopularEvent(page: page));
      }
    });
    return _scrollController;
  }

/*Widget FutureMovieBuilder(BuildContext context, int index, int typeID) {
       Future<Movie> getMovie(int index) async {
      return moviePopularList[index];
    }

    return FutureBuilder<Movie>(
      future: getMovie(index),
      builder: (context, snapshot) {
        final movie = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (!snapshot.hasData) {
              print("YES YES YES ${snapshot.data}");
              return Text("No data");
            } else {
              return MovieCardWidget(movie);
            }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }*/
}
