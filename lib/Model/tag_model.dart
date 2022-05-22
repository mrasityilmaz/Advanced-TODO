import 'package:flutter/material.dart';

class TagModel {
  String name;
  Color tagColor;
  bool? isSelected;

  TagModel({required this.name, required this.tagColor, this.isSelected});
}

List<TagModel> initialTags = [
  TagModel(name: "Business", tagColor: Colors.grey),
  TagModel(name: "Special", tagColor: Colors.indigo),
  TagModel(name: "School", tagColor: Colors.limeAccent),
];
