import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pdmpainterapp/models/Cliente.dart';
import 'package:pdmpainterapp/models/Tarefa.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'pdmpainter.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE clientes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT NOT NULL,
          email TEXT NOT NULL,
          telefone TEXT NOT NULL
        )
      ''');

      await db.execute('''
        CREATE TABLE tarefas (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          titulo TEXT,
          dia TEXT,
          hora INTEGER,
          min INTEGER,
          servico TEXT NOT NULL,
          cliente TEXT NOT NULL,
          descricao TEXT,
          isDone INTEGER
        )
      ''');
    });
  }

  // CLIENTES --------------------------------------------
  // C
  Future<int> insertCliente(Cliente c) async {
    final database = await db;
    return await database.insert('clientes', c.toMap());
  }

  // U
  Future<int> updateCliente(Cliente c) async {
    final database = await db;
    return await database
        .update('clientes', c.toMap(), where: 'id = ?', whereArgs: [c.id]);
  }

  // D
  Future<int> deleteCliente(int id) async {
    final database = await db;
    return await database.delete('clientes', where: 'id = ?', whereArgs: [id]);
  }

  // R
  Future<List<Cliente>> getAllClientes() async {
    final database = await db;
    final maps = await database.query('clientes', orderBy: 'nome');
    return maps.map((m) => Cliente.fromMap(m)).toList();
  }

  // TAREFAS -----------------------------------------
  // C
  Future<int> insertTarefa(Tarefa t) async {
    final database = await db;
    return await database.insert('tarefas', t.toMap());
  }

  // R
  Future<List<Tarefa>> getAllTarefas() async {
    final database = await db;
    final maps = await database.query('tarefas', orderBy: 'dia DESC');
    return maps.map((m) => Tarefa.fromMap(m)).toList();
  }

  // U
  Future<int> updateTarefa(Tarefa t) async {
    final database = await db;
    return await database
        .update('tarefas', t.toMap(), where: 'id = ?', whereArgs: [t.id]);
  }

  // D
  Future<int> deleteTarefa(int id) async {
    final database = await db;
    return await database.delete('tarefas', where: 'id = ?', whereArgs: [id]);
  }
}
