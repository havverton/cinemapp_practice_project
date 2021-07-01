import 'package:cinemapp_practice_project/widgets/movie/MovieListWidget.dart';
import 'package:cinemapp_practice_project/utilities/constants.dart';
import 'package:cinemapp_practice_project/widgets/series/SeriesListWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TVSeriesPage extends StatefulWidget {
  @override
  _TVSeriesPageState createState() => _TVSeriesPageState();
}

class _TVSeriesPageState extends State<TVSeriesPage> {
  var isConnected = false;

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
              length: 2,
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

                    ],
                  ),
                  body: Container(
                    color: kMainBackGrndColor,
                    child: TabBarView(
                      children: [
                        SeriesListWidget(1),
                        SeriesListWidget(2),
                      ],
                    ),
                  )),
            ),
          ),
        ],
      );
}
