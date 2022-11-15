import 'package:dio/dio.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/credit_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/network/custom_log_interceptor.dart';
import 'package:movie_app/network/dataagents/movie_data_agent.dart';
import 'package:movie_app/network/the_movie_api.dart';

class RetrofitDataAgentImpl extends MovieDataAgent {
  late TheMovieApi mApi;

  static final RetrofitDataAgentImpl _singleton =
      RetrofitDataAgentImpl._internal();

  factory RetrofitDataAgentImpl() {
    return _singleton;
  }

  RetrofitDataAgentImpl._internal() {
    final dio = Dio();
    // dio.interceptors.add(
    //   CustomLogInterceptor(
    //     requestHeader: true,
    //     requestBody: true,
    //     responseHeader: false,
    //     responseBody: true,
    //   ),
    // );

    mApi = TheMovieApi(dio);
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMovie(int page) {
    return mApi
        .getNowPlayingMovie(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<MovieVO>?> getPopularMovies(int page) {
    return mApi
        .getPopularMovie(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<MovieVO>?> getTopRatedMovies(int page) {
    return mApi
        .getTopRateMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    mApi
        .getMovieByGenre(genreId.toString(), API_KEY, LANGUAGE_EN_US)
        .then((value) {});

    return mApi
        .getMovieByGenre(genreId.toString(), API_KEY, LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.items)
        .first;
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return mApi
        .getGenres(API_KEY, LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.genres)
        .first;
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {
    return mApi
        .getActors(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<CreditVO>?> getCreditsByMovie(int movieId) {
    return mApi
        .getCreditsByMovieResponse(
            movieId.toString(), API_KEY, LANGUAGE_EN_US, '1')
        .asStream()
        .map((response) => response.cost)
        .first;
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return mApi.getMovieDetail(
        movieId.toString(), API_KEY, LANGUAGE_EN_US, '1');
  }
}
