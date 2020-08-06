import 'package:flutter/material.dart';

// função para navegar para determinada página
Future push(BuildContext context, Widget page, {bool replace = false}) {
  // abre tela substituindo (destruindo) a página atual
  if (replace) {
    return Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
          return page;
        }));
  }

  // abre tela empilhando sobre a tela atual
  return Navigator.push(context,
      MaterialPageRoute(builder: (BuildContext context) {
    return page;
  }));
}

// função para retornar de determinada página
void pop(BuildContext context, {Object retorno}) {
  if (retorno != null) {
    Navigator.pop(context, retorno);
  } else {
    Navigator.pop(context);
  }
}
