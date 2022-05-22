import 'package:mvvm_provider_todo/Model/tag_model.dart';
import 'package:mvvm_provider_todo/Model/task_model.dart';
import 'package:mvvm_provider_todo/Repo/HiveModels/tag_adapter.dart';
import 'package:mvvm_provider_todo/Repo/HiveModels/task_adapter.dart';

import 'priority_model.dart';

class TaskCardModel {
  String id;
  String title;
  List<TaskHiveModel> tasks;

  bool isPinned;

  PriorityEnum priority;

  bool isDone;

  List<TagHiveModel> tags;

  String? groupID;

  String spaceID;

  TaskCardModel({
    required this.id,
    required this.title,
    required this.tasks,
    required this.isPinned,
    required this.priority,
    required this.isDone,
    required this.tags,
    this.groupID,
    required this.spaceID,
  });
}
