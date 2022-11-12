import 'package:movie_app/data/vos/genre_vo.dart';

abstract class GenreDao {
  void saveAllGenres(List<GenreVO> genreList);
  List<GenreVO> getAllGenre();
}
