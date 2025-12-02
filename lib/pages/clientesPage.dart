import 'package:flutter/material.dart';
//import 'package:myapp/models/cliente.dart';
import 'package:pdmpainterapp/models/cliente.dart';

class ClientesPage extends StatelessWidget {
  const ClientesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Clientes',
          style: TextStyle(
            color: const Color.fromARGB(255, 0, 208, 177),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(60, 60, 60, 1),
        //leading: const Icon(Icons.home), //
        actions: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/user-16.png'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Alinhamento vertical.
          children: <Widget>[
            const SizedBox(height: 20), // Espaço entre os widgets

            // botao para adicionar cliente:
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cliregister');
              },
              child: const Text('Adicionar'),
            ),

            // lista de clientes cadastrados:
            DataTable(
              columns: const [
                DataColumn(label: Text('Nome')),
                DataColumn(label: Text('Telefone')),
                DataColumn(label: Text('E-mail')),
              ],
              rows: clientes.map((cli) {
                return DataRow(cells: [
                  DataCell(Text(cli.nome)),
                  DataCell(Text(cli.telefone)),
                  DataCell(Text(cli.email)),
                ]);
              }).toList(),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(22, 22, 22, 1),
    );
  }
}
