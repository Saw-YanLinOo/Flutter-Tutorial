import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:scoped_model/scoped_model.dart';

import '../vos/actor_vo.dart';
import '../vos/credit_vo.dart';
import '../vos/genre_vo.dart';

abstract class MovieModel extends Model {
  // from network
  void getNowPlayingMovie(int page);
  void getPopularMovies(int page);
  void getTopRatedMovies(int page);
  void getGenres();
  void getMoviesByGenre(int genreId);
  void getActors(int page);
  void getMovieDetails(int movieId);
  void getCreditsByMovie(int movieId);

  // from database
  void getTopRatedMoviesFromDatabase();
  void getNowPlayingMoviesFromDatabase();
  void getPopularMoviesFromDatabase();
  void getGenresFromDatabase();
  void getActorsFromDatabase();
  void getMovieDetailsFromDatabase(int movieId);
}
