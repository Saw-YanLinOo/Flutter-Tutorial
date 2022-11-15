import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';

import '../mock_data/mock_data.dart';
import '../network/movie_data_agent_impl_mock.dart';
import '../persistence/actor_dao_impl_mock.dart';
import '../persistence/genre_dao_impl_mock.dart';
import '../persistence/movie_dao_impl_mock.dart';

void main() {
  group('Movie Model Impl', () {
    var movieModel = MovieModelImpl();

    setUp(() {
      movieModel.setDaoAndDataAgent(
        MovieDaoImplMock(),
        GenreDaoImplMock(),
        ActorDaoImplMock(),
        MovieDataAgentImplMock(),
      );
    });

    test(
      'Saving Now Playing Movie and Getting Now Playing Movie From Database',
      () {
        expect(
          movieModel.getNowPlayingMoviesFromDatabase(),
          emits(
            [
              getMockMoviesForTest()[0],
            ],
          ),
        );
      },
    );

    test(
      'Saving Popular Playing Movie and Getting Popular Playing Movie From Database',
      () {
        expect(
          movieModel.getPopularMoviesFromDatabase(),
          emits(
            [
              getMockMoviesForTest()[1],
            ],
          ),
        );
      },
    );

    test(
      'Saving Top Related Playing Movie and Getting Top Related Playing Movie From Database',
      () {
        expect(
          movieModel.getTopRatedMoviesFromDatabase(),
          emits(
            [
              getMockMoviesForTest()[2],
            ],
          ),
        );
      },
    );

    test('Get Genre Test', () {
      expect(
        movieModel.getGenres(),
        completion(
          equals(getMockGenre()),
        ),
      );
    });

    test('Get Actor Test', () {
      expect(
        movieModel.getActors(1),
        completion(
          equals(getMockActors()),
        ),
      );
    });

    test('Get Credit Test', () {
      expect(
        movieModel.getCreditsByMovie(1),
        completion(
          equals(getMockCredits()),
        ),
      );
    });

    test('Get Movie Detail Test', () {
      expect(
        movieModel.getMovieDetails(1),
        completion(
          equals(getMockMoviesForTest().first),
        ),
      );
    });

    test('Get Actors From Database Test', () async {
      await movieModel.getActors(1);
      expect(
        movieModel.getActorsFromDatabase(),
        completion(
          equals(getMockActors()),
        ),
      );
    });

    test('Get Movie Detail From Database Test', () async {
      await movieModel.getMovieDetails(1);
      expect(
        movieModel.getMovieDetailsFromDatabase(19995),
        completion(
          equals(getMockMoviesForTest().first),
        ),
      );
    });

    test('Get Genre From Database Test', () async {
      await movieModel.getGenres();
      expect(
        movieModel.getGenresFromDatabase(),
        completion(
          equals(getMockGenre()),
        ),
      );
    });
  });
}
