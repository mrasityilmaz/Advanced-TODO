import 'package:flutter/material.dart';

class TaskModel {
  Icon icon;
  String task;
  bool isDone;

  TaskModel(
      {this.icon = const Icon(
        Icons.circle,
        color: Colors.white,
        size: 15,
      ),
      required this.task,
      this.isDone = false});
}
