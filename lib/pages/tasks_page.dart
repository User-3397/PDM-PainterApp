//import 'dart:ffi'; // para usar a classe DateTime

import 'package:flutter/material.dart';
import 'package:pdmpainterapp/models/Tarefa.dart';
//import 'package:pdmpainterapp/database/db_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pdmpainterapp/service/task_service.dart';
import 'tarefa_form.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  final service = TaskService();
  List<Map<String, dynamic>> tarefas = [];

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    // final response = await _taskRepo.from('Tarefas').select();
    setState(() => _loading = true);
    final list = await service.listarTodos();

    setState(() => tarefas = list);
  }

  Future<int> _addOrEdit(Tarefa t) {
    final res = service.atualizar(t);
    ;
    if (res == 1) _loadTasks();
    return res;
  }

  Future<void> _delete(int id) async {
    await service.deletar(id);
    await _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tarefas'), centerTitle: true),
      body: _loading
          ? /*Carrgando: */ const Center(child: CircularProgressIndicator())
          : tarefas.isEmpty
              ? /*Sem dados: */ const Center(child: Text('Nenhuma tarefa'))
              : /*Com dados: */ ListView.builder(
                  itemCount: tarefas.length,
                  itemBuilder: (_, i) {
                    final t = Tarefa.fromMap(tarefas[i]);
                    return Card(
                      child: ListTile(
                        leading: Checkbox(
                          value: t.isDone,
                          onChanged: (v) async {
                            t.isDone = v ?? false;
                            await _addOrEdit(t);
                            await _loadTasks();
                          },
                        ),
                        title: Text(t.servico.isEmpty ? t.servico : t.servico),
                        subtitle: Text('${t.cliente} • ${t.notas}'),
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
        onPressed: () => _buildDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _buildDialog(ctx) {
    showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Título do Alerta'),
          content: const Text('Conteúdo da mensagem.'),
          actions: [
            TextButton(
              child: const Text('Adicionar'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
            TextButton(
                child: const Text('Cancelar'),
                onPressed: () => Navigator.of(ctx).pop()),
          ],
        );
      },
    );
  }
}
