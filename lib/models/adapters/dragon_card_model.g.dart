// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../dragon_card_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DragonCardModelAdapter extends TypeAdapter<DragonCardModel> {
  @override
  final int typeId = 0;

  @override
  DragonCardModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DragonCardModel(
      dragonData: fields[0] as DragonModel,
      targetPersonality: fields[1] as PersonalityModel,
    )
      ..requiredStat = fields[2] as RequiredStatModel
      ..history = fields[3] as List<String>?;
  }

  @override
  void write(BinaryWriter writer, DragonCardModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.dragonData)
      ..writeByte(1)
      ..write(obj.targetPersonality)
      ..writeByte(2)
      ..write(obj.requiredStat)
      ..writeByte(3)
      ..write(obj.history);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DragonCardModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
