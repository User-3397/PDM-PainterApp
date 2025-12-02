import 'package:flutter/material.dart';
import 'package:pdmpainterapp/pages/splashscreen.dart';
import 'package:pdmpainterapp/pages/myhomepage.dart';

void main() => runApp(MyApp());

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
        //ConfirmaCadastro.nomeRota: (context) => ConfirmaCadastro(),
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
