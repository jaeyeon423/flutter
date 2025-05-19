// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dday.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DDayAdapter extends TypeAdapter<DDay> {
  @override
  final int typeId = 0;

  @override
  DDay read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DDay(
      id: fields[0] as String,
      title: fields[1] as String,
      targetDate: fields[2] as DateTime,
      description: fields[3] as String?,
      hasReminder: fields[4] as bool,
      reminderTime: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, DDay obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.targetDate)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.hasReminder)
      ..writeByte(5)
      ..write(obj.reminderTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DDayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
