import 'package:hive/hive.dart';

part './adapters/required_stat_model.g.dart';

@HiveType(typeId: 3)
class RequiredStatModel {
  @HiveField(0)
  int reqAgi = 0;

  @HiveField(1)
  int reqStr = 0;

  @HiveField(2)
  int reqFoc = 0;

  @HiveField(3)
  int reqInt = 0;

  @HiveField(4)
  int reqViews = 0;

  @HiveField(5)
  int reqVisit = 0;

  RequiredStatModel();
}
