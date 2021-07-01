import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinemapp_practice_project/models/SeriesModel.dart';
import 'package:cinemapp_practice_project/services/SeriesRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SeriesSeasonWidget extends StatefulWidget {
  final List<Season> seasons;

  SeriesSeasonWidget(this.seasons);

  @override
  _SeriesSeasonWidgetState createState() =>
      _SeriesSeasonWidgetState(this.seasons);
}

class _SeriesSeasonWidgetState extends State<SeriesSeasonWidget> {
  final List<Season> seasons;

  _SeriesSeasonWidgetState(this.seasons);

  SeriesRepository seriesRepository = SeriesRepository();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: seasons.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          childAspectRatio: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 8),
      itemBuilder: (context, index) {
        final season = seasons[index];
        return SeasonCardWidget(season);
      },
    );
  }
}

class SeasonCardWidget extends StatelessWidget {
  final Season season;

  SeasonCardWidget(this.season);

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 185,
          height: 278,
          child: CachedNetworkImage(
            // fit: BoxFit.cover,
            imageUrl: "https://image.tmdb.org/t/p/w185${season.posterPath}",
            placeholder: (context, url) => SizedBox(),
            errorWidget: (context, url, error) =>
                Icon(Icons.account_circle_rounded),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 6.0),
          child: Column(children: [
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                "${season.name}",
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              "${season.episodeCount} episodes",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 8.0,
                color: Colors.blueGrey,
              ),
            )
          ]),
        )
      ],
    );
  }
}
