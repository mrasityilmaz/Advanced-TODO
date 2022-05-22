// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class PriorityModel {
  String name;
  Color flagColor;

  PriorityModel({required this.name, required this.flagColor});
}

List<PriorityModel> priorityList = [
  PriorityModel(name: "Low", flagColor: Colors.grey),
  PriorityModel(name: "Normal", flagColor: Colors.green),
  PriorityModel(name: "High", flagColor: Colors.yellow),
  PriorityModel(name: "Urgent", flagColor: Colors.red),
];

enum PriorityEnum { Null, Low, Normal, High, Urgent }
