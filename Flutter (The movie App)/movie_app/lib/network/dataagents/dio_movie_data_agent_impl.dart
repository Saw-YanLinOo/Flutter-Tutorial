import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/credit_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/dataagents/movie_data_agent.dart';

import '../api_constants.dart';
import '../responses/get_now_playing_response.dart';

class DioMovieDataAgentImpl extends MovieDataAgent {
  late Dio dio;

  static final DioMovieDataAgentImpl _singleton =
      DioMovieDataAgentImpl._internal();

  factory DioMovieDataAgentImpl() {
    return _singleton;
  }

  DioMovieDataAgentImpl._internal() {
    dio = Dio();
  }

  
  @override
  Future<List<MovieVO>?> getNowPlayingMovie(int page) {
    Map<String, String> qureyParameter = {
      PARAM_API_KEY: API_KEY,
      PARAM_LANGUAGE: LANGUAGE_EN_US,
      PARAM_PAGE: page.toString(),
    };

    return dio
        .get(
          "$BASE_URL_DIO$ENDPOINT_GET_NOW_PLAYING",
          queryParameters: qureyParameter,
        )
        .then((value) => MovieListResponse.fromJson(value.data))
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
  Future<List<GenreVO>?> getGenres() {
    // TODO: implement getGenres
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
