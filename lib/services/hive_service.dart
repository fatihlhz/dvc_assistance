import 'package:dvc_assistance/models/dragon_card_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  Future<Box<DragonCardModel>> openDragonCardBox() async {
    return await Hive.openBox<DragonCardModel>('dragonCard');
  }

  Future<void> addDragonCard(DragonCardModel DragonCard) async {
    final box = await openDragonCardBox();
    final id = await box.add(DragonCard);
    print("Created by id: $id");
  }

  Future<List<DragonCardModel>> getAllDragonCards() async {
    final box = await openDragonCardBox();
    return box.values.toList();
  }

  Future<DragonCardModel?> getDragonCardById(DragonCardModel dragonCard) async {
    final box = await openDragonCardBox();
    return box.get(dragonCard);
  }

  Future<void> updateDragonCard(
      int id, DragonCardModel updatedDragonCard) async {
    final box = await openDragonCardBox();
    final dragonCard = box.get(id);
    if (dragonCard != null) {
      dragonCard.dragonData = updatedDragonCard.dragonData;
      dragonCard.targetPersonality = updatedDragonCard.targetPersonality;
      await dragonCard.save();
    }
  }

  Future<void> deleteDragonCard(DragonCardModel dragonCard) async {
    final box = await openDragonCardBox();
    await box.delete(dragonCard.key);
  }
}
