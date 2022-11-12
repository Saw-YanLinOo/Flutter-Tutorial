import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/bloc/movie_detail_bloc.dart';

import '../data.model/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group('Movie Detail Bloc Test', () {
    MovieDetailBloc? movieDetailBloc;

    setUp(() {
      movieDetailBloc = MovieDetailBloc(1, movieModel: MovieModelImplMocke());
    });

    test('Fetch Movie Detail Test', () {
      expect(movieDetailBloc?.mMovie, getMockMoviesForTest().first);
    });

    test('Fetch Actor List Test', () {
      expect(
        movieDetailBloc?.mActorsList?.contains(getMockCredits().first),
        true,
      );
    });

    test('Fetch Creator List Test', () {
      expect(
        movieDetailBloc?.mCreatorsList?.contains(getMockCredits().last),
        true,
      );
    });

    test('Fetch Related Movie List Test', () async {
      await Future.delayed(const Duration(milliseconds: 500));

      expect(
        movieDetailBloc?.mRelatedMovieList
            ?.contains(getMockMoviesForTest().first),
        true,
      );
    });
  });
}
