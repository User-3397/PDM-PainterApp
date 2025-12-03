//import 'dart:ffi'; // para usar a classe DateTime

import 'package:flutter/material.dart';
import 'package:pdmpainterapp/models/Tarefa.dart';
import 'package:pdmpainterapp/database/db_helper.dart';
import 'tarefa_form.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  final DBHelper _db = DBHelper();
  List<Tarefa> tasks = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    setState(() => _loading = true);
    final list = await _db.getAllTarefas();
    setState(() {
      tasks = list;
      _loading = false;
      print("_loadTasks: Carregado.");
    });
  }

  Future<void> _addOrEdit([Tarefa? t]) async {
    final res = await Navigator.of(context).push(MaterialPageRoute<bool>(
      builder: (_) => TarefaFormPage(tarefa: t),
    ));
    if (res == true) await _loadTasks();
  }

  Future<void> _delete(int id) async {
    await _db.deleteTarefa(id);
    await _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tarefas'), centerTitle: true),
      body: _loading
          ? /*Carrgando: */ const Center(child: CircularProgressIndicator())
          : tasks.isEmpty
              ? /*Sem dados: */ const Center(child: Text('Nenhuma tarefa'))
              : /*Com dados: */ ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (_, i) {
                    final t = tasks[i];
                    return Card(
                      child: ListTile(
                        leading: Checkbox(
                          value: t.isDone,
                          onChanged: (v) async {
                            t.isDone = v ?? false;
                            await _db.updateTarefa(t);
                            await _loadTasks();
                          },
                        ),
                        title: Text(t.titulo.isEmpty ? t.servico : t.titulo),
                        subtitle: Text('${t.cliente} • ${t.descricao}'),
                        trailing: PopupMenuButton<String>(
                          onSelected: (v) async {
                            if (v == 'edit') await _addOrEdit(t);
                            if (v == 'del' && t.id != null)
                              await _delete(t.id!);
                          },
                          itemBuilder: (_) => [
                            const PopupMenuItem(
                                value: 'edit', child: Text('Editar')),
                            const PopupMenuItem(
                                value: 'del', child: Text('Excluir')),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEdit(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
