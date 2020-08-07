import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:mobx/mobx.dart';

// comando deve ser executado no terminal (aqui mesmo) para gerar esse arquivo:
// flutter packages pub run build_runner build
part 'carros_model.g.dart';

class CarrosModel = CarrosModelBase with _$CarrosModel;

abstract class CarrosModelBase with Store {

  @observable
  List<Carro> carros;

  @observable
  Exception error;

  @action // deve ser colocada nos métodos que irão alterar o estado da nossa classe de modelo
  fetch(String tipo) async { // fetch = buscar ... poderia usar qualquer nome
    try { // controle de excessão
      error = null;
      carros = await CarrosApi.getCarros(tipo); // esse código de lógica não pode ficar dentro do build

    } catch (e) {
      error = e; // adiciona esse erro para cair no tratamento no StreamBuilder
    }
  }

}