import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ApiView(),
    ),
  );
}

class ApiView extends StatefulWidget {
  const ApiView({Key? key}) : super(key: key);

  @override
  State<ApiView> createState() => _ApiViewState();
}

class _ApiViewState extends State<ApiView> {
  final TextEditingController _cep_controller = TextEditingController();
  String _text_resultado = '';

  _buscarCep() async {
    Uri url = Uri.http('viacep.com.br', '/ws/${_cep_controller.text}/json');
    http.Response response;
    String resultado;
    try{
      response = await http.get(url);
      Map<String, dynamic> data = json.decode(response.body);
      resultado = 'Localidade: ${data["localidade"]} UF: ${data["uf"]}';
    }on Exception catch (_) {
      resultado = 'CEP inválido';
    }
    setState(() {
      _text_resultado = resultado;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teste API'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Digite o CEP para consultar...',
                border: OutlineInputBorder(),
              ),
              controller: _cep_controller,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ElevatedButton.icon(
                onPressed: () => {_buscarCep()},
                icon: const Icon(Icons.search),
                label: const Text('Buscar'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 8),
              child: Column(
                children: [
                  Text(_text_resultado),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
