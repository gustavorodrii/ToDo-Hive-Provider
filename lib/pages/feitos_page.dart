import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providertodo/model/feitos_repository.dart';
import 'package:providertodo/widget/feitos_card.dart';

class FeitosPage extends StatefulWidget {
  const FeitosPage({super.key});

  @override
  State<FeitosPage> createState() => _FeitosPageState();
}

class _FeitosPageState extends State<FeitosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feitos'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(12),
        child: Consumer<FeitosRepository>(
          builder: (context, feitos, child) {
            return feitos.lista.isEmpty
                ? const ListTile(
                    title: Center(
                      child: Text(
                        'Ainda não há tarefas concluídas',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: feitos.lista.length,
                    itemBuilder: (_, index) {
                      return FeitosCard(feito: feitos.lista[index]);
                    },
                  );
          },
        ),
      ),
    );
  }
}
