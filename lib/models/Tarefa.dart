//package

class Tarefa {
  late String titulo;
  late String dia = DateTime.now().toString();
  late int hora = 8;
  late int min = 0;

  late String servico;
  late String cliente;
  late String descricao;

  bool isDone = false; // Indica se a tarefa foi concluída

  Tarefa({
    this.dia = '',
    //required this.hora,
    required this.servico,
    required this.cliente,
    this.descricao = '',
  }); // Construtor da classe
}
