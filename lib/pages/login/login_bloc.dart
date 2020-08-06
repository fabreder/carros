import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/carro/simple_bloc.dart';
import 'package:carros/pages/login/login_api.dart';
import 'package:carros/pages/login/usuario.dart';

class LoginBloc {
  // Usando composição ao invés de herança
  // Para o caso de haver mais de uma stream no bloc
  // ver no comentário abaixo como ficaria usando herança
  // lembrando que mudaria na chamada da stream em login_page
  final buttonBloc = BooleanBloc(); // veja no arquivo simple_bloc (apenas uma forma mais simples de fazer)

  //--------------------------------------

  Future<ApiResponse<Usuario>> login(String login, String senha) async {
    // alterar o status do login
    buttonBloc.add(true); // inicia animação no botão login
    ApiResponse response = await LoginApi.login(login, senha);
    buttonBloc.add(false); // encerra animação

    return response;
  }

  //--------------------------------------

  void dispose() {
    // fechando o streamController (sempre é necessário)
    buttonBloc.dispose();
  }
}

/* poderia fazer assim, como foi feito em carros_bloc, mas se houver mais de
uma stream, seria necessário fazer como foi feito acima.

* class LoginBloc extends SimpleBloc<bool> {

  Future<ApiResponse<Usuario>> login(String login, String senha) async {
    // alterar o status do login
    add(true); // inicia animação no botão login
    ApiResponse response = await LoginApi.login(login, senha);
    add(false); // encerra animação

    return response;
  }

}*/
