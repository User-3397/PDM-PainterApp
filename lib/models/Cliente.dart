
class Cliente {
  final String nome;
  final String email;
  final String telefone;

  Cliente({
    required this.nome, 
    required this.email, 
    required this.telefone}
  );
}

final List<Cliente> clientes =[
  Cliente(nome: 'Ana Silva', email: 'ana.silva@email.com', telefone: '11 98765-4321'),
  Cliente(nome: 'Bruno Costa', email: 'bruno.c@email.com', telefone: '21 91234-5678'),
  Cliente(nome: 'Carlos Dias', email: 'c.dias@email.com', telefone: '31 95555-4444'),
];