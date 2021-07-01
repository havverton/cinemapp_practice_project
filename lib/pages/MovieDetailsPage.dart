import 'package:cinemapp_practice_project/models/MovieModel.dart';
import 'package:cinemapp_practice_project/services/MovieRepository.dart';
import 'package:cinemapp_practice_project/widgets/DetailsFavouriteButton.dart';
import 'package:cinemapp_practice_project/widgets/RatingBarWidget.dart';
import 'package:cinemapp_practice_project/widgets/movie/MovieCastWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../utilities/constants.dart';

class MovieDetailsWidget extends StatefulWidget {
  final Movie movie;

  const MovieDetailsWidget({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieDetailWidgetState createState() => _MovieDetailWidgetState(movie);
}

class _MovieDetailWidgetState extends State<MovieDetailsWidget> {
  _MovieDetailWidgetState(this.movie);

  final Movie movie;
  bool showSlider = false;
  PanelController _pc = PanelController();
  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        minHeight: 0,
        maxHeight: 515,
        parallaxEnabled: true,
        controller: _pc,
        borderRadius: radius,
        color: kMainBackGrndColor,
        collapsed: Container(
          decoration:
              BoxDecoration(color: kMainBackGrndColor, borderRadius: radius),
        ),
        backdropEnabled: true,
        panel: Column(
          children: [
            Stack(
              clipBehavior: Clip.hardEdge,
              children: [Container(
                alignment: Alignment.topCenter,
                height: 92,
                color: Colors.green,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: Column(
                          children: [
                            Flexible(
                                child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Your review",
                                        style: TextStyle(fontSize: 14.0)))),
                            Flexible(
                                child: Row(
                              children: [
                                Flexible(
                                    child: Container(
                                  child: Text("27APR 23:00"),
                                )),
                                Flexible(
                                    child: Container(
                                  margin: EdgeInsets.only(left: 14),
                                  child: Text("125 Helpful votes"),
                                ))
                              ],
                            )),
                          ],
                        ),
                      ),
                      Flexible(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(top:16.0),

                            width: 64,
                            height: 96,
                            color: Colors.red,
                          )),
                    ],
                  ),
                ),
              ),
              ]
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            Expanded(
                child: Container(
              color: Colors.blueGrey,
            ))
          ],
        ),
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
                                .getBackDropURL(movie.backdropPath ?? '')),
                            position: DecorationPosition.foreground,
                            decoration: new BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Color(0xFF191926),
                                    Color(0xDD191926),
                                    Color(0xAA191926)
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
                            "${movie.title}",
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
                                Text("${movie.voteCount ?? 0} votes",
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
                                    child: MovieCastWidget(movie.movieId)),
                              ],
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
                                        onTap: () => {_pc.open()},
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text("Leave a review"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              DetailsFavouriteButton(movie),
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
      ),
    );
  }

  void hideSlider() {
    setState(() {
      showSlider = !showSlider;
    });
  }
}
