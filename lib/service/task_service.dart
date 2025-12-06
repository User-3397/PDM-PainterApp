import 'package:pdmpainterapp/repository/tasks_repository.dart';
import 'package:pdmpainterapp/models/Tarefa.dart';

class TaskService {
  final _taskRepo = TasksRepository();

  Future<List<Tarefa>> listarTodos() async {
    final response = await _taskRepo.findAll();
    //print(response);
    final lista = response.map((item) => Tarefa.fromMap(item)).toList();

    return lista;
  }

  Future porId(int id) {
    return _taskRepo.findById(id);
  }

  Future<int> atualizar(int id, String campo, dynamic valor) async {
    final map = await _taskRepo.findById(id);
    if (map != null) {
      _taskRepo.setFill(id, campo, valor);

      /*Map<String, dynamic> newMap = t.toMap();
      if (newMap['servico'] != map['servico'])
        _taskRepo.setServico(map['id'], newMap['servico']);
      if (newMap['data'] != map['data'])
        _taskRepo.setData(map['id'], newMap['data']);
      if (newMap['cliente'] != map['cliente'])
        _taskRepo.setCliente(map['id'], newMap['cliente']);
      if (newMap['notas'] != map['notas'])
        _taskRepo.setNotas(map['id'], newMap['notas']);
      if (newMap['isDone'] != map['isDone'])
        _taskRepo.setConcluido(map['id'], newMap['isDone']);*/
    }

    return 0;
  }

  Future<void> deletar(int id) async {
    await _taskRepo.delete(id);
  }
}
