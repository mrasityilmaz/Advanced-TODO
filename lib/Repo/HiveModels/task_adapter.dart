import 'package:hive/hive.dart';

part 'task_adapter.g.dart';

@HiveType(typeId: 3)
class TaskHiveModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String taskText;
  @HiveField(2)
  bool isDone;

  TaskHiveModel({
    required this.id,
    required this.taskText,
    required this.isDone,
  });
}
