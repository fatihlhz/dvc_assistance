// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../personality_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonalityModelAdapter extends TypeAdapter<PersonalityModel> {
  @override
  final int typeId = 2;

  @override
  PersonalityModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonalityModel(
      name: fields[0] as String,
      agility: fields[1] as int,
      strength: fields[2] as int,
      focus: fields[3] as int,
      intellect: fields[4] as int,
      views: fields[5] as int,
      visit: fields[6] as int,
    )..fixed = fields[7] as bool?;
  }

  @override
  void write(BinaryWriter writer, PersonalityModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.agility)
      ..writeByte(2)
      ..write(obj.strength)
      ..writeByte(3)
      ..write(obj.focus)
      ..writeByte(4)
      ..write(obj.intellect)
      ..writeByte(5)
      ..write(obj.views)
      ..writeByte(6)
      ..write(obj.visit)
      ..writeByte(7)
      ..write(obj.fixed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonalityModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
