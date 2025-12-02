import 'dart:async'; //para usar a classe Timer
import 'package:flutter/material.dart';
//import 'package:aula3_resolvido_splash/myhomepage.dart';
import 'myhomepage.dart';
//import 'package:pdmpainterapp/images/client-16.png' as fundo;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Imagem de fundo:
          Container(
            height: 400,
            width: 400,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 5),
              //shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: const AssetImage('lib/images/splashWaiting.gif'),
              ),
            ),
          ),
          Text(
            'Aguarde ...',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          LinearProgressIndicator(
            backgroundColor: const Color.fromARGB(255, 0, 255, 255),
            valueColor: AlwaysStoppedAnimation(
                Colors.blue[900]), // Define a cor da barra de progresso
          ),
        ],
      ),
    );
  }
}
