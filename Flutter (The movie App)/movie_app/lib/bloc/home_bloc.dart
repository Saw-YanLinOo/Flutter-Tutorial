import 'dart:async';

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

  void dispose() {
    mNowPlayingMovieListStreamController.close();
    mPopularMoviesListStreamController.close();
    mGenerListStreamController.close();
    mActorListStreamController.close();
    mShowCaseMoveListStreamController.close();
    mMovieByGenreListStreamController.close();
  }
}
