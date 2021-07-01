import 'package:cinemapp_practice_project/models/MovieModel.dart';
import 'package:cinemapp_practice_project/models/SeriesModel.dart';
import 'package:cinemapp_practice_project/services/MovieRepository.dart';
import 'package:cinemapp_practice_project/widgets/DetailsFavouriteButton.dart';
import 'package:cinemapp_practice_project/widgets/movie/MovieCastWidget.dart';
import 'package:cinemapp_practice_project/widgets/RatingBarWidget.dart';
import 'package:cinemapp_practice_project/widgets/series/SeriesCastWidget.dart';
import 'package:cinemapp_practice_project/widgets/series/SeriesSeasonsWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class SeriesDetailsWidget extends StatefulWidget {
  final Series movie;

  const SeriesDetailsWidget({Key? key, required this.movie}) : super(key: key);

  @override
  _SeriesDetailWidgetState createState() => _SeriesDetailWidgetState(movie);
}

class _SeriesDetailWidgetState extends State<SeriesDetailsWidget> {
  _SeriesDetailWidgetState(this.movie);

  final Series movie;
  bool showSlider = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: Container(
            color: kMainBackGrndColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    Center(
                      child: Container(
                        child: DecoratedBox(
                          child: Image.network(MovieRepository()
                              .getBackDropURL(movie.backdropPath)),
                          position: DecorationPosition.foreground,
                          decoration: new BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.center,
                                colors: [
                                  Color(0xFF191926),
                                  Color(0xAA191926),
                                  Color(0x00191926)
                                ]),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 1,
                      left: 1,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          margin: EdgeInsets.only(top: 59.0, left: 10.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.chevron_left,
                                color: Color(0xFF565665),
                              ),
                              Text(
                                "Back",
                                style: TextStyle(color: Color(0xFF565665)),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  alignment: Alignment.bottomCenter,
                  child: Flex(
                    mainAxisSize: MainAxisSize.min,
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          "${movie.name }",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            "${movie.mainGenres ?? ''}",
                            style: TextStyle(
                              fontSize: 14,
                              color: kSecondaryColor,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              RatingBarWidget(movie.voteAverage),
                              Text("${movie.voteCount} votes",
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xFF6D6D80)))
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("STORYLINE",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              Text("${movie.overview}",
                                  style: TextStyle(fontSize: 14))
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                child: Text("Cast",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                  width: double.infinity,
                                  height: 150,
                                  child: SeriesCastWidget(movie.id)),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: movie.seasons.length > 0 ? true : false,
                        child: Flexible(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Text("Seasons",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Container(
                                    width: double.infinity,
                                    height: 200,
                                    child: SeriesSeasonWidget(movie.seasons)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 60,
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient: RadialGradient(
                                      colors: [
                                        Color(0xFF4E4E63),
                                        Color(0xFF212130)
                                      ],
                                      radius: 2,
                                    )),
                                    child: InkWell(
                                      onTap: () => {print("тык")},
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text("Leave a review"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //DetailsFavouriteButton(movie),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void hideSlider() {
    setState(() {
      showSlider = !showSlider;
    });
  }
}
