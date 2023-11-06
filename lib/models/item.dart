import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 1)
class Item {
  Item({required this.age, required this.name});
  @HiveField(0)
  String? name;

  @HiveField(1)
  int? age;
}
