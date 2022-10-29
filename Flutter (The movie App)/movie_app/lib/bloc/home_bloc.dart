import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

class HomeBloc {
  StreamController<List<MovieVO>?> mNowPlayingMovieListStreamController =
      StreamController();
  StreamController<List<MovieVO>?> mPopularMoviesListStreamController =
      StreamController();
  StreamController<List<GenreVO>?> mGenerListStreamController =
      StreamController();
  StreamController<List<ActorVO>?> mActorListStreamController =
      StreamController();
  StreamController<List<MovieVO>?> mShowCaseMoveListStreamController =
      StreamController();
  StreamController<List<MovieVO>?> mMovieByGenreListStreamController =
      StreamController();

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
      _getMoviesByGenreAndRefresh(genreList?.first.id ?? 0);
    }).catchError((error) {
      debugPrint('error:::::: $error');
    });

    /// ❄️ Genres from database
    mMovieModel.getGenresFromDatabase().then((genreList) {
      mGenerListStreamController.sink.add(genreList);

      ///🎬 Movies By Genres
      _getMoviesByGenreAndRefresh(genreList?.first.id ?? 0);
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
  _getMoviesByGenreAndRefresh(int generalId) {
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
