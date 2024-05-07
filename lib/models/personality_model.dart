import 'package:hive/hive.dart';

part './adapters/personality_model.g.dart';

@HiveType(typeId: 2)
class PersonalityModel {
  @HiveField(0)
  String name;

  @HiveField(1)
  int agility;

  @HiveField(2)
  int strength;

  @HiveField(3)
  int focus;

  @HiveField(4)
  int intellect;

  @HiveField(5)
  int views;

  @HiveField(6)
  int visit;

  @HiveField(7)
  bool? fixed;

  PersonalityModel({
    required this.name,
    required this.agility,
    required this.strength,
    required this.focus,
    required this.intellect,
    required this.views,
    required this.visit,
  });
}
