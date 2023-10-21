import 'dart:convert';
import 'package:http/http.dart' as http;

class CepService {
  final String appId;
  final String restApiKey;

  CepService({required this.appId, required this.restApiKey});

  Future<bool> cadastrarNovoCEP({
    required String novoCep,
    required String novoLogradouro,
    required String novoBairro,
    required String novaCidade,
    required String novoEstado,
  }) async {
    final novoCepData = {
      'cep': novoCep,
      'logradouro': novoLogradouro,
      'bairro': novoBairro,
      'cidade': novaCidade,
      'estado': novoEstado,
    };

    final response = await http.post(
      Uri.parse('https://parseapi.back4app.com/classes/CEP'),
      headers: {
        'X-Parse-Application-Id': appId,
        'X-Parse-REST-API-Key': restApiKey,
        'Content-Type': 'application/json',
      },
      body: jsonEncode(novoCepData),
    );
    return response.statusCode == 200;
  }
}
