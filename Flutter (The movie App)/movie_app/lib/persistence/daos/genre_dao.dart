import 'package:hive/hive.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/persistence/hive_constants.dart';

class GenreDao{
   GenreDao._internal();

  static final GenreDao _singleton = GenreDao._internal();

  factory GenreDao() => _singleton;

  void saveAllGenres(List<GenreVO> genreList) async {
    Map<int?, GenreVO> genreMap = {
      for (var genre in genreList) genre.id: genre
    };

    await getGenreBox().putAll(genreMap);
  }

  List<GenreVO> getAllGenre() {
    return getGenreBox().values.toList();
  }

  Box<GenreVO> getGenreBox() {
    return Hive.box<GenreVO>(BOX_NAME_GENRE_VO);
  }
}