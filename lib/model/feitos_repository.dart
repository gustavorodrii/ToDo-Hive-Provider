import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:providertodo/model/todo_data.dart';

import '../adapters/todo_hive_adapter.dart';

class FeitosRepository extends ChangeNotifier {
  List<ToDo> _feitos = [];

  late LazyBox box;

  FeitosRepository() {
    _startRepository();
  }

  _startRepository() async {
    await _openBox();
    await _readFavoritas();
  }

  _openBox() async {
    Hive.registerAdapter(ToDoHiveAdapter());
    box = await Hive.openLazyBox<ToDo>('tarefas_feitas');
  }

  _readFavoritas() {
    box.keys.forEach((feito) async {
      ToDo t = await box.get(feito);
      _feitos.add(t);
      notifyListeners();
    });
  }

  UnmodifiableListView<ToDo> get lista => UnmodifiableListView(_feitos);

  saveAll(List<ToDo> feitos) {
    feitos.forEach((feito) {
      if (!_feitos.any((atual) => atual.todoName == feito.todoName)) {
        _feitos.add(feito);
        box.put(feito.todoName, feito);
      }
    });
    notifyListeners();
  }

  remove(ToDo feito) {
    _feitos.remove(feito);
    box.delete(feito.todoName);
    notifyListeners();
  }
}
