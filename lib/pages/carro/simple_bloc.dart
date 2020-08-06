
import 'dart:async';

class SimpleBloc<T> {
  // Projeto alterado na aula 133 e que deverá ser mantida na sequência, ainda
  // que as aulas seguintes não estejam atualizadas

  final _controller = StreamController<T>();

  //--------------------------------------

  Stream<T> get stream => _controller.stream; // get para o recurso

  //--------------------------------------

  void add(T object) {
    _controller.add(object);
  }

  //--------------------------------------

  void addError(T error) {
    if(! _controller.isClosed) { // teste para evitar problemas
      _controller.addError(error);
    }
  }

  //--------------------------------------

  void dispose() {
    _controller.close(); // necessário fechar o recurso
  }
}

// uma maneira de simplificar para casos rotineiros
class BooleanBloc extends SimpleBloc<bool> {

}