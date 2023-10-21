import 'package:cadastrodecep/api/create_cep.dart';
import 'package:cadastrodecep/api/get_cep.dart';
import 'package:cadastrodecep/classes/cadastrar_novo_cep.dart';
import 'package:cadastrodecep/classes/lista_ceps_cadastrados.dart';
import 'package:cadastrodecep/tokens.dart';
import 'package:flutter/material.dart';
import 'package:cadastrodecep/tokens.dart';

class CepSearchPage extends StatefulWidget {
  const CepSearchPage({super.key});

  @override
  _CepSearchPageState createState() => _CepSearchPageState();
}

class _CepSearchPageState extends State<CepSearchPage> {
  final CepService cepService =
      CepService(appId: Constants.API_KEY, restApiKey: Constants.REST_API_KEY);
  String cep = '';
  Map<String, dynamic> cepData = {};

  void cadastrarNovoCEP() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CadastroCepPage(cepService: cepService),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta e Cadastro de CEP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Insira o CEP'),
              onChanged: (value) {
                setState(() {
                  cep = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: () async {
                // Realize o trabalho assíncrono fora do setState
                Map<String, dynamic> data = await consultarCEP(cep);

                // Atualize o estado dentro do setState
                setState(() {
                  cepData = data;
                });
              },
              child: const Text('Consultar CEP'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ListaCepsPage(cepService: cepService),
                  ),
                );
              },
              child: const Text('Ver Lista de CEPs Cadastrados'),
            ),
            const SizedBox(height: 20.0),
            if (cepData.isNotEmpty && !cepData.containsKey('erro'))
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CEP: ${cepData['cep']}'),
                  Text('Logradouro: ${cepData['logradouro']}'),
                  Text('Bairro: ${cepData['bairro']}'),
                  Text('Cidade: ${cepData['localidade']}'),
                  Text('Estado: ${cepData['uf']}'),
                ],
              )
            else if (cepData.containsKey('erro'))
              Column(
                children: [
                  const Text(
                      'CEP não encontrado. Deseja cadastrar um novo CEP?'),
                  ElevatedButton(
                    onPressed: cadastrarNovoCEP,
                    child: const Text('Cadastrar Novo CEP'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
