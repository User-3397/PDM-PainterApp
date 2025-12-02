import 'package:flutter/material.dart';
//import 'package:myapp/taskspage.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key}); // 'key' é uma chave única para o widget.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pagina principal',
          style: TextStyle(
            color: const Color.fromARGB(255, 218, 218, 218),
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
            const Text('Olá pintor'),

            // botao para lista de clientes cadastrados:
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/clients');
              },
              child: const Text('Clientes'),
            ),

            // Botao para lista de tarefas:
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/tasks');
              },
              child: const Text('Tarefas'),
            ),

            // Botao para lista de imagens salvas:
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/galery');
              },
              child: const Text('Galeria'),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(22, 22, 22, 1),
    );
  }
}
