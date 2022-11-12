import 'package:flutter/cupertino.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/vos/credit_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/dataagents/movie_data_agent.dart';
import 'package:movie_app/persistence/daos/impls/actor_dao_impl.dart';
import 'package:movie_app/persistence/daos/impls/genre_dao_impl.dart';
import 'package:movie_app/persistence/daos/impls/movie_dao_impl.dart';
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
  MovieDaoImpl mMovieDao = MovieDaoImpl();
  GenreDaoImpl mgenreDao = GenreDaoImpl();
  ActorDaoImpl mActorDao = ActorDaoImpl();

  // Index
  int size = 20;

  @override
  void getNowPlayingMovie(int page) {
    int index = (page - 1) * size;

    mDataAgent.getNowPlayingMovie(page).then((movies) async {
      List<MovieVO>? nowPlayingMovies = movies?.map((movie) {
        movie.index = index;
        index++;
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
    int index = (page - 1) * size;

    mDataAgent.getPopularMovies(page).then((movies) async {
      List<MovieVO>? popularMovies = movies?.map((movie) {
        movie.index = index;
        index++;
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
    int index = (page - 1) * size;

    mDataAgent.getTopRatedMovies(page).then((movies) async {
      List<MovieVO>? topRatedMovies = movies?.map((movie) {
        movie.index = index;
        index++;
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
      movie?.index = mMovie?.index;
      movie?.isNowPlaying = mMovie?.isNowPlaying;
      movie?.isPopular = mMovie?.isPopular;
      movie?.isTopRated = mMovie?.isTopRated;

      mMovieDao.saveSingleMovie(movie);
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
        .startWith(mMovieDao.getNowPlayingMoviesStream())
        .map((event) => mMovieDao.getNowPlayingMovies());
  }

  @override
  Stream<List<MovieVO>?> getPopularMoviesFromDatabase() {
    getPopularMovies(1);
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getPopularMoviesStream())
        .map((event) => mMovieDao.getPopularMovies());
  }

  @override
  Stream<List<MovieVO>?> getTopRatedMoviesFromDatabase() {
    getTopRatedMovies(1);
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getTopRatedMoviesStream())
        .map((event) => mMovieDao.getTopRatedMovies());
  }
}
