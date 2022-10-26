// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'the_movie_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _TheMovieApi implements TheMovieApi {
  _TheMovieApi(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.themoviedb.org';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<MovieListResponse> getNowPlayingMovie(apiKey, language, page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'api_key': apiKey,
      r'language': language,
      r'page': page
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MovieListResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/3/movie/now_playing',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MovieListResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MovieListResponse> getPopularMovie(apiKey, language, page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'api_key': apiKey,
      r'language': language,
      r'page': page
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MovieListResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/3/movie/popular',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MovieListResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MovieListResponse> getTopRateMovies(apiKey, language, page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'api_key': apiKey,
      r'language': language,
      r'page': page
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MovieListResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/3/movie/top_rated',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MovieListResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetGenresResponse> getGenres(apiKey, language) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'api_key': apiKey,
      r'language': language
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetGenresResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/3/genre/movie/list',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetGenresResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetMovieByGenreResponse> getMovieByGenre(
      generalId, apiKey, language) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'with_genres': generalId,
      r'api_key': apiKey,
      r'language': language
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetMovieByGenreResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/3/discover/movie',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetMovieByGenreResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetActorResponse> getActors(apiKey, language, page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'api_key': apiKey,
      r'language': language,
      r'page': page
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetActorResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/3/person/popular',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetActorResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MovieVO?> getMovieDetail(movieId, apiKey, language, page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'api_key': apiKey,
      r'language': language,
      r'page': page
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<MovieVO>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/3/movie/${movieId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null ? null : MovieVO.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetCreditsByMovieResponse> getCreditsByMovieResponse(
      movieId, apiKey, language, page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'api_key': apiKey,
      r'language': language,
      r'page': page
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetCreditsByMovieResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/3/movie/${movieId}/credits',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetCreditsByMovieResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
