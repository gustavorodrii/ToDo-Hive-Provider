import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class ToDo {
  @HiveField(0)
  final String todoName;
  @HiveField(1)
  bool isChecked;

  ToDo({required this.todoName, this.isChecked = false});
}
