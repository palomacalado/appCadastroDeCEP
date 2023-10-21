import 'package:cadastrodecep/api/create_cep.dart';
import 'package:flutter/material.dart';

class CadastroCepPage extends StatefulWidget {
  final CepService cepService;

  const CadastroCepPage({super.key, required this.cepService});

  @override
  _CadastroCepPageState createState() => _CadastroCepPageState();
}

class _CadastroCepPageState extends State<CadastroCepPage> {
  final TextEditingController cepController = TextEditingController();
  final TextEditingController logradouroController = TextEditingController();
  final TextEditingController bairroController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();

  Future<void> cadastrarCEP() async {
    final novoCep = cepController.text;
    final novoLogradouro = logradouroController.text;
    final novoBairro = bairroController.text;
    final novaCidade = cidadeController.text;
    final novoEstado = estadoController.text;

    final cadastradoComSucesso = await widget.cepService.cadastrarNovoCEP(
      novoCep: novoCep,
      novoLogradouro: novoLogradouro,
      novoBairro: novoBairro,
      novaCidade: novaCidade,
      novoEstado: novoEstado,
    );

    if (cadastradoComSucesso) {
      Navigator.of(context).pop(); // Fecha a tela de cadastro
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Erro ao cadastrar o CEP. Verifique os dados e tente novamente.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de CEP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: cepController,
              decoration: const InputDecoration(labelText: 'CEP'),
            ),
            TextField(
              controller: logradouroController,
              decoration: const InputDecoration(labelText: 'Logradouro'),
            ),
            TextField(
              controller: bairroController,
              decoration: const InputDecoration(labelText: 'Bairro'),
            ),
            TextField(
              controller: cidadeController,
              decoration: const InputDecoration(labelText: 'Cidade'),
            ),
            TextField(
              controller: estadoController,
              decoration: const InputDecoration(labelText: 'Estado'),
            ),
            ElevatedButton(
              onPressed: cadastrarCEP,
              child: const Text('Cadastrar CEP'),
            ),
          ],
        ),
      ),
    );
  }
}
