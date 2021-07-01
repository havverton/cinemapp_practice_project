import 'package:cinemapp_practice_project/models/CreditsModel.dart';
import 'package:cinemapp_practice_project/services/SeriesRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SeriesCastState {
  late List<Cast> actors;
}

class UnknownCastState extends SeriesCastState{}
class LoadingCastState extends SeriesCastState{}
class LoadedCastState extends SeriesCastState{
  List<Cast> actors;
  LoadedCastState({required this.actors});
}
class ErrorCastState extends SeriesCastState{}

abstract class SeriesCastEvent{}

class LoadCastEvent  extends SeriesCastEvent{
  int seriesID;
  LoadCastEvent({required this.seriesID});
}

class SeriesCastBLoC extends Bloc<SeriesCastEvent, SeriesCastState> {
  final SeriesRepository seriesRepository;
  SeriesCastBLoC(this.seriesRepository) : super(UnknownCastState());

  @override
  Stream<SeriesCastState> mapEventToState(SeriesCastEvent event) async*{
    if(event is LoadCastEvent){
      yield LoadingCastState();
      try{
        List<Cast> cast = await seriesRepository.getActors(event.seriesID);
        yield LoadedCastState(actors: cast);
      }catch(err){
        yield ErrorCastState();
      }
    }
  }
}

