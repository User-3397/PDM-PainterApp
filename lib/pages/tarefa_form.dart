import 'package:flutter/material.dart';
import 'package:pdmpainterapp/models/Tarefa.dart';
import 'package:pdmpainterapp/database/db_helper.dart';

class TarefaFormPage extends StatefulWidget {
  final Tarefa? tarefa;
  const TarefaFormPage({super.key, this.tarefa});

  @override
  State<TarefaFormPage> createState() => _TarefaFormPageState();
}

class _TarefaFormPageState extends State<TarefaFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _tituloCtrl = TextEditingController();
  final _servicoCtrl = TextEditingController();
  final _clienteCtrl = TextEditingController();
  final _descricaoCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final t = widget.tarefa;
    if (t != null) {
      _tituloCtrl.text = t.titulo;
      _servicoCtrl.text = t.servico;
      _clienteCtrl.text = t.cliente;
      _descricaoCtrl.text = t.descricao;
    }
  }

  @override
  void dispose() {
    _tituloCtrl.dispose();
    _servicoCtrl.dispose();
    _clienteCtrl.dispose();
    _descricaoCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final db = DBHelper();
    final tarefa = Tarefa(
      id: widget.tarefa?.id,
      titulo: _tituloCtrl.text.trim(),
      servico: _servicoCtrl.text.trim(),
      cliente: _clienteCtrl.text.trim(),
      descricao: _descricaoCtrl.text.trim(),
    );

    if (widget.tarefa == null) {
      await db.insertTarefa(tarefa);
    } else {
      await db.updateTarefa(tarefa);
    }
    if (mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.tarefa == null ? 'Nova Tarefa' : 'Editar Tarefa')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _tituloCtrl,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Título obrigatório' : null,
              ),
              TextFormField(
                controller: _servicoCtrl,
                decoration: const InputDecoration(labelText: 'Serviço'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Serviço obrigatório' : null,
              ),
              TextFormField(
                controller: _clienteCtrl,
                decoration: const InputDecoration(labelText: 'Cliente'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Cliente obrigatório' : null,
              ),
              TextFormField(
                controller: _descricaoCtrl,
                decoration: const InputDecoration(labelText: 'Descrição'),
                maxLines: 3,
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
