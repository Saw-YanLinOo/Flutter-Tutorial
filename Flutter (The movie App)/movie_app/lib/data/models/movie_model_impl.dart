import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/vos/credit_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/dataagents/movie_data_agent.dart';
import 'package:movie_app/persistence/daos/actor_dao.dart';
import 'package:movie_app/persistence/daos/genre_dao.dart';
import 'package:movie_app/persistence/daos/movie_dao.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../network/dataagents/retrofit_movie_data_agent_impl.dart';

class MovieModelImpl extends MovieModel {
  // MovieDataAgent mDataAgent = HttpMovieDataAgentImpl();
  //MovieDataAgent mDataAgent = DioMovieDataAgentImpl();
  MovieDataAgent mDataAgent = RetrofitDataAgentImpl();

  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  MovieModelImpl._internal();

  factory MovieModelImpl() => _singleton;

  // Daos
  MovieDao mMovieDao = MovieDao();
  GenreDao mgenreDao = GenreDao();
  ActorDao mActorDao = ActorDao();

  @override
  void getNowPlayingMovie(int page) {
    mDataAgent.getNowPlayingMovie(page).then((movies) async {
      List<MovieVO>? nowPlayingMovies = movies?.map((movie) {
        movie.isNowPlaying = true;
        movie.isPopular = false;
        movie.isTopRated = false;

        return movie;
      }).toList();

      mMovieDao.saveMovies(nowPlayingMovies ?? []);
    });
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {
    return mDataAgent.getActors(page).then((actors) {
      mActorDao.saveAllActors(actors ?? []);
      return actors;
    });
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return mDataAgent.getGenres().then((genres) async {
      mgenreDao.saveAllGenres(genres ?? []);

      return genres;
    });
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    return mDataAgent.getMoviesByGenre(genreId);
  }

  @override
  void getPopularMovies(int page) {
    mDataAgent.getPopularMovies(page).then((movies) async {
      List<MovieVO>? popularMovies = movies?.map((movie) {
        movie.isNowPlaying = false;
        movie.isPopular = true;
        movie.isTopRated = false;

        return movie;
      }).toList();

      mMovieDao.saveMovies(popularMovies ?? []);
    });
  }

  @override
  void getTopRatedMovies(int page) {
    mDataAgent.getTopRatedMovies(page).then((movies) async {
      List<MovieVO>? topRatedMovies = movies?.map((movie) {
        movie.isNowPlaying = false;
        movie.isPopular = false;
        movie.isTopRated = true;

        return movie;
      }).toList();

      mMovieDao.saveMovies(topRatedMovies ?? []);
    });
  }

  @override
  Future<List<CreditVO>?> getCreditsByMovie(int movieId) {
    return mDataAgent.getCreditsByMovie(movieId);
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return mDataAgent.getMovieDetails(movieId).then((movie) {
      var mMovie = mMovieDao.getMovieById(movieId);

      movie?.isNowPlaying = mMovie?.isNowPlaying;
      movie?.isPopular = mMovie?.isPopular;
      movie?.isTopRated = mMovie?.isTopRated;

      mMovieDao.saveSingleMovie(movie ?? MovieVO());
      return movie;
    });
  }

  /// Dao
  @override
  Future<List<ActorVO>?> getActorsFromDatabase() {
    return Future.value(mActorDao.getAllActor());
  }

  @override
  Future<List<GenreVO>?> getGenresFromDatabase() {
    return Future.value(mgenreDao.getAllGenre());
  }

  @override
  Future<MovieVO?> getMovieDetailsFromDatabase(int movieId) {
    return Future.value(mMovieDao.getMovieById(movieId));
  }

  @override
  Stream<List<MovieVO>?> getNowPlayingMoviesFromDatabase() {
    getNowPlayingMovie(1);
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getNowPlayingMovies())
        .map((event) => mMovieDao.getNowPlayingMovies());
  }

  @override
  Stream<List<MovieVO>?> getPopularMoviesFromDatabase() {
    getPopularMovies(1);
    return mMovieDao
        .getAllMoviesEventStream()
        .map((event) => mMovieDao.getPopularMovies());
  }

  @override
  Stream<List<MovieVO>?> getTopRatedMoviesFromDatabase() {
    getTopRatedMovies(1);
    return mMovieDao
        .getAllMoviesEventStream()
        .map((event) => mMovieDao.getTopRatedMovies());
  }
}
