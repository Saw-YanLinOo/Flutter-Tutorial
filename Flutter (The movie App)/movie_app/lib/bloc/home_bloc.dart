import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

class HomeBloc {
  /// State
  StreamController<List<MovieVO>?> mNowPlayingMovieListStreamController =
      StreamController<List<MovieVO>?>();
  StreamController<List<MovieVO>?> mPopularMoviesListStreamController =
      StreamController();
  StreamController<List<GenreVO>?> mGenerListStreamController =
      StreamController<List<GenreVO>?>();
  StreamController<List<ActorVO>?> mActorListStreamController =
      StreamController<List<ActorVO>?>();
  StreamController<List<MovieVO>?> mShowCaseMoveListStreamController =
      StreamController<List<MovieVO>?>();
  StreamController<List<MovieVO>?> mMovieByGenreListStreamController =
      StreamController<List<MovieVO>?>();

  // Movie Model
  MovieModel mMovieModel = MovieModelImpl();

  HomeBloc() {
    /// 🎬 Now Playing Movies from database
    mMovieModel.getNowPlayingMoviesFromDatabase().listen((movieList) {
      mNowPlayingMovieListStreamController.sink.add(movieList);
    }).onError((error) {});

    /// 🎬 Popular Movies from database
    mMovieModel.getPopularMoviesFromDatabase().listen((movieList) {
      mPopularMoviesListStreamController.sink.add(movieList);
    }).onError((error) {});

    /// ❄️ Genres
    mMovieModel.getGenres().then((genreList) {
      mGenerListStreamController.sink.add(genreList);

      ///🎬 Movies By Genres
      getMoviesByGenreAndRefresh(genreList?.first.id ?? 0);
    }).catchError((error) {
      debugPrint('error:::::: $error');
    });

    /// ❄️ Genres from database
    mMovieModel.getGenresFromDatabase().then((genreList) {
      mGenerListStreamController.sink.add(genreList);

      ///🎬 Movies By Genres
      getMoviesByGenreAndRefresh(genreList?.first.id ?? 0);
    }).catchError((error) {
      debugPrint('error:::::: $error');
    });

    ///🎬 Showcase from database
    mMovieModel.getTopRatedMoviesFromDatabase().listen((movieList) {
      mShowCaseMoveListStreamController.sink.add(movieList);
    }).onError((error) {});

    /// 🤹 Actors
    mMovieModel.getActors(1).then((actorList) {
      mActorListStreamController.sink.add(actorList);
    }).catchError((error) {});

    /// 🤹 Actors from database
    mMovieModel.getActorsFromDatabase().then((actorList) {
      mActorListStreamController.sink.add(actorList);
    }).catchError((error) {});
  }

  /// 🎬 Movie List By Genres
  void getMoviesByGenreAndRefresh(int generalId) {
    mMovieModel.getMoviesByGenre(generalId).then((movieList) {
      mMovieByGenreListStreamController.sink.add(movieList);
    }).catchError((error) {});
  }

  void dispose() {
    mNowPlayingMovieListStreamController.close();
    mPopularMoviesListStreamController.close();
    mGenerListStreamController.close();
    mActorListStreamController.close();
    mShowCaseMoveListStreamController.close();
    mMovieByGenreListStreamController.close();
  }
}
