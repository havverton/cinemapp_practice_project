import 'package:cinemapp_practice_project/MovieCardWidget.dart';
import 'package:cinemapp_practice_project/db/popular_db.dart' as popularDB;
import 'package:cinemapp_practice_project/models/MovieModel.dart';
import 'package:cinemapp_practice_project/models/MovieProvider.dart';
import 'package:cinemapp_practice_project/network/MovieAPI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilmPage extends StatefulWidget {
  @override
  _FilmPageState createState() => _FilmPageState();
}

class _FilmPageState extends State<FilmPage> {
  final database = popularDB.openDB();
  int currentPage = 1;
  List<Movie> moviesList = [];

  List<int> moviesID = [];

  Widget FutureMovieBuilder(BuildContext context, int index) {
    return FutureBuilder<Movie>(
      future: _fetchMovie(index),
      builder: (context, snapshot) {
        final movie = snapshot.data;
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
                return MovieCardWidget(movie);


            }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<Movie>_fetchMovie(int index) async {
    var id = moviesID[index];
    return MovieProvider().getPopular(id);
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Container(
        height: 44,
        color: Color(0xFF191926),
      ),
      Container(
        height: 40,
        color: Color(0xFF191926),
        child: Text("Cinemapp"),
      ),
      Expanded(
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: Color(0xFF191926),
            appBar: TabBar(
              labelColor: const Color(0xff525c6e),
              unselectedLabelColor: const Color(0xffacb3bf),
              indicatorColor: Colors.red,
                tabs: [
                  Tab(child: Text("Popular"),),
                  Tab(child: Text("Top Rated"),),
                  Tab(child: Text("Most viewed"),),
                ],

            ),
                body: Container(color: Color(0xFF191926),
                    child:TabBarView(
                      children: [
                        buildMovies(),
                        buildMovies(),
                        buildMovies(),
                      ],
                    ),
              )
          ),
        ),
      ),
    ],
  );

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    MovieApi.getPopularIDs(currentPage).then((list) => setState(() {
          print("ID загружены");
          moviesID.addAll(list);
        }));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("LOADING");
        currentPage++;
        MovieApi.getPopularIDs(currentPage).then((list) => setState(() {
          print("ID загружены (допы)");
          moviesID.addAll(list);
        }));
      }
    });
  }

  Widget buildMovies() => GridView.builder(
      controller: _scrollController,
      itemBuilder: (context, index) {
        return FutureMovieBuilder(context, index);
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.635,
        mainAxisSpacing: 15.0,
      ),
      itemCount: moviesID.length,
      physics: BouncingScrollPhysics());
}
