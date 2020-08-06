import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/pages/carro/simple_bloc.dart';

class CarrosBloc extends SimpleBloc<List<Carro>> { // alteração na aula 133

  void fetch(String tipo) async { // fetch = buscar ... poderia usar qualquer nome
    try { // controle de excessão
      List<Carro> carros = await CarrosApi.getCarros(tipo); // esse código de lógica não pode ficar dentro do build
      add(carros);

    } catch (e) {
      addError(e); // adiciona esse erro para cair no tratamento no StreamBuilder
    }
  }

}