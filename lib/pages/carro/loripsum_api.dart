import 'dart:async';

import 'package:carros/pages/carro/simple_bloc.dart';
import 'package:http/http.dart' as http;

//--------------------------------------

class LoripsumBloc extends SimpleBloc<String> {

  static String lorim; // cache pra evitar reler toda vez que entrar nos detalhes do carro

  void fetch() async {
    // fetch = buscar ... poderia usar qualquer nome
    try {
      // controle de excessão
      String text = lorim ?? await LoripsumApi.getLoripsum();

      // lógica para salvar em cache
      lorim = text;

      add(text);

    } catch (e) {
      addError(e);
    }
  }
}

//--------------------------------------

class LoripsumApi {
  static Future<String> getLoripsum() async {
    var url = "https://loripsum.net/api";

    print("GET > $url");

    var response = await http.get(url);

    String text = response.body;

    text = text.replaceAll("<p>", "");
    text = text.replaceAll("</p>", "");

    return text;
  }

}
