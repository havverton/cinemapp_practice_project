import 'dart:io';

import 'package:cinemapp_practice_project/MovieCardWidget.dart';
import 'package:cinemapp_practice_project/db/movie_local_db.dart' as popularDB;
import 'package:cinemapp_practice_project/models/MovieModel.dart';
import 'package:cinemapp_practice_project/models/MovieProvider.dart';
import 'package:cinemapp_practice_project/network/MovieAPI.dart';
import 'package:flutter/material.dart';

class PopularMovieTab extends StatefulWidget {
  @override
  _PopularMovieTabState createState() => _PopularMovieTabState();
}

class _PopularMovieTabState extends State<PopularMovieTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final database = popularDB.openDB();
  int currentPage = 1;
  List<int> popularIDs = [];
  List<Movie> moviePopularList = [];
  bool preload = false;
  var isConnected = false;

  @override
  void initState() {
    super.initState();
    checkConnection();
    fetchMovies();
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

    if (popularIDs.isEmpty && !preload) {

      preload = true;
    }

    var builder = GridView.builder(
        controller: _scrollController(1),
        itemBuilder: (context, index) {
          return FutureMovieBuilder(context, index, 1);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.635,
          mainAxisSpacing: 15.0,
        ),
        itemCount: popularIDs.length,
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
      movie = await MovieProvider().getPopular(id);
      temp.add(movie);
      //await popularDB.insert(movie, database);
    }));
    print("Попавсиbb");
    setState(() {
      this.moviePopularList.addAll(temp);
    });
  }

  Widget FutureMovieBuilder(BuildContext context, int index, int typeID) {
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
  }

  Future<List<int>> _fetchPopular() async {
    //popularDB.openDB();
    var list = await MovieApi.getPopularIDs(
        popularIDs.isEmpty ? 1 : (popularIDs.length ~/ 20) + 1);

    print("ID загружены поп");
    //_fetchMoviesToList(1,list);
    setState(() {
      print("${list.length} ${popularIDs.length}");
      popularIDs.addAll(list);
    });
    return list;
  }

  void fetchMovies() async {
    var list = await _fetchPopular();
    _fetchMoviesToList(1, list);
  }
}
