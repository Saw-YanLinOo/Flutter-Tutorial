import 'package:movie_app/data/vos/movie_vo.dart';

import '../vos/actor_vo.dart';
import '../vos/credit_vo.dart';
import '../vos/genre_vo.dart';

abstract class MovieModel {
  // from network
  void getNowPlayingMovie(int page);
  void getPopularMovies(int page);
  void getTopRatedMovies(int page);
  Future<List<GenreVO>?> getGenres();
  Future<List<MovieVO>?> getMoviesByGenre(int genreId);
  Future<List<ActorVO>?> getActors(int page);
  Future<MovieVO?> getMovieDetails(int movieId);
  Future<List<CreditVO>?> getCreditsByMovie(int movieId);

  // from database
  Stream<List<MovieVO>?> getTopRatedMoviesFromDatabase();
  Stream<List<MovieVO>?> getNowPlayingMoviesFromDatabase();
  Stream<List<MovieVO>?> getPopularMoviesFromDatabase();
  Future<List<GenreVO>?> getGenresFromDatabase();
  Future<List<ActorVO>?> getActorsFromDatabase();
  Future<MovieVO?> getMovieDetailsFromDatabase(int movieId);

}
