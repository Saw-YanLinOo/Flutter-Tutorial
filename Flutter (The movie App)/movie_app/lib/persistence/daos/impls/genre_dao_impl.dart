import 'package:hive/hive.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/persistence/daos/genre_dao.dart';
import 'package:movie_app/persistence/hive_constants.dart';

class GenreDaoImpl extends GenreDao {
  GenreDaoImpl._internal();

  static final GenreDaoImpl _singleton = GenreDaoImpl._internal();

  factory GenreDaoImpl() => _singleton;

  @override
  void saveAllGenres(List<GenreVO> genreList) async {
    Map<int?, GenreVO> genreMap = {
      for (var genre in genreList) genre.id: genre
    };

    await getGenreBox().putAll(genreMap);
  }

  @override
  List<GenreVO> getAllGenre() {
    return getGenreBox().values.toList();
  }

  Box<GenreVO> getGenreBox() {
    return Hive.box<GenreVO>(BOX_NAME_GENRE_VO);
  }
}
