import 'package:flutter/material.dart';
//import '../models/cliente.dart';

class CadastroClientePage extends StatefulWidget {
  const CadastroClientePage({super.key});
  @override
  _CadastroClientePageState createState() => _CadastroClientePageState();
}

class _CadastroClientePageState extends State<CadastroClientePage> {
  final _formKey = GlobalKey<FormState>();
  String nome = '';
  String email = '';
  String telefone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Cliente')),
      body: Padding(
        padding:
            const EdgeInsets.all(16), // padding interno para os campos de texto
        child: Form(
          key: _formKey, // para validar o formulário
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome'),
                onSaved: (value) => nome = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onSaved: (value) => email = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Telefone'),
                onSaved: (value) => telefone = value ?? '',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Salvar'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
