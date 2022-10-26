// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actor_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActorVOAdapter extends TypeAdapter<ActorVO> {
  @override
  final int typeId = 1;

  @override
  ActorVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActorVO(
      adult: fields[3] as bool?,
      id: fields[2] as int?,
      knownFor: (fields[4] as List?)?.cast<MovieVO>(),
      name: fields[0] as String?,
      profilePath: fields[1] as String?,
      popularity: fields[5] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, ActorVO obj) {
    writer
      ..writeByte(6)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.adult)
      ..writeByte(4)
      ..write(obj.knownFor)
      ..writeByte(5)
      ..write(obj.popularity)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.profilePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActorVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActorVO _$ActorVOFromJson(Map<String, dynamic> json) => ActorVO(
      adult: json['adult'] as bool?,
      id: json['id'] as int?,
      knownFor: (json['known_for'] as List<dynamic>?)
          ?.map((e) => MovieVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
      profilePath: json['profile_path'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ActorVOToJson(ActorVO instance) => <String, dynamic>{
      'name': instance.name,
      'profile_path': instance.profilePath,
      'id': instance.id,
      'adult': instance.adult,
      'known_for': instance.knownFor,
      'popularity': instance.popularity,
    };
