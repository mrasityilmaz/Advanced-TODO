import 'package:mvvm_provider_todo/Model/tag_model.dart';
import 'package:mvvm_provider_todo/Repo/HiveModels/tag_adapter.dart';

import 'priority_model.dart';

class NormalCardModel {
  String id;
  String title;
  String description;

  bool isPinned;

  PriorityEnum priority;

  bool isDone;

  List<TagHiveModel> tags;

  String? groupID;

  String spaceID;

  NormalCardModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isPinned,
    required this.priority,
    required this.isDone,
    required this.tags,
    this.groupID,
    required this.spaceID,
  });
}
