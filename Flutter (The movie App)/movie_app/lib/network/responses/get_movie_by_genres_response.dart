import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
part 'get_movie_by_genres_response.g.dart';

@JsonSerializable()
class GetMovieByGenreResponse {
  @JsonKey(name: 'results')
  List<MovieVO>? items;

  GetMovieByGenreResponse(this.items);

  factory GetMovieByGenreResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMovieByGenreResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetMovieByGenreResponseToJson(this);
}
