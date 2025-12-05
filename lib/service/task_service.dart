import 'package:pdmpainterapp/repository/tasks_repository.dart';
import 'package:pdmpainterapp/models/Tarefa.dart';

class TaskService {
  final _taskRepo = TasksRepository();

  Future listarTodos() {
    return _taskRepo.findAll();
  }

  Future porId(int id) {
    return _taskRepo.findById(id);
  }

  Future<int> atualizar(Tarefa t) async {
    final map = await _taskRepo.findById(t.id!);
    if (map != null) {
      Map<String, dynamic> newMap = t.toMap();
      if (newMap['servico'] != map['servico'])
        _taskRepo.setServico(map['id'], newMap['servico']);
      if (newMap['data'] != map['data'])
        _taskRepo.setData(map['id'], newMap['data']);
      if (newMap['cliente'] != map['cliente'])
        _taskRepo.setCliente(map['id'], newMap['cliente']);
      if (newMap['notas'] != map['notas'])
        _taskRepo.setNotas(map['id'], newMap['notas']);
      if (newMap['isDone'] != map['isDone'])
        _taskRepo.setConcluido(map['id'], newMap['isDone']);
    }

    return 0;
  }

  Future<void> deletar(int id) async {
    await _taskRepo.delete(id);
  }
}
