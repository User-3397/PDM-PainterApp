import 'package:flutter/material.dart';
import 'package:pdmpainterapp/models/Cliente.dart';
// import 'package:pdmpainterapp/database/db_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pdmpainterapp/repository/clients_repository.dart';
import 'cliente_form.dart';

class ClientesPage extends StatefulWidget {
  const ClientesPage({super.key});

  @override
  State<ClientesPage> createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
  //final DBHelper _db = DBHelper();
  //final _db = Supabase.instance.client;
  final _cliRepo = ClientsRepository();
  List<Cliente> _clientes = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadClientes();
  }

  Future<void> _loadClientes() async {
    setState(() => _loading = true);
    final list = await _cliRepo.findAll();

    setState(() {
      _clientes = list;
      _loading = false;
    });
  }

  Future<void> _addOrEdit([Cliente? c]) async {
    //final result = await Navigator.of(context).push(MaterialPageRoute<bool>(
    //  builder: (_) => ClienteFormPage(cliente: c),
    //));
    //if (result == true) await _loadClientes();
  }

  Future<void> _deleteCliente(int id) async {
    await _cliRepo.deleteClient(id);
    await _loadClientes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Clientes',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 208, 177),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff444444),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('lib/images/client-16.png'),
            ),
          )
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: _clientes.isEmpty
                  ? const Center(
                      child: Text('Nenhum cliente cadastrado',
                          style: TextStyle(color: Colors.white)))
                  : ListView.builder(
                      // _buildStreamList()
                      itemCount: _clientes.length,
                      itemBuilder: (_ /*context*/, i) {
                        final cli = _clientes[i];
                        return Card(
                          child: ListTile(
                            title: Text(cli.nome),
                            subtitle: Text('${cli.email} • ${cli.telefone}'),
                            trailing: PopupMenuButton<String>(
                              onSelected: (v) async {
                                if (v == 'edit') await _addOrEdit(cli);
                                if (v == 'del' && cli.id != null)
                                  await _deleteCliente(cli.id!);
                              },
                              itemBuilder: (_) => [
                                const PopupMenuItem(
                                    value: 'edit', child: Text('Editar')),
                                const PopupMenuItem(
                                    value: 'del', child: Text('Excluir')),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEdit(),
        child: const Icon(Icons.add),
      ),
      backgroundColor: const Color.fromRGBO(22, 22, 22, 1),
    );
  }

  // Sempre que houver insert, update ou delete na tabela, o stream emite novos dados
  StreamBuilder _buildStreamList(BuildContext ctx) {
    return StreamBuilder<List<Cliente>>(
      stream: _cliRepo.stream,
      builder: (ctx, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final clientes = snapshot.data!;
        return ListView.builder(
          itemCount: clientes.length,
          itemBuilder: (context, i) {
            final c = clientes[i];
            return ListTile(
              title: Text(c.nome),
              //subtitle: Text(c.telefone),
            );
          },
        );
      },
    );
  }
}
