import 'dart:ui';

import 'package:hive/hive.dart';

part 'group_adapter.g.dart';

@HiveType(typeId: 4)
class GroupCardHiveModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  List<Object> childrens;

  @HiveField(3)
  bool isPinned;

  @HiveField(4)
  int color;

  @HiveField(5)
  int completedCount;

  @HiveField(6)
  int allCount;

  @HiveField(7)
  String spaceID;

  GroupCardHiveModel({
    required this.id,
    required this.title,
    required this.childrens,
    required this.isPinned,
    required this.color,
    required this.completedCount,
    required this.allCount,
    required this.spaceID,
  });
}
