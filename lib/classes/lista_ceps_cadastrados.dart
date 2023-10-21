import 'package:cadastrodecep/api/create_cep.dart';
import 'package:flutter/material.dart';

class ListaCepsPage extends StatefulWidget {
  final CepService cepService;

  const ListaCepsPage({super.key, required this.cepService});

  @override
  _ListaCepsPageState createState() => _ListaCepsPageState();
}

class _ListaCepsPageState extends State<ListaCepsPage> {
  List<Map<String, dynamic>> ceps = [];

  Future<void> listarCepsCadastrados() async {
    // Faça uma solicitação ao Back4App para obter a lista de CEPs cadastrados.
    // Atualize a lista "ceps" com os dados retornados.
  }

  @override
  void initState() {
    listarCepsCadastrados();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de CEPs Cadastrados'),
      ),
      body: ListView.builder(
        itemCount: ceps.length,
        itemBuilder: (context, index) {
          final cepData = ceps[index];
          return ListTile(
            title: Text('CEP: ${cepData['cep']}'),
            subtitle: Text('Logradouro: ${cepData['logradouro']}'),
            // Adicione mais informações do CEP, se necessário.
          );
        },
      ),
    );
  }
}
