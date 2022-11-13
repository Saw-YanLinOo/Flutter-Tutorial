import 'package:flutter/foundation.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

import '../data/models/movie_model.dart';

class HomeBloc extends ChangeNotifier {
  //State
  List<MovieVO>? mNowPlayingMovieList;
  List<MovieVO>? mPopularMoviesList;
  List<GenreVO>? mGenerList;
  List<ActorVO>? mActors;
  List<MovieVO>? mShowCaseMoveList;
  List<MovieVO>? mMovieByGenreList;

  int pageForNowPlayingMovieList = 1;

  //Model
  MovieModel mMovieModel = MovieModelImpl();

  HomeBloc({MovieModel? movieModel}) {
    // Set Mock model for Test Data
    if (movieModel != null) {
      mMovieModel = movieModel;
    }

    /// Now Playing Movies from database
    mMovieModel.getNowPlayingMoviesFromDatabase().listen((movieList) {
      mNowPlayingMovieList = movieList ?? [];

      if (mNowPlayingMovieList?.isNotEmpty ?? false) {
        mNowPlayingMovieList?.sort((a, b) => a.id ?? 0 - (b.id ?? 0));
      }
      notifyListeners();
    }).onError((error) {});

    /// Popular Movies from database
    mMovieModel.getPopularMoviesFromDatabase().listen((movieList) {
      mPopularMoviesList = movieList ?? [];
      notifyListeners();
    }).onError((error) {});

    /// Genres
    mMovieModel.getGenres().then((genreList) {
      mGenerList = genreList ?? [];
      notifyListeners();

      /// Movies By Genres
      if (genreList?.isNotEmpty ?? false) {
        _getMoviesByGenreAndRefresh(mGenerList?.first.id ?? 0);
      }
    }).catchError((error) {
      debugPrint('error:::::: $error');
    });

    /// Genres from database
    mMovieModel.getGenresFromDatabase().then((genreList) {
      mGenerList = genreList ?? [];
      notifyListeners();

      /// Movies By Genres
      if (genreList?.isNotEmpty ?? false) {
        _getMoviesByGenreAndRefresh(mGenerList?.first.id ?? 0);
      }
    }).catchError((error) {
      debugPrint('error:::::: $error');
    });

    /// Showcase from database
    mMovieModel.getTopRatedMoviesFromDatabase().listen((movieList) {
      mShowCaseMoveList = movieList ?? [];
      notifyListeners();
    }).onError((error) {});

    /// Actors
    mMovieModel.getActors(1).then((actorList) {
      mActors = actorList ?? [];
      notifyListeners();
    }).catchError((error) {});

    /// Actors from database
    mMovieModel.getActorsFromDatabase().then((actorList) {
      mActors = actorList ?? [];
      notifyListeners();
    }).catchError((error) {});
  }

  onTapGenre(int? generalId) {
    _getMoviesByGenreAndRefresh(generalId ?? 0);
  }

  onNowPlayingMovieListReachEnd() {
    pageForNowPlayingMovieList += 1;
    mMovieModel.getNowPlayingMovie(pageForNowPlayingMovieList);
  }

  _getMoviesByGenreAndRefresh(int generalId) {
    mMovieModel.getMoviesByGenre(generalId).then((movieList) {
      mMovieByGenreList = movieList ?? [];
      notifyListeners();
    }).catchError((error) {});
  }
}
