import 'package:movie_app/data/vos/movie_vo.dart';

abstract class MovieDao {
  void saveMovies(List<MovieVO> movieList);
  void saveSingleMovie(MovieVO? movie);
  List<MovieVO> getAllMovies();
  MovieVO? getMovieById(int movieId);
  List<MovieVO> getNowPlayingMovies();
  List<MovieVO> getPopularMovies();
  List<MovieVO> getTopRatedMovies();
  Stream<void> getAllMoviesEventStream();
  Stream<List<MovieVO>> getNowPlayingMoviesStream();
   Stream<List<MovieVO>> getPopularMoviesStream();
   Stream<List<MovieVO>> getTopRatedMoviesStream();
}
