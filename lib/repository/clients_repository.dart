//import 'dart:html';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pdmpainterapp/models/Cliente.dart';

class ClientsRepository {
  final database = Supabase.instance.client.from('Clientes');

  // C
  Future addClient(Cliente newClient) async {
    await database.insert(newClient.toMap());
  }

  // R
  final stream = Supabase.instance.client
      .from('Clientes')
      .stream(primaryKey: ['id']).map((data) =>
          data.map((clientMap) => Cliente.fromMap(clientMap)).toList());

  Future<List<Cliente>> findAll() async {
    final response = await database.select();
    final lista =
        response.map((clientMap) => Cliente.fromMap(clientMap)).toList();

    return lista;
  }

  // U
  Future updateClient(Cliente oldClient, Cliente newClient) async {
    //await database.update({'servico': newClient.servico}).eq('id', oldClient.id!);
    await database.update(newClient.toMap()).eq('id', oldClient.id!);
  }

  Future updateTelClient(Cliente client, int newPhone) async {
    await database.update({'telefone': newPhone}).eq('id', client.id!);
  }

  // D
  Future deleteClient(int id) async {
    await database.delete().eq('id', id);
  }
}
