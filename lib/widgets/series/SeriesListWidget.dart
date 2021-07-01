import 'dart:io';

import 'package:cinemapp_practice_project/BLoC/series/series_bloc.dart';
import 'package:cinemapp_practice_project/models/SeriesModel.dart';
import 'package:cinemapp_practice_project/services/SeriesRepository.dart';
import 'package:cinemapp_practice_project/widgets/series/SeriesCardWidget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeriesListWidget extends StatefulWidget {
  final int typeID;

  SeriesListWidget(this.typeID);

  @override
  _SeriesListWidgetState createState() => _SeriesListWidgetState(this.typeID);
}

class _SeriesListWidgetState extends State<SeriesListWidget>
    with AutomaticKeepAliveClientMixin {
  int typeID;

  _SeriesListWidgetState(this.typeID);

  @override
  bool get wantKeepAlive => true;
  SeriesRepository seriesRepository = SeriesRepository();
  List<Series> seriesList = [];
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
    } on SocketException catch (_) {
      isConnected = false;
    }
  }

  Widget build(BuildContext context) {

    return BlocProvider<SeriesListBLoC>(
        create: (context) => SeriesListBLoC(seriesRepository),
        child: Builder(builder: (providerContext) {
          SeriesListBLoC seriesBloc =  BlocProvider.of<SeriesListBLoC>(providerContext);
         switch (typeID) {
           case 1:
             seriesBloc.add(SeriesLoadPopularEvent(page: 1));
             break;
           case 2:
             seriesBloc.add(SeriesLoadTopRatedEvent(page: 1));
             break;
         }

          return BlocBuilder<SeriesListBLoC, SeriesListState>(
              builder: (context, state) {
            if (state is SeriesEmptyListState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SeriesLoadingListState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SeriesLoadedListState) {
              seriesList.addAll(state.loadedMovies);
            } else if (state is SeriesListErrorState) {
              Text("Чёто не то");
            }

            return GridView.builder(
                controller: _scrollController(seriesBloc),
                dragStartBehavior: DragStartBehavior.down,
                itemBuilder: (context, index) {
                  var series = seriesList[index];
                  return SeriesCardWidget(series);
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.635,
                  mainAxisSpacing: 15.0,
                ),
                itemCount: seriesList.length,
                physics: BouncingScrollPhysics());
          });
        }));
  }

  ScrollController _scrollController(SeriesListBLoC seriesBloc) {
    ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("LOADING");

        int page = seriesList.length == 0 ? 1 : (seriesList.length ~/ 20) + 1;
        print("Current page: $page");
        switch (typeID) {
          case 1:
            seriesBloc.add(SeriesLoadPopularEvent(page: page));
            break;
          case 2:
            seriesBloc.add(SeriesLoadTopRatedEvent(page: page));
            break;
      }
    }});
    return _scrollController;
  }
}
