import 'dart:html';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pdmpainterapp/models/Tarefa.dart';

class TasksRepository {
  final database = Supabase.instance.client.from('Tarefas');

  // C
  Future addTask(Tarefa newTask) async {
    await database.insert(newTask.toMap());
  }

  // R
  final stream = Supabase.instance.client.from('Tarefas').stream(primaryKey: [
    'id'
  ]).map((data) => data.map((taskMap) => Tarefa.fromMap(taskMap)).toList());

  // U
  Future updateTask(Tarefa oldTask, Tarefa newTask) async {
    await database.update({'servico': newTask.servico}).eq('id', oldTask.id!);
  }

  // D
  Future deleteTask(Tarefa t) async {
    await database.delete().eq('id', t.id!);
  }
}
