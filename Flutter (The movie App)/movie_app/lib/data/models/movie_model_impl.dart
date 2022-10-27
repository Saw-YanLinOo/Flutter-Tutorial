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

  MovieModelImpl._internal() {
    getNowPlayingMoviesFromDatabase();
    getTopRatedMoviesFromDatabase();
    getPopularMoviesFromDatabase();

    getActors(1);
    getActorsFromDatabase();
    getGenres();
    getGenresFromDatabase();
  }

  factory MovieModelImpl() => _singleton;

  // Daos
  MovieDao mMovieDao = MovieDao();
  GenreDao mgenreDao = GenreDao();
  ActorDao mActorDao = ActorDao();

  // Home Page State
  List<MovieVO>? mNowPlayingMovieList;
  List<MovieVO>? mPopularMoviesList;
  List<GenreVO>? mGenerList;
  List<ActorVO>? mActors;
  List<MovieVO>? mShowCaseMoveList;
  List<MovieVO>? mMovieByGenreList;

  // Movie Detail State
  MovieVO? mMovie;
  List<CreditVO>? mActorsList;
  List<CreditVO>? mCreatorsList;

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

      mNowPlayingMovieList = nowPlayingMovies;
      notifyListeners();
    });
  }

  @override
  void getActors(int page) {
    mDataAgent.getActors(page).then((actors) {
      mActorDao.saveAllActors(actors ?? []);

      mActors = actors;
      notifyListeners();
    });
  }

  @override
  void getGenres() {
    mDataAgent.getGenres().then((genres) async {
      mgenreDao.saveAllGenres(genres ?? []);

      getMoviesByGenre(genres?.first.id ?? 0);

      mGenerList = genres;
      notifyListeners();

      return genres;
    });
  }

  @override
  void getMoviesByGenre(int genreId) {
    mDataAgent.getMoviesByGenre(genreId).then((movieList) {
      mMovieByGenreList = movieList;
      notifyListeners();
    });
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

      mPopularMoviesList = popularMovies;
      notifyListeners();
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
      mShowCaseMoveList = topRatedMovies;
      notifyListeners();
    });
  }

  @override
  void getCreditsByMovie(int movieId) {
    mDataAgent.getCreditsByMovie(movieId).then((creditList) {
      mActorsList = creditList?.where((credit) => credit.isActor()).toList();

      mCreatorsList =
          creditList?.where((credit) => credit.isCreator()).toList();
      notifyListeners();
    });
  }

  @override
  void getMovieDetails(int movieId) {
    mDataAgent.getMovieDetails(movieId).then((movie) {
      var dMovie = mMovieDao.getMovieById(movieId);

      movie?.isNowPlaying = dMovie?.isNowPlaying;
      movie?.isPopular = dMovie?.isPopular;
      movie?.isTopRated = dMovie?.isTopRated;

      mMovieDao.saveSingleMovie(movie ?? MovieVO());

      mMovie = movie;
      notifyListeners();
    });
  }

  /// Dao
  @override
  void getActorsFromDatabase() {
    mActors = mActorDao.getAllActor();
    notifyListeners();
  }

  @override
  void getGenresFromDatabase() {
    mGenerList = mgenreDao.getAllGenre();
    notifyListeners();
  }

  @override
  void getNowPlayingMoviesFromDatabase() {
    getNowPlayingMovie(1);
    mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getNowPlayingMoviesStream())
        .map((event) => mMovieDao.getNowPlayingMovies())
        .listen((movieList) {
      mNowPlayingMovieList = movieList;
      notifyListeners();
    });
  }

  @override
  void getPopularMoviesFromDatabase() {
    getPopularMovies(1);
    mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getPopularMoviesStream())
        .map((event) => mMovieDao.getPopularMovies())
        .listen((movieList) {
      mPopularMoviesList = movieList;
      notifyListeners();
    });
  }

  @override
  void getTopRatedMoviesFromDatabase() {
    getTopRatedMovies(1);
    mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getTopRatedMoviesStream())
        .map((event) => mMovieDao.getTopRatedMovies())
        .listen((movieList) {
      mShowCaseMoveList = movieList;
      notifyListeners();
    });
  }

  @override
  void getMovieDetailsFromDatabase(int movieId) {
    mMovie = mMovieDao.getMovieById(movieId);
    notifyListeners();
  }
}
