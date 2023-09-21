import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:providertodo/model/feitos_repository.dart';
import 'package:providertodo/pages/dialog_box.dart';
import '../model/todo_data.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ToDo> itemsToDo = [];
  List<bool> isCheckedList = [];
  final _controllerName = TextEditingController();
  final _controllerSearch = TextEditingController();
  late FeitosRepository feitos;
  bool isSearchVisible = false;
  final String hiveBoxName = 'todos';

  void salvarNovaTarefa() async {
    final novoNomeTarefa = _controllerName.text;
    if (novoNomeTarefa.isNotEmpty) {
      final novoToDo = ToDo(todoName: novoNomeTarefa);
      setState(() {
        itemsToDo.add(novoToDo);
      });
      final box = await Hive.openBox<ToDo>(hiveBoxName);
      await box.add(novoToDo); // Adicione o novoToDo à caixa Hive
      _controllerName.clear();
      Navigator.of(context).pop();
    }
  }

  void criarNovaTarefa() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controllerName,
          onSave: salvarNovaTarefa,
          onCancel: () => Navigator.pop(context),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    isCheckedList = List.generate(itemsToDo.length, (index) => false);
    openHiveBox();
  }

  Future<void> openHiveBox() async {
    final box = await Hive.openBox<ToDo>(hiveBoxName);
    itemsToDo = box.values.toList();
  }

  List<ToDo> getFilteredItems() {
    final searchQuery = _controllerSearch.text.toLowerCase();
    return itemsToDo.where((todo) {
      final todoName = todo.todoName.toLowerCase();
      return todoName.contains(searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    feitos = context.watch<FeitosRepository>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearchVisible = !isSearchVisible;
                if (!isSearchVisible) {
                  _controllerSearch.clear();
                }
              });
            },
            icon: Icon(isSearchVisible ? Icons.close : Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          if (isSearchVisible)
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: _controllerSearch,
                decoration: InputDecoration(
                  hintText: 'Pesquisar por nome...',
                ),
                onChanged: (query) {
                  setState(() {});
                },
              ),
            ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                final filteredItems = getFilteredItems();
                final todo = filteredItems[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: IconButton(
                        onPressed: () {
                          setState(() {
                            todo.isChecked = !todo.isChecked;
                          });
                          feitos.saveAll(filteredItems);
                        },
                        icon: Icon(
                          todo.isChecked
                              ? Icons.check_box_sharp
                              : Icons.check_box_outline_blank_sharp,
                        ),
                        iconSize: 30,
                      ),
                      title: Text(
                        todo.todoName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            decoration: todo.isChecked
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(
                    height: 5,
                    color: Colors.grey,
                    thickness: 1,
                  ),
                );
              },
              itemCount: getFilteredItems().length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: criarNovaTarefa,
        label: const Text('Nova Tarefa'),
      ),
    );
  }
}
