import 'package:hive/hive.dart';

import '../model/todo_data.dart';

class ToDoHiveAdapter extends TypeAdapter<ToDo> {
  @override
  final typeId = 0;

  @override
  ToDo read(BinaryReader reader) {
    return ToDo(
      todoName: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, ToDo obj) {
    writer.writeString(obj.todoName);
  }
}
