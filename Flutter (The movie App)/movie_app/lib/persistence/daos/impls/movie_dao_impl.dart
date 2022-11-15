import 'package:hive/hive.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/persistence/daos/movie_dao.dart';
import 'package:movie_app/persistence/hive_constants.dart';

class MovieDaoImpl extends MovieDao {
  MovieDaoImpl._internal();

  static final MovieDaoImpl _singleton = MovieDaoImpl._internal();

  factory MovieDaoImpl() => _singleton;

  @override
  void saveMovies(List<MovieVO> movieList) async {
    Map<int?, MovieVO> genreMap = {
      for (var movie in movieList) movie.id: movie
    };

    await getMovieBox().putAll(genreMap);
  }

  @override
  void saveSingleMovie(MovieVO? movie) async {
    if (movie != null) {
      getMovieBox().put(movie.id, movie);
    }
  }

  @override
  List<MovieVO> getAllMovies() {
    return getMovieBox().values.toList();
  }

  @override
  MovieVO? getMovieById(int movieId) {
    return getMovieBox().get(movieId);
  }

  @override
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

  @override
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

  @override
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
  @override
  Stream<void> getAllMoviesEventStream() {
    return getMovieBox().watch();
  }

  @override
  Stream<List<MovieVO>> getNowPlayingMoviesStream() {
    return Stream.value(getNowPlayingMovies());
  }

  @override
  Stream<List<MovieVO>> getPopularMoviesStream() {
    return Stream.value(getPopularMovies());
  }

  @override
  Stream<List<MovieVO>> getTopRatedMoviesStream() {
    return Stream.value(getTopRatedMovies());
  }

  Box<MovieVO> getMovieBox() {
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }
}
