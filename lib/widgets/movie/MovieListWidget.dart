import 'dart:io';

import 'package:cinemapp_practice_project/BLoC/movies/movies_bloc.dart';
import 'package:cinemapp_practice_project/BLoC/movies/movies_events_bloc.dart';
import 'package:cinemapp_practice_project/BLoC/movies/movies_states_bloc.dart';
import 'package:cinemapp_practice_project/models/MovieModel.dart';
import 'package:cinemapp_practice_project/services/MovieRepository.dart';
import 'package:cinemapp_practice_project/widgets/movie/MovieCardWidget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieListWidget extends StatefulWidget {
  final int typeID;

  MovieListWidget(this.typeID);

  @override
  _MovieListWidgetState createState() => _MovieListWidgetState(this.typeID);
}

class _MovieListWidgetState extends State<MovieListWidget>
    with AutomaticKeepAliveClientMixin {
  int typeID;
  bool isLoading = false;
  _MovieListWidgetState(this.typeID);

  @override
  bool get wantKeepAlive => true;
  MovieRepository movieRepository = MovieRepository();
  List<Movie> movieList = [];
  var isConnected = false;

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  void checkConnection() async {
    try {
      final response = await InternetAddress.lookup("google.com");
      if (response.isNotEmpty)
        setState(() {
          isConnected = true;
        });
    } on SocketException catch (_) {
      isConnected = false;
    }
  }

  Widget build(BuildContext context) {
    return BlocProvider<MovieListBLoC>(
        create: (context) => MovieListBLoC(movieRepository),
        child: Builder(builder: (providerContext) {
          if (isConnected) {
            MovieListBLoC movieBloc = BlocProvider.of<MovieListBLoC>(
                providerContext);
            switch (typeID) {
              case 1:
                movieBloc.add(MovieLoadPopularEvent(page: 1));
                break;
              case 2:
                movieBloc.add(MovieLoadTopRatedEvent(page: 1));
                break;
              case 3:
                movieBloc.add(MovieLoadUpcomingEvent(page: 1));
                break;
            }

            return BlocBuilder<MovieListBLoC, MovieListState>(
                builder: (context, state) {
                  if (state is MoviesEmptyListState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MoviesLoadingListState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is MoviesLoadedListState) {
                    movieList.addAll(state.loadedMovies);
                  } else if (state is MoviesListErrorState) {
                    Text("Непредвиденная ошибка. ");
                  }

                  return
                      GridView.builder(
                          controller: _scrollController(movieBloc),
                          dragStartBehavior: DragStartBehavior.down,
                          itemBuilder: (context, index) {

                            var movie = movieList[index];
                            return MovieCardWidget(movie);
                          },
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.635,
                            mainAxisSpacing: 15.0,
                          ),
                          itemCount: movieList.length,
                          physics: BouncingScrollPhysics());


                });
          } else {
            return Center(
              child: Text("Проверьте подключение к интернету"),
            );
          }
        }));
  }

  ScrollController _scrollController(MovieListBLoC movieBloc) {
    ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent && !isLoading) {
        isLoading = true;
      }else{
        isLoading = false;
      }
      if (isLoading) {
        print("LOADING");

        int page = movieList.length == 0 ? 1 : (movieList.length ~/ 20) + 1;
        print("Current page: $page");
        switch (typeID) {
          case 1:
            movieBloc.add(MovieLoadPopularEvent(page: page));
            break;
          case 2:
            movieBloc.add(MovieLoadTopRatedEvent(page: page));
            break;
          case 3:
            movieBloc.add(MovieLoadUpcomingEvent(page: page));
            break;
        }
          isLoading = false;
      }
    });
    return _scrollController;
  }
}
