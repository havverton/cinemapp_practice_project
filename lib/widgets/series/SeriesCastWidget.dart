import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinemapp_practice_project/BLoC/series/seris_cast_bloc.dart';
import 'package:cinemapp_practice_project/models/CreditsModel.dart';
import 'package:cinemapp_practice_project/services/SeriesRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeriesCastWidget extends StatefulWidget {
  final int seriesID;

  SeriesCastWidget(this.seriesID);

  @override
  _SeriesCastWidgetState createState() => _SeriesCastWidgetState(this.seriesID);
}

class _SeriesCastWidgetState extends State<SeriesCastWidget> {
  final int seriesID;

  _SeriesCastWidgetState(this.seriesID);

  SeriesRepository seriesRepository = SeriesRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext newContext) => SeriesCastBLoC(seriesRepository),
        child: Builder(builder: (providerContext) {
          BlocProvider.of<SeriesCastBLoC>(providerContext)
              .add(LoadCastEvent(seriesID: seriesID));
          return BlocBuilder<SeriesCastBLoC, SeriesCastState>(
              builder: (context, state) {
            if (state is LoadingCastState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is LoadedCastState) {
              List<Cast> actors = state.actors;
              return GridView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: actors.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    childAspectRatio: 1.75,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 8),
                itemBuilder: (context, index) {
                  final actor = actors[index];
                  return ActorsCardWidget(actor);
                },
              );
            } else if (state is ErrorCastState) {
              return Center(child: Text("Error"));
            } else {
              return Center(child: Text("Ololo"));
            }
          });
        }));
  }
}

class ActorsCardWidget extends StatelessWidget {
  final Cast actor;

  ActorsCardWidget(this.actor);

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: FittedBox(
            clipBehavior: Clip.hardEdge,
            fit: BoxFit.cover,
            child: CachedNetworkImage(
              imageUrl: "https://image.tmdb.org/t/p/w185${actor.profilePath}",
              placeholder: (context, url) => Container(),
              errorWidget: (context, url, error) =>
                  Icon(Icons.account_circle_rounded),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 6.0),
          child: Column(children: [
            Text(
              "${actor.name}",
              textAlign: TextAlign.center,
            ),
            Text(
              "as ${actor.character}",
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
