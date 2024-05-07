// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../required_stat_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RequiredStatModelAdapter extends TypeAdapter<RequiredStatModel> {
  @override
  final int typeId = 3;

  @override
  RequiredStatModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RequiredStatModel()
      ..reqAgi = fields[0] as int
      ..reqStr = fields[1] as int
      ..reqFoc = fields[2] as int
      ..reqInt = fields[3] as int
      ..reqViews = fields[4] as int
      ..reqVisit = fields[5] as int;
  }

  @override
  void write(BinaryWriter writer, RequiredStatModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.reqAgi)
      ..writeByte(1)
      ..write(obj.reqStr)
      ..writeByte(2)
      ..write(obj.reqFoc)
      ..writeByte(3)
      ..write(obj.reqInt)
      ..writeByte(4)
      ..write(obj.reqViews)
      ..writeByte(5)
      ..write(obj.reqVisit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequiredStatModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
