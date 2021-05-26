abstract class MovieListEvent{
  int page;
  MovieListEvent(this.page);
}

class MovieLoadPopularEvent extends MovieListEvent{
  int page;
  MovieLoadPopularEvent({ required this.page}) : super(page);
}
class MovieLoadTopRatedEvent extends MovieListEvent{
  int page;
  MovieLoadTopRatedEvent({ required this.page}) : super(page);
}
class MovieLoadUpcomingEvent extends MovieListEvent{
  int page;
  MovieLoadUpcomingEvent({ required this.page}) : super(page);
}