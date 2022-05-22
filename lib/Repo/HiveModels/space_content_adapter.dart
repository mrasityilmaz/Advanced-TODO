import 'package:hive/hive.dart';

part 'space_content_adapter.g.dart';

@HiveType(typeId: 6)
class SpaceContentHiveModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  List<Object> childrens;

  SpaceContentHiveModel(
      {required this.id, required this.title, required this.childrens});
}
