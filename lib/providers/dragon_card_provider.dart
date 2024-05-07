import 'dart:async';

import 'package:dvc_assistance/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:dvc_assistance/models/dragon_model.dart';
import 'package:dvc_assistance/models/personality_model.dart';
import '../models/dragon_card_model.dart';

class DragonCardProvider extends ChangeNotifier {
  List<DragonCardModel> _cards = [
    DragonCardModel(
        dragonData: DragonModel(
            name: "God Dragon",
            personality: "Smart",
            agility: 10,
            strength: 0,
            focus: 10,
            intellect: 30,
            views: 0,
            visit: 0),
        targetPersonality: PersonalityModel(
            name: "Capable",
            agility: 28,
            strength: 28,
            focus: 28,
            intellect: 28,
            views: 1,
            visit: 1)),
    DragonCardModel(
        dragonData: DragonModel(
            name: "Darknix",
            personality: "Adamant",
            agility: 10,
            strength: 25,
            focus: 5,
            intellect: 5,
            views: 0,
            visit: 0),
        targetPersonality: PersonalityModel(
            name: "Capable",
            agility: 28,
            strength: 28,
            focus: 28,
            intellect: 28,
            views: 1,
            visit: 1)),
  ];
  final HiveService _hiveService = HiveService();
  bool isLoading = false;

  int _selectedCardIndex = -1;

  List<DragonCardModel> get cards => _cards;
  int get selectedCardIndex => _selectedCardIndex;

  void setCards(List<DragonCardModel> newCards) {
    _cards = newCards;
  }

  Future<void> getAllCards() async {
    isLoading = true;
    notifyListeners();

    final response = await _hiveService.getAllDragonCards();
    _cards = response;
    isLoading = false;
    notifyListeners();
  }

  void addCard(DragonCardModel newCard) {
    _hiveService.addDragonCard(newCard);
    _cards.add(newCard);
    calculateReqStat(cards.last);
    notifyListeners();
  }

  DragonCardModel getSelectedCard() {
    return cards[selectedCardIndex];
  }

  void deleteCard() {
    _hiveService.deleteDragonCard(cards[selectedCardIndex]);
    _cards.removeAt(selectedCardIndex);
    notifyListeners();
  }

  void selectCard(int index) {
    if (_selectedCardIndex == index) {
      _selectedCardIndex = -1;
    } else {
      _selectedCardIndex = index;
    }
    notifyListeners();
  }

  void calculateReqStat(DragonCardModel data) {
    if (data.targetPersonality.fixed != false) {
      switch (data.targetPersonality.name.toLowerCase()) {
        case "capable":
          int maxValue = data.getMaxStat();
          if (maxValue > 28) {
            data.setTargetPersonality(maxValue, maxValue, maxValue, maxValue);
          }
          data.setFixed(true);
          break;
        case "dull":
          int maxValue = data.getMaxStat();
          if (maxValue <= 25) {
            data.setTargetPersonality(maxValue, maxValue, maxValue, maxValue);
          }
          data.setFixed(true);
          break;
        default:
          data.setFixed(false);
          break;
      }
    }
    data.setRequiredStat();
  }

  final Map<int, Timer?> _updateTimers = {};

  void addAgi(int index, int point) {
    cards[index].dragonData.agility += point;
    addHistory(index, point, "AGI");
    notifyListeners();
  }

  void addStr(int index, int point) {
    cards[index].dragonData.strength += point;
    addHistory(index, point, "STR");
    notifyListeners();
  }

  void addFoc(int index, int point) {
    cards[index].dragonData.focus += point;
    addHistory(index, point, "FOC");
    notifyListeners();
  }

  void addInt(int index, int point) {
    cards[index].dragonData.intellect += point;
    addHistory(index, point, "INT");
    notifyListeners();
  }

  void addViews(int index, int point) {
    cards[index].dragonData.views += point;
    addHistory(index, point, "VIEWS");
    notifyListeners();
  }

  void addVisit(int index, int point) {
    cards[index].dragonData.visit += point;
    addHistory(index, point, "VISIT");
    notifyListeners();
  }

  void addHistory(int index, int point, String stat) {
    cards[index].history ??= [];
    cards[index].history?.add("$stat +$point");
    _scheduleDatabaseUpdate(index);
  }

  void undoStep(int index) {
    if (cards[index].history?.isNotEmpty == true) {
      String point = cards[index].history!.last.split(" +")[1];
      String stat = cards[index].history!.last.split(" +")[0];

      switch (stat) {
        case "AGI":
          cards[index].dragonData.agility -= int.parse(point);
          break;
        case "STR":
          cards[index].dragonData.strength -= int.parse(point);
          break;
        case "FOC":
          cards[index].dragonData.focus -= int.parse(point);
          break;
        case "INT":
          cards[index].dragonData.intellect -= int.parse(point);
          break;
        case "VIEWS":
          cards[index].dragonData.views -= int.parse(point);
          break;
        case "VISIT":
          cards[index].dragonData.visit -= int.parse(point);
          break;
      }

      cards[index].history?.removeLast();
      _scheduleDatabaseUpdate(index);
      notifyListeners();
    }
  }

  void _scheduleDatabaseUpdate(int index) {
    _updateTimers[index]?.cancel();

    _updateTimers[index] = Timer(const Duration(seconds: 2), () {
      _updateDatabase(index);
    });
  }

  void _updateDatabase(int index) {
    print("Database is updated!");
    _hiveService.updateDragonCard(index, cards[index]);
    _updateTimers[index]?.cancel();
  }
}
