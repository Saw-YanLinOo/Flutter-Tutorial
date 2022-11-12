import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/persistence/daos/genre_dao.dart';

class GenreDaoImplMock extends GenreDao {
  Map<int, GenreVO> genreListFromDatabaseMock = {};

  @override
  List<GenreVO> getAllGenre() {
    return genreListFromDatabaseMock.values.toList();
  }

  @override
  void saveAllGenres(List<GenreVO> genreList) {
    for (var genre in genreList) {
      genreListFromDatabaseMock[genre.id ?? 0] = genre;
    }
  }
}
