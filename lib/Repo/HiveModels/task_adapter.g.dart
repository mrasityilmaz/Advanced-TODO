// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskHiveModelAdapter extends TypeAdapter<TaskHiveModel> {
  @override
  final int typeId = 3;

  @override
  TaskHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskHiveModel(
      id: fields[0] as String,
      taskText: fields[1] as String,
      isDone: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TaskHiveModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.taskText)
      ..writeByte(2)
      ..write(obj.isDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
