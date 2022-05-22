// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroupCardHiveModelAdapter extends TypeAdapter<GroupCardHiveModel> {
  @override
  final int typeId = 4;

  @override
  GroupCardHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GroupCardHiveModel(
      id: fields[0] as String,
      title: fields[1] as String,
      childrens: (fields[2] as List).cast<Object>(),
      isPinned: fields[3] as bool,
      color: fields[4] as int,
      completedCount: fields[5] as int,
      allCount: fields[6] as int,
      spaceID: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GroupCardHiveModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.childrens)
      ..writeByte(3)
      ..write(obj.isPinned)
      ..writeByte(4)
      ..write(obj.color)
      ..writeByte(5)
      ..write(obj.completedCount)
      ..writeByte(6)
      ..write(obj.allCount)
      ..writeByte(7)
      ..write(obj.spaceID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupCardHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
