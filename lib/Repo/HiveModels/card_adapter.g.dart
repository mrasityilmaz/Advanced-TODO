// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NormalCardHiveModelAdapter extends TypeAdapter<NormalCardHiveModel> {
  @override
  final int typeId = 1;

  @override
  NormalCardHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NormalCardHiveModel(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      isPinned: fields[3] as bool,
      priority: fields[4] as PriorityEnum?,
      isDone: fields[5] as bool,
      tags: (fields[6] as List).cast<TagHiveModel>(),
      groupID: fields[7] as String?,
      spaceID: fields[8] as String,
      createdDate: fields[9] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, NormalCardHiveModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.isPinned)
      ..writeByte(4)
      ..write(obj.priority)
      ..writeByte(5)
      ..write(obj.isDone)
      ..writeByte(6)
      ..write(obj.tags)
      ..writeByte(7)
      ..write(obj.groupID)
      ..writeByte(8)
      ..write(obj.spaceID)
      ..writeByte(9)
      ..write(obj.createdDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NormalCardHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
