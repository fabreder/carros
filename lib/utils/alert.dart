import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

alert(BuildContext context, String msg) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return WillPopScope(
        // serve para não fechar no voltar do Android
        onWillPop: () async => false,
        // serve ara não fechar ao voltar no Android
        child: AlertDialog(
          title: Text("Carros"),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                pop(context);
              },
            )
          ],
        ),
      );
    },
  );
}
