import 'dart:convert';

import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/credit_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/network/dataagents/movie_data_agent.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/network/responses/get_now_playing_response.dart';

import '../../data/vos/movie_vo.dart';

class HttpMovieDataAgentImpl extends MovieDataAgent {
  static final HttpMovieDataAgentImpl _singleton =
      HttpMovieDataAgentImpl._internal();

  factory HttpMovieDataAgentImpl() {
    return _singleton;
  }

  HttpMovieDataAgentImpl._internal();

  @override
  Future<List<MovieVO>?> getNowPlayingMovie(int page) {
    Map<String, String> qureyParameter = {
      PARAM_API_KEY: API_KEY,
      PARAM_LANGUAGE: LANGUAGE_EN_US,
      PARAM_PAGE: page.toString(),
    };

    var url = Uri.https(
      BASE_URL_HTTP,
      ENDPOINT_GET_NOW_PLAYING,
      qureyParameter,
    );

    return http
        .get(url)
        .then((value) => MovieListResponse.fromJson(jsonDecode(value.body)))
        .then((value) => value.results);
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {
    // TODO: implement getActors
    throw UnimplementedError();
  }

  @override
  Future<List<MovieVO>?> getPopularMovies(int page) {
    // TODO: implement getPopularMovies
    throw UnimplementedError();
  }

  @override
  Future<List<MovieVO>?> getTopRAtedMovies(int page) {
    // TODO: implement getTopRAtedMovies
    throw UnimplementedError();
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    // TODO: implement getGenres
    throw UnimplementedError();
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    // TODO: implement getMoviesByGenre
    throw UnimplementedError();
  }

  @override
  Future<List<MovieVO>?> getTopRatedMovies(int page) {
    // TODO: implement getTopRatedMovies
    throw UnimplementedError();
  }

  @override
  Future<List<CreditVO>?> getCreditsByMovie(int movieId) {
    // TODO: implement getCreditsByMovie
    throw UnimplementedError();
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    // TODO: implement getMovieDetails
    throw UnimplementedError();
  }
}
