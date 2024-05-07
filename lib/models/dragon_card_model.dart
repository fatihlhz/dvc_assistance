import 'dart:math';

import 'package:dvc_assistance/models/dragon_model.dart';
import 'package:dvc_assistance/models/personality_model.dart';
import 'package:dvc_assistance/models/required_stat_model.dart';
import 'package:hive/hive.dart';

part './adapters/dragon_card_model.g.dart';

@HiveType(typeId: 0)
class DragonCardModel extends HiveObject {
  @HiveField(0)
  DragonModel dragonData;

  @HiveField(1)
  PersonalityModel targetPersonality;

  @HiveField(2)
  RequiredStatModel requiredStat = RequiredStatModel();

  @HiveField(3)
  List<String>? history = [];

  DragonCardModel({required this.dragonData, required this.targetPersonality});

  int getMaxStat() {
    return max(dragonData.agility,
        max(dragonData.strength, max(dragonData.focus, dragonData.intellect)));
  }

  void setTargetPersonality(int agi, int str, int foc, int int) {
    targetPersonality.agility = agi;
    targetPersonality.strength = str;
    targetPersonality.focus = foc;
    targetPersonality.intellect = int;
  }

  void setRequiredStat() {
    requiredStat.reqAgi = targetPersonality.agility > dragonData.agility
        ? targetPersonality.agility - dragonData.agility
        : 0;

    requiredStat.reqStr = targetPersonality.strength > dragonData.strength
        ? targetPersonality.strength - dragonData.strength
        : 0;

    requiredStat.reqFoc = targetPersonality.focus > dragonData.focus
        ? targetPersonality.focus - dragonData.focus
        : 0;

    requiredStat.reqInt = targetPersonality.intellect > dragonData.intellect
        ? targetPersonality.intellect - dragonData.intellect
        : 0;
  }

  void setFixed(bool value) {
    targetPersonality.fixed = value;
  }
}
