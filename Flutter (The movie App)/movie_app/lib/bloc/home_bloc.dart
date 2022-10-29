import 'package:flutter/foundation.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

class HomeBloc extends ChangeNotifier {
  //State
  List<MovieVO>? mNowPlayingMovieList;
  List<MovieVO>? mPopularMoviesList;
  List<GenreVO>? mGenerList;
  List<ActorVO>? mActors;
  List<MovieVO>? mShowCaseMoveList;
  List<MovieVO>? mMovieByGenreList;
}
