//package

class Tarefa {
  int? id;
  String titulo;
  String dia;
  int hora;
  int min;
  String servico;
  String cliente;
  String descricao;
  bool isDone; // Indica se a tarefa foi concluída

  Tarefa({
    this.id,
    this.titulo = '',
    String? dia,
    this.hora = 8,
    this.min = 0,
    required this.servico,
    required this.cliente,
    this.descricao = '',
    this.isDone = false,
  }) : dia = dia ?? DateTime.now().toIso8601String();

  Tarefa.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        titulo = map['titulo'] ?? '',
        dia = map['dia'] ?? DateTime.now().toIso8601String(),
        hora = map['hora'] ?? 8,
        min = map['min'] ?? 0,
        servico = map['servico'],
        cliente = map['cliente'],
        descricao = map['descricao'] ?? '',
        isDone = map['isDone'] == 1;

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'titulo': titulo,
      'dia': dia,
      'hora': hora,
      'min': min,
      'servico': servico,
      'cliente': cliente,
      'descricao': descricao,
      'isDone': isDone ? 1 : 0,
    };
    if (id != null) map['id'] = id;
    return map;
  }
}
