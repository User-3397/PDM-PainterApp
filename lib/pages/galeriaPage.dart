import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// A tela de recolorir foto já existe no projeto, vamos importá-la.
import '../lib2/screens/photo_recolor.dart';

class GaleriaPage extends StatefulWidget {
  const GaleriaPage({super.key});

  @override
  _GaleriaPageState createState() => _GaleriaPageState();
}

class _GaleriaPageState extends State<GaleriaPage> {
  File? _imagemSelecionada;

  Future<void> _abrirGaleria() async {
    final picker = ImagePicker();
    final imagem = await picker.pickImage(source: ImageSource.gallery);

    if (imagem != null) {
      setState(() {
        _imagemSelecionada = File(imagem.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Galeria de Fotos')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Se tiver imagem selecionada, aparece botao de edição com ia, para recolorir
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirGaleria,
        tooltip: 'Selecionar Imagem',
        child: const Icon(Icons.photo_library),
      ),
    );
  }
}
