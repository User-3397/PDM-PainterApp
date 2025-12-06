//import 'dart:ffi'; // para usar a classe DateTime

import 'package:flutter/material.dart';
import 'package:pdmpainterapp/models/Tarefa.dart';
//import 'package:pdmpainterapp/database/db_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pdmpainterapp/service/task_service.dart';
import 'tarefa_form.dart';
import 'package:intl/intl.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  final service = TaskService();
  //List<Map<String, dynamic>> tarefas = [];
  List<Tarefa> tarefas = [];
  bool _loading = true;
  List<bool> expanded = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
    expanded = List.generate(tarefas.length, (_) => false);
  }

  Future<void> _loadTasks() async {
    // final response = await _taskRepo.from('Tarefas').select();
    setState(() => _loading = true);
    final list = await service.listarTodos();

    setState(() {
      tarefas = list;
      _loading = false;
    });
  }

  // Future<int> _addOrEdit(Tarefa t) {
  //   final res = service.atualizar(t);

  //   if (res == 1) _loadTasks();
  //   return res;
  // }

  // Future<void> _setDone(int id, bool done) async {
  //   await service.setDone(id, done);
  // }

  Future<void> _delete(int id) async {
    await service.deletar(id);
    await _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(22, 22, 22, 1),
      appBar: AppBar(
        title: const Text(
          'Tarefas',
          style: TextStyle(
            color: Color(0xffcbcbcb),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff444444),
      ),
      body: _loading
          ? /*Carrgando: */ const Center(child: CircularProgressIndicator())
          : tarefas.isEmpty
              ? /*Sem dados: */ const Center(
                  child: Text(
                  'Nenhuma tarefa',
                  style: TextStyle(color: Color(0xff666666)),
                ))
              : /*Com dados: */ _buildCardList(), //ListView.builder(
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

  SingleChildScrollView _buildListExpansionator() {
    return SingleChildScrollView(
        child: ExpansionPanelList(
      expansionCallback: (index, isExpanded) {
        setState(() => expanded[index] = !isExpanded);
      },
      children: tarefas.asMap().entries.map((entry) {
        final i = entry.key;
        final tarefa = entry.value;
        return ExpansionPanel(
          headerBuilder: (context, isExpanded) {
            return ListTile(title: Text(tarefa.servico));
          },
          body: Column(
            children: [
              ListTile(title: Text("Data entrega: ${tarefa.data}")),
              ListTile(title: Text("Notas: ${tarefa.notas}")),
              // ListTile(title: Text("Status: ${tarefa.isDone}")),
            ],
          ),
          isExpanded: expanded[i],
        );
      }).toList(),
    ));
  }

  ListView _buildCardList() {
    return ListView.builder(
      itemCount: tarefas.length,
      itemBuilder: (_, i) {
        final t = tarefas[i]; //Tarefa.fromMap(tarefas[i]);
        final formData = DateFormat('dd/MM HH:mm');
        return Card(
          child: ListTile(
            leading: Checkbox(
              value: t.isDone,
              onChanged: (v) async {
                setState(() {
                  t.isDone = !t.isDone;
                });

                print(v);
                await service.atualizar(
                    t.id!, 'done', t.isDone); //_addOrEdit(t);
                await _loadTasks();
              },
            ),
            title: Text(t.servico.isEmpty ? '[sem nome]' : t.servico),
            subtitle: Text('${t.cliente} • ${formData.format(t.data!)}'),
            /*trailing: PopupMenuButton<String>(
              onSelected: (v) async {
                if (v == 'edit') await _addOrEdit(t);
                if (v == 'del' && t.id != null) await _delete(t.id!);
              },
              itemBuilder: (_) => [
                const PopupMenuItem(
                    value: 'edit', child: Text('Editar')),
                const PopupMenuItem(
                    value: 'del', child: Text('Excluir')),
              ],
            ),*/
          ),
        );
      },
    );
  }
}
