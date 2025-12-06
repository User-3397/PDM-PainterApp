//package

class Tarefa {
  int? id;
  String servico;
  DateTime? data;
  int cliente;
  String notas;
  bool isDone; // Indica se a tarefa foi concluída

  Tarefa({
    this.id,
    required this.servico,
    required this.data,
    required this.cliente,
    this.notas = '',
    this.isDone = false,
  }); // : data = data ?? DateTime.now().toIso8601String();

  /*Tarefa.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        titulo = map['titulo'] ?? '',
        dia = map['dia'] ?? DateTime.now().toIso8601String(),
        hora = map['hora'] ?? 8,
        min = map['min'] ?? 0,
        servico = map['servico'],
        cliente = map['cliente'],
        descricao = map['descricao'] ?? '',
        isDone = map['isDone'] == 1;
  */
  // Back to Front:
  factory Tarefa.fromMap(Map<String, dynamic> map) {
    return Tarefa(
        id: map['id'] as int,
        servico: map['servico'] as String,
        data: map['data'] != null ? DateTime.parse(map['data']) : null,
        cliente: map['id_cliente'] as int,
        notas: map['notas'] as String,
        isDone: map['done'] as bool);
  }

  // Front to Back:
  /*Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'dia': data,
      'servico': servico,
      'cliente': cliente,
      'notas': notas,
      'isDone': isDone ? 1 : 0,
    };
    if (id != null) map['id'] = id;
    return map;
  }*/
  Map<String, dynamic> toMap() {
    return {
      'servico': servico,
      'data': data!.toIso8601String(), // modificado para '!.toIso8601String()'
      'id_cliente': cliente,
      'notas': notas,
      'done': isDone
    };
  }
}
