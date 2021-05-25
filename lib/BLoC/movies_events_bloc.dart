abstract class MovieEvent{
  MovieEvent(int page);
}

class MovieLoadPopularEvent extends MovieEvent{
  int page;
  MovieLoadPopularEvent({ required this.page}) : super(page);
}
class MovieLoadTopRatedEvent extends MovieEvent{
  int page;
  MovieLoadTopRatedEvent({ required this.page}) : super(page);
}