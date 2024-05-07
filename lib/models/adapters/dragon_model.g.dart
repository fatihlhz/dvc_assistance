// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../dragon_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DragonModelAdapter extends TypeAdapter<DragonModel> {
  @override
  final int typeId = 1;

  @override
  DragonModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DragonModel(
      name: fields[0] as String,
      personality: fields[1] as String,
      agility: fields[2] as int,
      strength: fields[3] as int,
      focus: fields[4] as int,
      intellect: fields[5] as int,
      views: fields[6] as int,
      visit: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DragonModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.personality)
      ..writeByte(2)
      ..write(obj.agility)
      ..writeByte(3)
      ..write(obj.strength)
      ..writeByte(4)
      ..write(obj.focus)
      ..writeByte(5)
      ..write(obj.intellect)
      ..writeByte(6)
      ..write(obj.views)
      ..writeByte(7)
      ..write(obj.visit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DragonModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
