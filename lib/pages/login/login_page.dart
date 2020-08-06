import 'dart:async';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/carro/home_page.dart';
import 'package:carros/pages/login/login_api.dart';
import 'package:carros/pages/login/login_bloc.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _bloc = LoginBloc();
  final _formKey = GlobalKey<FormState>();
  final _tLogin = TextEditingController();
  final _tSenha = TextEditingController();
  final _focusSenha = FocusNode();

  @override
  void initState() {
    super.initState();

    // obtendo dados do último usuário logado
    Future<Usuario> future = Usuario.get();
    // aguardar o resultado
    future.then((Usuario user) {
      // testa se usuário é nulo
      if (user != null) {
        //poderia ir direto para a tela home
        push(context, HomePage(), replace: true);
        /*setState(() {
          // função para atualizar a tela (posso usar pois estou num StatefulWidget
          _tLogin.text = user.login;
        });*/
      }
    });
  }

  //--------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
      ),
      body: _body(),
    );
  }

  //--------------------------------------

  _body() {
    return Form(
      // necessário para fazer validação dos campos (não altera no visual)
      key: _formKey, // usado para conferir a validação dos campos do formulário
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppText(
              "Login",
              "Digite o login",
              controller: _tLogin,
              validator: _validateLogin,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              focusNext: _focusSenha,
            ),
            SizedBox(
              height: 20,
            ),
            AppText(
              "Senha",
              "Digite a senha",
              password: true,
              controller: _tSenha,
              validator: _validateSenha,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              focusNode: _focusSenha,
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<bool>(
              stream: _bloc.buttonBloc.stream,
              initialData: false, // garante um valor inicial e evitar erro de null
              builder: (context, snapshot) {
                return AppButton(
                  "Login",
                  onPressed: _onClickLogin,
                  showPregress: snapshot.data, // ou: "snapshot.data ?? false"  ou: "snapshot.data != null ? snapshot.data : false"
                );
              }
            ),
            // se tivesse parâmetros, poderia usar (){_onClickLogin(...);} ou () => _onClickLogin(...),
          ],
        ),
      ),
    );
  }

  //--------------------------------------

  String _validateLogin(String text) {
    // validação do texto digitado
    if (text.isEmpty) {
      return "Digite o login"; // significa que tem erro e esta é a mensagem
    }
    return null; // significa que está ok
  }

  //--------------------------------------

  String _validateSenha(String text) {
    // validação do texto digitado
    if (text.isEmpty) {
      return "Digite a senha"; // significa que tem erro e esta é a mensagem
    }
    if (text.length < 3) {
      return "A senha precisa ter pelo menos 3 números";
    }
    return null; // significa que está ok
  }

  //--------------------------------------

  _onClickLogin() async {
    // fazendo a validação do formulário através de _formKey
    if (!_formKey.currentState.validate()) {
      // melhore fazer o teste em uma mesmo linha
      return; // não prossegue
    }
    String login = _tLogin.text;
    String senha = _tSenha.text;

    // use o bloc para obter dados do usuário
    ApiResponse response = await _bloc.login(login, senha);

    // controle de excessão para formulários (diferente de listas - veja carros_bloc)
    if (response.ok) {
      push(context, HomePage(), replace: true);
    } else {
      alert(context, response.msg); // função criada em utils
    }
  }

  //--------------------------------------

  @override
  void dispose() {
    // será útil para gerenciar memória das telas
    super.dispose();

    // fechando o streamController (sempre é necessário)
    _bloc.dispose();
  }

}
