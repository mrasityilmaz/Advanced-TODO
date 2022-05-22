import 'package:hive/hive.dart';
part 'priority_adapter.g.dart';

@HiveType(typeId: 7)
enum PriorityEnum {
  @HiveField(0)
  Low,
  @HiveField(1)
  Normal,
  @HiveField(2)
  High,
  @HiveField(3)
  Urgent,
}
