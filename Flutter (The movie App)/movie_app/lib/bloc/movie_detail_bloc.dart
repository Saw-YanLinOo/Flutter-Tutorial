import 'package:flutter/foundation.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/credit_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

class MovieDetailBloc extends ChangeNotifier {
  // States
  MovieVO? mMovie;
  List<CreditVO>? mActorsList;
  List<CreditVO>? mCreatorsList;
  List<MovieVO>? mRelatedMovieList;

  // Movie Model
  MovieModel mMovieModel = MovieModelImpl();

  MovieDetailBloc(int movieId, {MovieModel? movieModel}) {
    //Set up movie model mock for test
    if (movieModel != null) {
      mMovieModel = movieModel;
    }
    // Movie Details
    mMovieModel.getMovieDetails(movieId).then((movie) {
      mMovie = movie;
      // if (movie?.genres?.isNotEmpty ?? false) {
        _getRelatedMovieByGenreId(movie?.genres?.first.id ?? 0);
      // }
      notifyListeners();
    });

    // Movie Details from database
    mMovieModel.getMovieDetailsFromDatabase(movieId).then((movie) {
      mMovie = movie;
      notifyListeners();
    });

    mMovieModel.getCreditsByMovie(movieId).then((creditList) {
      mActorsList = creditList?.where((credit) => credit.isActor()).toList();

      mCreatorsList =
          creditList?.where((credit) => credit.isCreator()).toList();

      notifyListeners();
    });
  }

  _getRelatedMovieByGenreId(int genreId) {
    mMovieModel.getMoviesByGenre(genreId).then((relatedMovieList) {
      mRelatedMovieList = relatedMovieList ?? [];
      notifyListeners();
    }).catchError((error) {});
  }
}
