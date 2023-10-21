import 'package:http/http.dart' as http;
import 'dart:convert';

Future consultarCEP(String cep) async {
  final response =
      await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    print(data);
    return data;
  } else {
    return ({'erro': 'CEP não encontrado'});
  }
}
