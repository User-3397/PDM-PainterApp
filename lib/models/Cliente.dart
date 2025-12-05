class Cliente {
  int? id;
  String nome;
  String email;
  int telefone;

  Cliente({
    this.id,
    required this.nome,
    required this.email,
    required this.telefone,
  });

  Cliente.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        nome = map['nome'],
        email = map['email'],
        telefone = map['telefone'];

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'nome': nome,
      'email': email,
      'telefone': telefone,
    };
    if (id != null) map['id'] = id;
    return map;
  }
}

// Lista de exemplo (não usada pelo DB diretamente)
/*final List<Cliente> clientes = [
  Cliente(
      nome: 'Ana Silva',
      email: 'ana.silva@email.com',
      telefone: '11 98765-4321'),
  Cliente(
      nome: 'Bruno Costa',
      email: 'bruno.c@email.com',
      telefone: '21 91234-5678'),
  Cliente(
      nome: 'Carlos Dias',
      email: 'c.dias@email.com',
      telefone: '31 95555-4444'),
];*/
