import 'package:hive/hive.dart';
import 'package:mvvm_provider_todo/Repo/HiveModels/priority_adapter.dart';
import 'package:mvvm_provider_todo/Repo/HiveModels/tag_adapter.dart';

part 'card_adapter.g.dart';

@HiveType(typeId: 1)
class NormalCardHiveModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;

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

  @HiveField(9)
  DateTime createdDate;

  NormalCardHiveModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.isPinned,
      this.priority,
      required this.isDone,
      required this.tags,
      this.groupID,
      required this.spaceID,
      required this.createdDate});
}
