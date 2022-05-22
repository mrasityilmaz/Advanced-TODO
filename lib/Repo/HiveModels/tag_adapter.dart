import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'tag_adapter.g.dart';

@HiveType(typeId: 0)
class TagHiveModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  int tagColor;

  TagHiveModel({
    required this.id,
    required this.name,
    required this.tagColor,
  });
}
