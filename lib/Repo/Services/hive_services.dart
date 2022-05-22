import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mvvm_provider_todo/Model/group_card_model.dart';
import 'package:mvvm_provider_todo/Model/space_model.dart';

import 'package:mvvm_provider_todo/Repo/HiveModels/card_adapter.dart';
import 'package:mvvm_provider_todo/Repo/HiveModels/group_adapter.dart';
import 'package:mvvm_provider_todo/Repo/HiveModels/space_content_adapter.dart';
import 'package:mvvm_provider_todo/Repo/HiveModels/tag_adapter.dart';
import 'package:mvvm_provider_todo/Repo/HiveModels/taskcard_adapter.dart';
import 'package:mvvm_provider_todo/Utils/Constants/constants.dart';

class DatabaseServices extends ChangeNotifier {
  final Box<TagHiveModel> _tagBox = Hive.box<TagHiveModel>(tagsKey);
  Box<TagHiveModel> get tagsBox => _tagBox;
  final Box<SpaceContentHiveModel> _spaceBox =
      Hive.box<SpaceContentHiveModel>(spaceContentKey);
  Box<SpaceContentHiveModel> get spacesBox => _spaceBox;

  final List<TagHiveModel> _selectedTags = [];

  List<TagHiveModel> get selectedTags => _selectedTags;

  bool _selectableMode = false;

  bool get selectableMode => _selectableMode;

  final List<Object> _selectedCards = [];

  List<Object> get selectedCards => _selectedCards;

  Future init() async {
    // Initialize Default Values
    var initialTags = {
      "_123business123_": {"Business": Colors.deepPurple.value},
      "_123special123_": {"Special": Colors.blueGrey.value},
      "_123school123_": {"School": Colors.limeAccent.value}
    };

    if (_tagBox.isEmpty) {
      await _tagBox.addAll(initialTags.entries.map((e) => TagHiveModel(
          id: e.key,
          name: e.value.entries.first.key,
          tagColor: e.value.entries.first.value)));
    }

    //*
  }

  addNewTag(TagHiveModel model) async {
    await _tagBox.add(model);
  }

  selectTag(String id) {
    _selectedTags
        .add(_tagBox.values.toList().firstWhere((element) => element.id == id));
    notifyListeners();
  }

  unselectTag(String id) {
    _selectedTags.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  clearSelectedTag() {
    _selectedTags.clear();
    notifyListeners();
  }

  SpaceContentHiveModel? getCurrentSpace(String? id) {
    if (id == null) {
      return null;
    } else {
      return _spaceBox.values.firstWhere((e) => e.id == id);
    }
  }

  addNewSpace(WorkspaceModel model) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    SpaceContentHiveModel space = SpaceContentHiveModel(
        id: id, title: model.title, childrens: model.childrens);

    await _spaceBox.add(space);

    notifyListeners();
  }

  Future addCard(String spaceId, Object model) async {
    dynamic key =
        _spaceBox.values.firstWhere((element) => element.id == spaceId).key;
    _spaceBox.get(key)!.childrens.add(model);
    await _spaceBox.get(key)!.save();

    notifyListeners();
  }

  Future removeCard(String spaceId, Object model) async {
    dynamic key =
        _spaceBox.values.firstWhere((element) => element.id == spaceId).key;
    bool s = _spaceBox.get(key)!.childrens.remove(model);
    await _spaceBox.get(key)!.save();

    notifyListeners();
  }

  Future addGroup(String spaceID, GroupCardHiveModel model) async {
    dynamic key =
        _spaceBox.values.firstWhere((element) => element.id == spaceID).key;
    _spaceBox.get(key)!.childrens.add(model);
    await _spaceBox.get(key)!.save();
    notifyListeners();
  }

  Future moveToGroup(String spaceID, String groupID, List<Object> items) async {
    dynamic key =
        _spaceBox.values.firstWhere((element) => element.id == spaceID).key;

    items.forEach((e) async {
      NormalCardHiveModel card = (_spaceBox
          .get(key)!
          .childrens
          .firstWhere((element) => element == e)) as NormalCardHiveModel;

      card.groupID = groupID;
      _spaceBox
          .get(key)!
          .childrens
          .removeWhere((s) => s is NormalCardHiveModel && (s).id == card.id);

      _spaceBox.get(key)!.childrens.add(card);
      await _spaceBox.get(key)!.save();
      notifyListeners();
    });
  }

  /// Type indexes
  ///
  /// 0 is Title   - 1 is Description
  ///
  /// 2 is Tags    - 3 is Priority
  ///
  /// 4 is groupID - 5 is spaceID
  ///
  /// 6 is isPinned- 7 is isDone
  ///
  Future modifyNormalCard(
      String spaceID, String cardID, int type, dynamic value) async {
    dynamic key =
        _spaceBox.values.firstWhere((element) => element.id == spaceID).key;
    NormalCardHiveModel? model = _spaceBox.get(key)!.childrens.firstWhere(
            (element) => (element as NormalCardHiveModel).id == cardID)
        as NormalCardHiveModel?;
    if (model != null) {
      switch (type) {
        case 0:
          model.title = value;
          break;
        case 1:
          model.description = value;
          break;
        case 2:
          model.tags = value;
          break;
        case 3:
          model.priority = value;
          break;
        case 4:
          model.groupID = value;
          break;
        case 5:
          model.spaceID = value;
          break;
        case 6:
          model.isPinned = value;

          break;
        case 7:
          model.isDone = value;
          break;
      }
      await _spaceBox.get(key)!.save();
      notifyListeners();
    }
  }

  List<TagHiveModel> getTags() {
    return _tagBox.values.toList();
  }

  deleteAllSpace() async {
    _spaceBox.clear();
    notifyListeners();
  }

  selectAllCards(String spaceId) async {
    _selectedCards.clear();
    _selectedCards.addAll(getCurrentSpace(spaceId)!.childrens);
    notifyListeners();
  }

  addSelectedCards(Object card) {
    _selectedCards.add(card);
    notifyListeners();
  }

  removeSelectedCards(Object card) {
    _selectedCards.remove(card);
    notifyListeners();
  }

  openOrCloseSelectableMode(bool value) {
    _selectableMode = value;
    if (!value) {
      _selectedCards.clear();
    }
    notifyListeners();
  }

  // Future getAllSpaces() async {
  //   List<SpaceHiveModel> spaces = _spaceHiveModel.values.toList();

  //   return spaces;
  // }

}
