// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieVOAdapter extends TypeAdapter<MovieVO> {
  @override
  final int typeId = 7;

  @override
  MovieVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieVO(
      index: fields[29] as int?,
      adult: fields[0] as bool?,
      backDropPath: fields[1] as String?,
      genreIds: (fields[2] as List?)?.cast<int>(),
      id: fields[3] as int?,
      originalLanguage: fields[4] as String?,
      originalTitle: fields[5] as String?,
      overview: fields[6] as String?,
      popularity: fields[7] as double?,
      posterPath: fields[8] as String?,
      releaseDate: fields[9] as DateTime?,
      title: fields[10] as String?,
      video: fields[11] as bool?,
      voteAverage: fields[12] as double?,
      budget: fields[13] as double?,
      voteCount: fields[14] as int?,
      belongsToCollection: fields[15] as CollectionVO?,
      genres: (fields[16] as List?)?.cast<GenreVO>(),
      homepage: fields[17] as String?,
      imdbid: fields[18] as String?,
      productionCompany: (fields[19] as List?)?.cast<ProductionCompanyVO>(),
      productionCountry: (fields[20] as List?)?.cast<ProductionCountryVO>(),
      revenue: fields[21] as int?,
      runtime: fields[22] as int?,
      spokenLanguages: (fields[23] as List?)?.cast<SpokenLanguageVO>(),
      status: fields[24] as String?,
      tagline: fields[25] as String?,
      isNowPlaying: fields[26] as bool?,
      isPopular: fields[27] as bool?,
      isTopRated: fields[28] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, MovieVO obj) {
    writer
      ..writeByte(30)
      ..writeByte(0)
      ..write(obj.adult)
      ..writeByte(1)
      ..write(obj.backDropPath)
      ..writeByte(2)
      ..write(obj.genreIds)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.originalLanguage)
      ..writeByte(5)
      ..write(obj.originalTitle)
      ..writeByte(6)
      ..write(obj.overview)
      ..writeByte(7)
      ..write(obj.popularity)
      ..writeByte(8)
      ..write(obj.posterPath)
      ..writeByte(9)
      ..write(obj.releaseDate)
      ..writeByte(10)
      ..write(obj.title)
      ..writeByte(11)
      ..write(obj.video)
      ..writeByte(12)
      ..write(obj.voteAverage)
      ..writeByte(13)
      ..write(obj.budget)
      ..writeByte(14)
      ..write(obj.voteCount)
      ..writeByte(15)
      ..write(obj.belongsToCollection)
      ..writeByte(16)
      ..write(obj.genres)
      ..writeByte(17)
      ..write(obj.homepage)
      ..writeByte(18)
      ..write(obj.imdbid)
      ..writeByte(19)
      ..write(obj.productionCompany)
      ..writeByte(20)
      ..write(obj.productionCountry)
      ..writeByte(21)
      ..write(obj.revenue)
      ..writeByte(22)
      ..write(obj.runtime)
      ..writeByte(23)
      ..write(obj.spokenLanguages)
      ..writeByte(24)
      ..write(obj.status)
      ..writeByte(25)
      ..write(obj.tagline)
      ..writeByte(26)
      ..write(obj.isNowPlaying)
      ..writeByte(27)
      ..write(obj.isPopular)
      ..writeByte(28)
      ..write(obj.isTopRated)
      ..writeByte(29)
      ..write(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieVO _$MovieVOFromJson(Map<String, dynamic> json) => MovieVO(
      index: json['index'] as int?,
      adult: json['adult'] as bool?,
      backDropPath: json['back_drop_path'] as String?,
      genreIds:
          (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
      id: json['id'] as int?,
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] == null
          ? null
          : DateTime.parse(json['release_date'] as String),
      title: json['title'] as String?,
      video: json['video'] as bool?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      budget: (json['budget'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int?,
      belongsToCollection: json['belongs_to_collection'] == null
          ? null
          : CollectionVO.fromJson(
              json['belongs_to_collection'] as Map<String, dynamic>),
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => GenreVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      homepage: json['homepage'] as String?,
      imdbid: json['imdb_id'] as String?,
      productionCompany: (json['production_company'] as List<dynamic>?)
          ?.map((e) => ProductionCompanyVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      productionCountry: (json['production_country'] as List<dynamic>?)
          ?.map((e) => ProductionCountryVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      revenue: json['revenue'] as int?,
      runtime: json['runtime'] as int?,
      spokenLanguages: (json['spoken_languages'] as List<dynamic>?)
          ?.map((e) => SpokenLanguageVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      tagline: json['tagline'] as String?,
      isNowPlaying: json['isNowPlaying'] as bool?,
      isPopular: json['isPopular'] as bool?,
      isTopRated: json['isTopRated'] as bool?,
    );

Map<String, dynamic> _$MovieVOToJson(MovieVO instance) => <String, dynamic>{
      'adult': instance.adult,
      'back_drop_path': instance.backDropPath,
      'genre_ids': instance.genreIds,
      'id': instance.id,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate?.toIso8601String(),
      'title': instance.title,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'budget': instance.budget,
      'vote_count': instance.voteCount,
      'belongs_to_collection': instance.belongsToCollection,
      'genres': instance.genres,
      'homepage': instance.homepage,
      'imdb_id': instance.imdbid,
      'production_company': instance.productionCompany,
      'production_country': instance.productionCountry,
      'revenue': instance.revenue,
      'runtime': instance.runtime,
      'spoken_languages': instance.spokenLanguages,
      'status': instance.status,
      'tagline': instance.tagline,
      'isNowPlaying': instance.isNowPlaying,
      'isPopular': instance.isPopular,
      'isTopRated': instance.isTopRated,
      'index': instance.index,
    };
