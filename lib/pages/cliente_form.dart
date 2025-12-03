import 'package:flutter/material.dart';
import 'package:pdmpainterapp/models/Cliente.dart';
import 'package:pdmpainterapp/database/db_helper.dart';

class ClienteFormPage extends StatefulWidget {
  final Cliente? cliente;
  const ClienteFormPage({super.key, this.cliente});

  @override
  State<ClienteFormPage> createState() => _ClienteFormPageState();
}

class _ClienteFormPageState extends State<ClienteFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _telCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final c = widget.cliente;
    if (c != null) {
      _nomeCtrl.text = c.nome;
      _emailCtrl.text = c.email;
      _telCtrl.text = c.telefone;
    }
  }

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _emailCtrl.dispose();
    _telCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final db = DBHelper();
    final cliente = Cliente(
      id: widget.cliente?.id,
      nome: _nomeCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      telefone: _telCtrl.text.trim(),
    );

    if (widget.cliente == null) {
      await db.insertCliente(cliente);
    } else {
      await db.updateCliente(cliente);
    }
    if (mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cliente == null ? 'Novo Cliente' : 'Editar Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeCtrl,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Nome obrigatório' : null,
              ),
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'E-mail obrigatório';
                  final emailRegex = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");
                  if (!emailRegex.hasMatch(v)) return 'E-mail inválido';
                  return null;
                },
              ),
              TextFormField(
                controller: _telCtrl,
                decoration: const InputDecoration(labelText: 'Telefone'),
                keyboardType: TextInputType.phone,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Telefone obrigatório' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _save, child: const Text('Salvar'))
            ],
          ),
        ),
      ),
    );
  }
}
