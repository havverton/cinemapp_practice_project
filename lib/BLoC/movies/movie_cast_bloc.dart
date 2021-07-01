import 'package:cinemapp_practice_project/models/CreditsModel.dart';
import 'package:cinemapp_practice_project/services/MovieRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class MovieCastState {
  late List<Cast> actors;
}

class UnknownCastState extends MovieCastState{}
class LoadingCastState extends MovieCastState{}
class LoadedCastState extends MovieCastState{
  List<Cast> actors;
  LoadedCastState({required this.actors});
}
class ErrorCastState extends MovieCastState{}

abstract class MovieCastEvent{}

class LoadCastEvent  extends MovieCastEvent{
  int movieID;
  LoadCastEvent({required this.movieID});
}

class MovieCastBLoC extends Bloc<MovieCastEvent, MovieCastState> {
  final MovieRepository movieRepository;
  MovieCastBLoC(this.movieRepository) : super(UnknownCastState());

  @override
  Stream<MovieCastState> mapEventToState(MovieCastEvent event) async*{
    if(event is LoadCastEvent){
      yield LoadingCastState();
      try{
        List<Cast> cast = await movieRepository.getActors(event.movieID);
        yield LoadedCastState(actors: cast);
      }catch(err){
        yield ErrorCastState();
      }
    }
  }
}

