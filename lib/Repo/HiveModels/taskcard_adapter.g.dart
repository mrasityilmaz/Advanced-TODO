// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taskcard_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskCardHiveModelAdapter extends TypeAdapter<TaskCardHiveModel> {
  @override
  final int typeId = 2;

  @override
  TaskCardHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskCardHiveModel(
      id: fields[0] as String,
      title: fields[1] as String,
      tasks: (fields[2] as List).cast<TaskHiveModel>(),
      isPinned: fields[3] as bool,
      priority: fields[4] as PriorityEnum?,
      isDone: fields[5] as bool,
      tags: (fields[6] as List).cast<TagHiveModel>(),
      groupID: fields[7] as String?,
      spaceID: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TaskCardHiveModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.tasks)
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
      ..write(obj.spaceID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskCardHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
