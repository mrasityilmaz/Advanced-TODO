import 'package:hive/hive.dart';
import 'package:mvvm_provider_todo/Repo/HiveModels/tag_adapter.dart';
import 'package:mvvm_provider_todo/Repo/HiveModels/task_adapter.dart';

import '../../Model/priority_model.dart';

part 'taskcard_adapter.g.dart';

@HiveType(typeId: 2)
class TaskCardHiveModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  List<TaskHiveModel> tasks;

  @HiveField(3)
  bool isPinned;

  @HiveField(4)
  PriorityEnum? priority;

  @HiveField(5)
  bool isDone;

  @HiveField(6)
  List<TagHiveModel> tags;

  @HiveField(7)
  String? groupID;

  @HiveField(8)
  String spaceID;

  TaskCardHiveModel({
    required this.id,
    required this.title,
    required this.tasks,
    required this.isPinned,
    this.priority,
    required this.isDone,
    required this.tags,
    this.groupID,
    required this.spaceID,
  });
}
