import 'dart:io';

import 'package:cinemapp_practice_project/MovieCardWidget.dart';
import 'package:cinemapp_practice_project/db/movie_local_db.dart' as popularDB;
import 'package:cinemapp_practice_project/models/MovieModel.dart';
import 'package:cinemapp_practice_project/models/MovieProvider.dart';
import 'package:cinemapp_practice_project/network/MovieAPI.dart';
import 'package:flutter/material.dart';

class TopRatedMovieTab extends StatefulWidget {
  @override
  _TopRatedMovieTabState createState() => _TopRatedMovieTabState();
}

class _TopRatedMovieTabState extends State<TopRatedMovieTab> with AutomaticKeepAliveClientMixin{
  final database = popularDB.openDB();
  int currentPage = 1;
  List<int> topRatedIDs = [];
  List<Movie> movieTopRatedList = [];
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

  Widget build(BuildContext context) {
    var circular = Center(
      child: CircularProgressIndicator(),
    );

    if (topRatedIDs.isEmpty && !preload) {
      fetchMovies();
      preload = true;
    }

    var builder = GridView.builder(
        controller: _scrollController(2),
        itemBuilder: (context, index) {
          return FutureMovieBuilder(context, index, 2);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.635,
          mainAxisSpacing: 15.0,
        ),
        itemCount: topRatedIDs.length,
        physics: BouncingScrollPhysics());
    return builder;
  }

  ScrollController _scrollController(int typeID) {
    ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("LOADING");
        fetchMovies();
      }
    });
    return _scrollController;
  }

  void _fetchMoviesToList(int typeID, List<int> list) async {
    List<Movie> temp = [];
    await Future.wait(list.map((id) async {
      var movie;
      movie = await MovieProvider().getTopRated(id);
      temp.add(movie);
      //await popularDB.insert(movie, database);
    }));
    print("Попавсиbb");
    setState(() {
      this.movieTopRatedList.addAll(temp);
    });
  }

  Widget FutureMovieBuilder(BuildContext context, int index, int typeID) {
       Future<Movie> getMovie(int index) async {
      return movieTopRatedList[index];
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
  }

  Future<List<int>> _fetchPopular() async {
    //popularDB.openDB();
    var list = await MovieApi.getPopularIDs(
        topRatedIDs.isEmpty ? 1 : (topRatedIDs.length ~/ 20) + 1);

    print("ID загружены поп");
    //_fetchMoviesToList(1,list);
    setState(() {
      print("${list.length} ${topRatedIDs.length}");
      topRatedIDs.addAll(list);
    });
    return list;
  }

  void fetchMovies() async {
    var list = await _fetchPopular();
    _fetchMoviesToList(2, list);
  }

  @override
  bool get wantKeepAlive => true;
}
