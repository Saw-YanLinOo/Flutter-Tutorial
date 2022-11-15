import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/credit_vo.dart';
import 'package:movie_app/data/vos/actor_vo.dart';

import '../mock_data/mock_data.dart';

class MovieModelImplMocke extends MovieModel {
  @override
  Future<List<ActorVO>?> getActors(int page) {
    return Future.value(getMockActors());
  }

  @override
  Future<List<ActorVO>?> getActorsFromDatabase() {
    return Future.value(getMockActors());
  }

  @override
  Future<List<CreditVO>?> getCreditsByMovie(int movieId) {
    return Future.value(getMockCredits());
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return Future.value(getMockGenre());
  }

  @override
  Future<List<GenreVO>?> getGenresFromDatabase() {
    return Future.value(getMockGenre());
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return Future.value(getMockMoviesForTest().first);
  }

  @override
  Future<MovieVO?> getMovieDetailsFromDatabase(int movieId) {
    return Future.value(getMockMoviesForTest().first);
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    if (genreId == 3) {
      return Future.value([getMockMoviesForTest().last]);
    } else {
      return Future.value([getMockMoviesForTest().first]);
    }
  }

  @override
  void getNowPlayingMovie(int page) {
    // TODO: implement getNowPlayingMovie
  }

  @override
  Stream<List<MovieVO>?> getNowPlayingMoviesFromDatabase() {
    return Stream.value(
      getMockMoviesForTest()
          .where((element) => element.isNowPlaying ?? false)
          .toList(),
    );
  }

  @override
  void getPopularMovies(int page) {
    // TODO: implement getPopularMovies
  }

  @override
  Stream<List<MovieVO>?> getPopularMoviesFromDatabase() {
    return Stream.value(
      getMockMoviesForTest()
          .where((element) => element.isPopular ?? false)
          .toList(),
    );
  }

  @override
  void getTopRatedMovies(int page) {
    // TODO: implement getTopRatedMovies
  }

  @override
  Stream<List<MovieVO>?> getTopRatedMoviesFromDatabase() {
    return Stream.value(
      getMockMoviesForTest()
          .where((element) => element.isTopRated ?? false)
          .toList(),
    );
  }
}
