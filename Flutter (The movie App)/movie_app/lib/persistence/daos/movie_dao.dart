import 'package:hive/hive.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/persistence/hive_constants.dart';

class MovieDao {
  MovieDao._internal();

  static final MovieDao _singleton = MovieDao._internal();

  factory MovieDao() => _singleton;

  void saveMovies(List<MovieVO> movieList) async {
    Map<int?, MovieVO> genreMap = {
      for (var movie in movieList) movie.id: movie
    };

    await getMovieBox().putAll(genreMap);
  }

  void saveSingleMovie(MovieVO movie) async {
    return getMovieBox().put(movie.id, movie);
  }

  List<MovieVO> getAllMovies() {
    return getMovieBox().values.toList();
  }

  MovieVO? getMovieById(int movieId) {
    return getMovieBox().get(movieId);
  }

  List<MovieVO> getNowPlayingMovies() {
    if (getAllMovies().isNotEmpty) {
      var movieList =
          getAllMovies().where((movie) => movie.isNowPlaying ?? false).toList();
      movieList.sort((a, b) => a.index?.compareTo(b.index ?? 0) ?? 0);
      return movieList;
    } else {
      return [];
    }
  }

  List<MovieVO> getPopularMovies() {
    if (getAllMovies().isNotEmpty) {
      var movieList =
          getAllMovies().where((movie) => movie.isPopular ?? false).toList();

      movieList.sort((a, b) => a.index?.compareTo(b.index ?? 0) ?? 0);
      return movieList;
    } else {
      return [];
    }
  }

  List<MovieVO> getTopRatedMovies() {
    if (getAllMovies().isNotEmpty) {
      var movieList =
          getAllMovies().where((movie) => movie.isTopRated ?? false).toList();
      movieList.sort((a, b) => a.index?.compareTo(b.index ?? 0) ?? 0);
      return movieList;
    } else {
      return [];
    }
  }

  // Reacting Programming
  Stream<void> getAllMoviesEventStream() {
    return getMovieBox().watch();
  }

  Stream<List<MovieVO>> getNowPlayingMoviesStream() {
    return Stream.value(getNowPlayingMovies());
  }

  Stream<List<MovieVO>> getPopularMoviesStream() {
    return Stream.value(getPopularMovies());
  }

  Stream<List<MovieVO>> getTopRatedMoviesStream() {
    return Stream.value(getTopRatedMovies());
  }

  Box<MovieVO> getMovieBox() {
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }
}
