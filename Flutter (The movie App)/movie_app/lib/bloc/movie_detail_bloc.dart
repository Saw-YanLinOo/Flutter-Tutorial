import 'dart:async';

import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/credit_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

class MovieDetailBloc {
  StreamController<MovieVO?> mMovieStreamController = StreamController();
  StreamController<List<CreditVO>?> mActorsListStreamController =
      StreamController();
  StreamController<List<CreditVO>?> mCreatorsListStreamController =
      StreamController();

  MovieModel mMovieModel = MovieModelImpl();

  MovieDetailBloc(int movieId) {
    // 🎬 Movie Details
    mMovieModel.getMovieDetails(movieId).then((movie) {
      mMovieStreamController.sink.add(movie);
    });
    // 🎬 Movie Details from database
    mMovieModel.getMovieDetailsFromDatabase(movieId).then((movie) {
      mMovieStreamController.sink.add(movie);
    });

    // 🤹 Get Actor And Creator List
    mMovieModel.getCreditsByMovie(movieId).then((creditList) {
      mActorsListStreamController.sink
          .add(creditList?.where((credit) => credit.isActor()).toList());

      mCreatorsListStreamController.sink
          .add(creditList?.where((credit) => credit.isCreator()).toList());
    });
  }

  void dispose() {
    mMovieStreamController.close();
    mActorsListStreamController.close();
    mCreatorsListStreamController.close();
  }
}
