import 'dart:convert' as convert;
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:http/http.dart' as http;

// fazendo com classe pois Enum no Dart não funciona muito bem pra esse exemplo
class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

// retorna a lista de carros do web service
class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {

    // obetendo o token do usuário
    Usuario user = await Usuario.get();

    //headers COM token para acesso
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token}"
    };

    var url = 'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo';
    
    print("GET > $url");

    var response = await http.get(url, headers: headers);

    // precisa ser List pois vai receber uma lista e não um Map
    String json = response.body;
    List list = convert.json.decode(json);

    // forma recomendada (padrão no flutter)
    final carros = list.map<Carro>((e) => Carro.fromJson(e)).toList();

    // forma rudimentar
/*    final carros = List<Carro>();
    for(Map map in list) {
      Carro c = Carro.fromJson(map);
      carros.add(c);
    }*/

    return carros;
  }
}
