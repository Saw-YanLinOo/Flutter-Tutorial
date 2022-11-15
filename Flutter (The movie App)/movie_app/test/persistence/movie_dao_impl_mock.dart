import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/persistence/daos/movie_dao.dart';

import '../mock_data/mock_data.dart';

class MovieDaoImplMock extends MovieDao {
  Map<int, MovieVO> movieListFromDatabaseMock = {};

  @override
  List<MovieVO> getAllMovies() {
    return getMockMoviesForTest();
  }

  @override
  Stream<void> getAllMoviesEventStream() {
    return Stream<void>.value(null);
  }

  @override
  MovieVO? getMovieById(int movieId) {

    var movieList = movieListFromDatabaseMock.values.toList().where((element) => element.id == movieId).toList();

    if(movieList != null && movieList.isNotEmpty){
      return movieList.first;
    }
    return null;
  }

  @override
  List<MovieVO> getNowPlayingMovies() {
    if (getMockMoviesForTest().isNotEmpty) {
      return getMockMoviesForTest()
          .where((movie) => movie.isNowPlaying ?? false)
          .toList();
    } else {
      return [];
    }
  }

  @override
  Stream<List<MovieVO>> getNowPlayingMoviesStream() {
    return Stream.value(
      getMockMoviesForTest()
          .where((movie) => movie.isNowPlaying ?? false)
          .toList(),
    );
  }

  @override
  List<MovieVO> getPopularMovies() {
    if (getMockMoviesForTest().isNotEmpty) {
      return getMockMoviesForTest()
          .where((movie) => movie.isPopular ?? false)
          .toList();
    } else {
      return [];
    }
  }

  @override
  Stream<List<MovieVO>> getPopularMoviesStream() {
    return Stream.value(
      getMockMoviesForTest()
          .where((movie) => movie.isPopular ?? false)
          .toList(),
    );
  }

  @override
  List<MovieVO> getTopRatedMovies() {
    if (getMockMoviesForTest().isNotEmpty) {
      return getMockMoviesForTest()
          .where((movie) => movie.isTopRated ?? false)
          .toList();
    } else {
      return [];
    }
  }

  @override
  Stream<List<MovieVO>> getTopRatedMoviesStream() {
    return Stream.value(
      getMockMoviesForTest()
          .where((movie) => movie.isTopRated ?? false)
          .toList(),
    );
  }

  @override
  void saveMovies(List<MovieVO> movieList) {
    for (var movie in movieList) {
      movieListFromDatabaseMock[movie.id ?? 0] = movie;
    }
  }

  @override
  void saveSingleMovie(MovieVO? movie) {
    if (movie != null) {
      movieListFromDatabaseMock[movie.id ?? 0] = movie;
    }
  }
}
