// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'space_content_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpaceContentHiveModelAdapter extends TypeAdapter<SpaceContentHiveModel> {
  @override
  final int typeId = 6;

  @override
  SpaceContentHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SpaceContentHiveModel(
      id: fields[0] as String,
      title: fields[1] as String,
      childrens: (fields[2] as List).cast<Object>(),
    );
  }

  @override
  void write(BinaryWriter writer, SpaceContentHiveModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.childrens);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpaceContentHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
