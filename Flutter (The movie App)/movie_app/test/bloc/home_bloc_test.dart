import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/bloc/home_bloc.dart';

import '../data.model/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group('Home Bloc Test', () {
    HomeBloc? homeBloc;

    setUp(() {
      homeBloc = HomeBloc(movieModel: MovieModelImplMocke());
    });

    test('Fetch Now Playing Movie Test', () {
      expect(
        homeBloc?.mNowPlayingMovieList?.contains(getMockMoviesForTest().first),
        true,
      );
    });

    test('Fetch Popular Playing Movie Test', () {
      expect(
        homeBloc?.mPopularMoviesList?.contains(getMockMoviesForTest()[1]),
        true,
      );
    });

    test('Fetch Top Rated Playing Movie Test', () {
      expect(
        homeBloc?.mShowCaseMoveList?.contains(getMockMoviesForTest().last),
        true,
      );
    });

    test('Fetch Genre Test', () {
      expect(
        homeBloc?.mGenerList?.contains(getMockGenre().first),
        true,
      );
    });

    test('Fetch Initial Movie By Genre Test', () async {
      await Future.delayed(const Duration(milliseconds: 500));
      expect(
        homeBloc?.mMovieByGenreList?.contains(getMockMoviesForTest().first),
        true,
      );
    });

    test('Fetch Actor Test', () {
      expect(
        homeBloc?.mActors?.contains(getMockActors().first),
        true,
      );
    });

    test('Fetch Movie By Genre From User Test', () async {
      homeBloc?.onTapGenre(3);

      await Future.delayed(const Duration(milliseconds: 500));

      expect(
        homeBloc?.mMovieByGenreList?.contains(getMockMoviesForTest().last),
        true,
      );
    });
  });
}
