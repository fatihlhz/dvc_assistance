import 'package:hive/hive.dart';

part './adapters/dragon_model.g.dart';

@HiveType(typeId: 1)
class DragonModel {
  @HiveField(0)
  String name;

  @HiveField(1)
  String personality;

  @HiveField(2)
  int agility;

  @HiveField(3)
  int strength;

  @HiveField(4)
  int focus;

  @HiveField(5)
  int intellect;

  @HiveField(6)
  int views;

  @HiveField(7)
  int visit;

  DragonModel({
    required this.name,
    required this.personality,
    required this.agility,
    required this.strength,
    required this.focus,
    required this.intellect,
    required this.views,
    required this.visit,
  });
}
