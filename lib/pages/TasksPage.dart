//import 'dart:ffi'; // para usar a classe DateTime

import 'package:flutter/material.dart';
import 'package:pdmpainterapp/models/Tarefa.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  /*final*/
  List<Tarefa> tasks = [
    Tarefa(servico: 'Pintura', cliente: 'João'),
    Tarefa(
      servico: 'Lavagem',
      cliente: 'Maria',
      descricao: 'Lavagem só das janelas',
    ),
    Tarefa(servico: 'Pintura', cliente: 'Pedro'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: _buildAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Alinhamento vertical.
          children: <Widget>[
            // Lista de tarefas
            // Botao para adicionar uma tarefa:
            ElevatedButton(
              onPressed: () {},
              child: const Text('+'),
            ),
          ],
        ),
      ),
    );
  }
}

// Construir uma appbar:
AppBar _buildAppBar() {
  return AppBar(
    title: const Text('Tarefas'),
    backgroundColor: Colors.blueGrey,
    centerTitle: true,
  );
}
