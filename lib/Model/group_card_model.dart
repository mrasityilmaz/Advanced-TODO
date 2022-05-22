import 'dart:ui';

class GroupCardModel {
  String id;
  String title;
  List<Object> childrens;

  bool isPinned;

  Color color;

  int completedCount;

  int allCount;

  String spaceID;

  GroupCardModel({
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
