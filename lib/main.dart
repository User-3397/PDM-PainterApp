import 'dart:html';

import 'package:flutter/material.dart';
import 'package:pdmpainterapp/pages/splashscreen.dart';
import 'package:pdmpainterapp/pages/myhomepage.dart';
import 'package:pdmpainterapp/pages/clientes_page.dart';
import 'package:pdmpainterapp/pages/tasks_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
      url: 'https://hjneuhcnpkafxticzbjr.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhqbmV1aGNucGthZnh0aWN6YmpyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ3ODQxMjQsImV4cCI6MjA4MDM2MDEyNH0.Jx3ifjdXZ6ByBLqC0kAgcmXxtREj2P2Y0bHDvZUFX50');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Application name
      title: 'Painter App',
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
        // useMaterial3: false,
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff585858),
          foregroundColor: Colors.white,
          elevation: 4,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black,
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      initialRoute: '/api/splash',
      // A widget which will be started on application startup
      routes: {
        '/api/splash': (context) => const SplashScreen(),
        '/api/home': (context) => const MyHomePage(),
        '/api/clientes': (context) => const ClientesPage(),
        '/api/tarefas': (context) => const TarefasPage(),
        //DetalhesAniversario.nomeRota: (context) => DetalhesAniversario(),
        //ListarAniversarios.nomeRota: (context) => ListarAniversarios(),
      },
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

/*class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The title text which will be shown on the action bar
        title: Text(title),
      ),
      body: Center(
        child: Text(
          'Hello, World!',
        ),
      ),
    );
  }
}*/
