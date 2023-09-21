import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providertodo/model/feitos_repository.dart';

import '../model/todo_data.dart';

class FeitosCard extends StatefulWidget {
  ToDo feito;

  FeitosCard({Key? key, required this.feito}) : super(key: key);

  @override
  _FeitosCardState createState() => _FeitosCardState();
}

class _FeitosCardState extends State<FeitosCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[200],
      margin: const EdgeInsets.only(top: 12),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 20),
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.feito.todoName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            PopupMenuButton(
              icon: const Icon(Icons.more_vert, color: Colors.red),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: ListTile(
                    title: Text('Remover das Favoritas'),
                    onTap: () {
                      Navigator.pop(context);
                      Provider.of<FeitosRepository>(context, listen: false)
                          .remove(widget.feito);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
