// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/production_company_vo.dart';
import 'package:movie_app/data/vos/production_country_vo.dart';
import 'package:movie_app/data/vos/spoken_language_vo.dart';
import 'package:movie_app/persistence/hive_constants.dart';

import 'collection_vo.dart';

part 'movie_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_MOVIE_VO, adapterName: 'MovieVOAdapter')
class MovieVO {
  @JsonKey(name: 'adult')
  @HiveField(0)
  bool? adult;

  @JsonKey(name: 'back_drop_path')
  @HiveField(1)
  String? backDropPath;

  @JsonKey(name: 'genre_ids')
  @HiveField(2)
  List<int>? genreIds;

  @JsonKey(name: 'id')
  @HiveField(3)
  int? id;

  @JsonKey(name: 'original_language')
  @HiveField(4)
  String? originalLanguage;

  @JsonKey(name: 'original_title')
  @HiveField(5)
  String? originalTitle;

  @JsonKey(name: 'overview')
  @HiveField(6)
  String? overview;

  @JsonKey(name: 'popularity')
  @HiveField(7)
  double? popularity;

  @JsonKey(name: 'poster_path')
  @HiveField(8)
  String? posterPath;

  @JsonKey(name: 'release_date')
  @HiveField(9)
  DateTime? releaseDate;

  @JsonKey(name: 'title')
  @HiveField(10)
  String? title;

  @JsonKey(name: 'video')
  @HiveField(11)
  bool? video;

  @JsonKey(name: 'vote_average')
  @HiveField(12)
  double? voteAverage;

  @JsonKey(name: 'budget')
  @HiveField(13)
  double? budget;

  @JsonKey(name: 'vote_count')
  @HiveField(14)
  int? voteCount;

  @JsonKey(name: 'belongs_to_collection')
  @HiveField(15)
  CollectionVO? belongsToCollection;

  @JsonKey(name: 'genres')
  @HiveField(16)
  List<GenreVO>? genres;

  @JsonKey(name: 'homepage')
  @HiveField(17)
  String? homepage;

  @JsonKey(name: 'imdb_id')
  @HiveField(18)
  String? imdbid;

  @JsonKey(name: 'production_company')
  @HiveField(19)
  List<ProductionCompanyVO>? productionCompany;

  @JsonKey(name: 'production_country')
  @HiveField(20)
  List<ProductionCountryVO>? productionCountry;

  @JsonKey(name: 'revenue')
  @HiveField(21)
  int? revenue;

  @JsonKey(name: 'runtime')
  @HiveField(22)
  int? runtime;

  @JsonKey(name: 'spoken_languages')
  @HiveField(23)
  List<SpokenLanguageVO>? spokenLanguages;

  @JsonKey(name: 'status')
  @HiveField(24)
  String? status;

  @JsonKey(name: 'tagline')
  @HiveField(25)
  String? tagline;

  @HiveField(26)
  bool? isNowPlaying;

  @HiveField(27)
  bool? isPopular;

  @HiveField(28)
  bool? isTopRated;

  MovieVO({
    this.adult,
    this.backDropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.budget,
    this.voteCount,
    this.belongsToCollection,
    this.genres,
    this.homepage,
    this.imdbid,
    this.productionCompany,
    this.productionCountry,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.isNowPlaying,
    this.isPopular,
    this.isTopRated,
  });

  factory MovieVO.fromJson(Map<String, dynamic> json) =>
      _$MovieVOFromJson(json);

  Map<String, dynamic> toJson() => _$MovieVOToJson(this);

  

  @override
  String toString() {
    return 'MovieVO(adult: $adult, backDropPath: $backDropPath, genreIds: $genreIds, id: $id, originalLanguage: $originalLanguage, originalTitle: $originalTitle, overview: $overview, popularity: $popularity, posterPath: $posterPath, releaseDate: $releaseDate, title: $title, video: $video, voteAverage: $voteAverage, budget: $budget, voteCount: $voteCount, belongsToCollection: $belongsToCollection, genres: $genres, homepage: $homepage, imdbid: $imdbid, productionCompany: $productionCompany, productionCountry: $productionCountry, revenue: $revenue, runtime: $runtime, spokenLanguages: $spokenLanguages, status: $status, tagline: $tagline, isNowPlaying: $isNowPlaying, isPopular: $isPopular, isTopRated: $isTopRated)';
  }
}
