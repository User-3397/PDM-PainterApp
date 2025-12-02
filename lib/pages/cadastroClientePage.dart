import 'package:flutter/material.dart';
import '../models/cliente.dart';

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
      appBar: AppBar(title: Text('Cadastro de Cliente')),
      body: Padding(
        padding: EdgeInsets.all(16), // padding interno para os campos de texto
        child: Form(
          key: _formKey, // para validar o formulário
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                onSaved: (value) => nome = value ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) => email = value ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Telefone'),
                onSaved: (value) => telefone = value ?? '',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Salvar'),
                onPressed: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
