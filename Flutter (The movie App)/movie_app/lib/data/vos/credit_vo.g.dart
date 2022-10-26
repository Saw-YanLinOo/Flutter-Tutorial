// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreditVOAdapter extends TypeAdapter<CreditVO> {
  @override
  final int typeId = 4;

  @override
  CreditVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreditVO(
      adult: fields[2] as bool?,
      gender: fields[3] as int?,
      id: fields[4] as int?,
      konwnForDepartment: fields[5] as String?,
      name: fields[0] as String?,
      originalName: fields[6] as String?,
      profilePath: fields[1] as String?,
      castId: fields[7] as int?,
      character: fields[8] as String?,
      creditId: fields[9] as String?,
      order: fields[10] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, CreditVO obj) {
    writer
      ..writeByte(11)
      ..writeByte(2)
      ..write(obj.adult)
      ..writeByte(3)
      ..write(obj.gender)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.konwnForDepartment)
      ..writeByte(6)
      ..write(obj.originalName)
      ..writeByte(7)
      ..write(obj.castId)
      ..writeByte(8)
      ..write(obj.character)
      ..writeByte(9)
      ..write(obj.creditId)
      ..writeByte(10)
      ..write(obj.order)
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
      other is CreditVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditVO _$CreditVOFromJson(Map<String, dynamic> json) => CreditVO(
      adult: json['adult'] as bool?,
      gender: json['gender'] as int?,
      id: json['id'] as int?,
      konwnForDepartment: json['known_for_department'] as String?,
      name: json['name'] as String?,
      originalName: json['original_name'] as String?,
      profilePath: json['profile_path'] as String?,
      castId: json['cast_id'] as int?,
      character: json['character'] as String?,
      creditId: json['credit_id'] as String?,
      order: json['order'] as int?,
    );

Map<String, dynamic> _$CreditVOToJson(CreditVO instance) => <String, dynamic>{
      'name': instance.name,
      'profile_path': instance.profilePath,
      'adult': instance.adult,
      'gender': instance.gender,
      'id': instance.id,
      'known_for_department': instance.konwnForDepartment,
      'original_name': instance.originalName,
      'cast_id': instance.castId,
      'character': instance.character,
      'credit_id': instance.creditId,
      'order': instance.order,
    };
