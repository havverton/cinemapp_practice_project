import 'package:cinemapp_practice_project/utilities/widgets.dart';
import 'package:cinemapp_practice_project/widgets/movie/MovieListWidget.dart';
import 'package:cinemapp_practice_project/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilmPage extends StatefulWidget {
  @override
  _FilmPageState createState() => _FilmPageState();
}

class _FilmPageState extends State<FilmPage> {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          HeaderWidget(),
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
                          MovieListWidget(1),
                          MovieListWidget(2),
                          MovieListWidget(3),
                        ],
                      ),
                  )),
            ),
          ),
        ],
      );
}
