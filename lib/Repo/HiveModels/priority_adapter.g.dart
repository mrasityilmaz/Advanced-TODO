// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'priority_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PriorityEnumAdapter extends TypeAdapter<PriorityEnum> {
  @override
  final int typeId = 7;

  @override
  PriorityEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PriorityEnum.Low;
      case 1:
        return PriorityEnum.Normal;
      case 2:
        return PriorityEnum.High;
      case 3:
        return PriorityEnum.Urgent;
      default:
        return PriorityEnum.Low;
    }
  }

  @override
  void write(BinaryWriter writer, PriorityEnum obj) {
    switch (obj) {
      case PriorityEnum.Low:
        writer.writeByte(0);
        break;
      case PriorityEnum.Normal:
        writer.writeByte(1);
        break;
      case PriorityEnum.High:
        writer.writeByte(2);
        break;
      case PriorityEnum.Urgent:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriorityEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
