abstract class MovieEvent{
  MovieEvent(int page);
}

class MovieLoadPopularEvent extends MovieEvent{
  int page = 1;
  MovieLoadPopularEvent({this.page}) : super(page);
}
class MovieLoadTopRatedEvent extends MovieEvent{
  int page = 1;
  MovieLoadTopRatedEvent({this.page}) : super(page);
}