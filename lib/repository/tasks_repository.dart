//import 'dart:html';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pdmpainterapp/models/Tarefa.dart';

class TasksRepository {
  final database = Supabase.instance.client.from('Tarefas');

  // C
  Future addTask(Tarefa newTask) async {
    await database.insert(newTask.toMap());
  }

  // R
  //final stream = Supabase.instance.client.from('Tarefas').stream(primaryKey: ['id']).map((data) => data.map((taskMap) => Tarefa.fromMap(taskMap)).toList());
  Future<List<Map<String, dynamic>>> findAll() async {
    return await database.select();
  }

  Future<Map<String, dynamic>?> findById(int id) async {
    final response = await database.select().eq('id', id);
    if (response.isEmpty) return null;
    return response.first;
  }

  // U
  void setFill(int id, String fill, dynamic value) async {
    await database.update({fill: value});
  }

  void setServico(int id, String valor) async {
    await database.update({'servico': valor}).eq('id', id);
  }

  Future setData(int id, String valor) async {
    await database.update({'data': valor}).eq('id', id);
  }

  Future setCliente(int id, int valor) async {
    await database.update({'cliente': valor}).eq('id', id);
  }

  Future setNotas(int id, String valor) async {
    await database.update({'notas': valor}).eq('id', id);
  }

  Future setConcluido(int id, bool valor) async {
    await database.update({'isDone': valor}).eq('id', id);
  }

  // D
  Future delete(int id) async {
    await database.delete().eq('id', id);
  }
}
