import 'dart:io';

import 'package:cinemapp_practice_project/db/movie_local_db.dart' as popularDB;
import 'package:cinemapp_practice_project/models/MovieModel.dart';
import 'file:///D:/Flutter_Projects/cinemapp_practice_project/lib/shit/MovieProvider.dart';
import 'package:cinemapp_practice_project/network/MovieAPI.dart';
import 'package:cinemapp_practice_project/tabs/PopularMoviesTabs.dart';
import 'package:cinemapp_practice_project/tabs/TopRatedMoviesTabs.dart';
import 'package:cinemapp_practice_project/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'file:///D:/Flutter_Projects/cinemapp_practice_project/lib/MovieCardWidget.dart';

class FilmPage extends StatefulWidget {
  @override
  _FilmPageState createState() => _FilmPageState();
}

class _FilmPageState extends State<FilmPage>{
  final database = popularDB.openDB();
  int currentPage = 1;
  List<int> popularIDs = [];
  List<int> topRatedIDs = [];
  List<Movie> moviePopularList = [];
  List<Movie> movieTopRatedList = [];
  bool preload = false;
  String currentTab = "Popular";
  var isConnected = false;

 /* Widget FutureMovieBuilder(BuildContext context, int index, int typeID) {
    var currentList = [];
    switch (typeID){
       case 1:
         currentList = moviePopularList;
         break;

         case 2: currentList = movieTopRatedList;
         break;
     }

    
    Future<Movie> getMovie(int index)async{
      switch(typeID){
        case 1: return moviePopularList[index]; break;
        case 2: return movieTopRatedList[index]; break;}
        }


    return FutureBuilder<Movie>(
      future:  getMovie(index),
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


  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            height: 44,
            color: kMainBackGrndColor,
          ),
          Container(
            height: 40,
            color: kMainBackGrndColor,
            child: Text("Cinemapp"),
          ),
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Scaffold(
                  backgroundColor: kMainBackGrndColor,
                  appBar: TabBar(
                    labelColor: const Color(0xffacb3bf),
                    unselectedLabelColor: const Color(0xff525c6e),
                    indicatorColor: Colors.red,
                    tabs: [
                      Tab(
                        child: Text("Popular"),
                      ),
                      Tab(
                        child: Text("Top Rated"),
                      ),
                      Tab(
                        child: Text("Upcoming"),
                      ),
                    ],
                  ),
                  body: Container(
                    color: kMainBackGrndColor,
                    child: TabBarView(
                      children: [
                        PopularMovieTab(),
                        TopRatedMovieTab(),
                        PopularMovieTab(),
                      ],
                    ),
                  )),
            ),
          ),
        ],
      );


  void clearDB(){
    popularDB.recreateTable();
  }
/*
  void _fetchPopularMovies() {
    popularDB.openDB();
    MovieApi.getPopularIDs(currentPage).then((list) {
      print("ID загружены поп");
      _fetchMoviesToList(1,list);
      popularIDs.addAll(list);
    });


  }*/

/*
  void _fetchTopRatedMovies() {
    popularDB.openDB();
    MovieApi.getTopRatedIDs(currentPage).then((list) => setState(() {
          print("ID загружены топ");
          topRatedIDs.addAll(list);
          topRatedIDs.forEach((element) async{
            var movie = await MovieProvider().getTopRated(element);
            movieTopRatedList.add(movie);
            await  popularDB.insert(movie, database);
          });
        }));
  }
*/


/*  void checkConnection() async {
    try {
      final response = await InternetAddress.lookup("google.com");
      if (response.isNotEmpty)
        setState(() {
          isConnected = true;
        });
    } on SocketException catch (err) {
      setState(() {
        isConnected = false;
      });
    }
  }*/


  /*void _fetchMoviesToList(int typeID, List<int> list){
    List<Movie> temp = [];
    list.forEach((element) async {
      var movie;
      switch(typeID){
        case 1: movie = await  MovieProvider().getPopular(element); break;
        case 2: movie = await  MovieProvider().getTopRated(element); break;
      }
      temp.add(movie);
      await popularDB.insert(movie, database);
      if (list.last == element) {
        print("Попавси");
        setState(() {
          this.moviePopularList.addAll(temp);
        });
      }
    });

  }*/
}
