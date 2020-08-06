import 'package:carros/pages/login/login_page.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  UserAccountsDrawerHeader _header(Usuario user) {
    return UserAccountsDrawerHeader(
      accountName: Text(user.nome),
      accountEmail: Text(user.email),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(user.urlFoto), // imagem online
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<Usuario> future = Usuario.get();

    return SafeArea(
      // serve para tirar a área que fica sobre a barra  superior do relógio, etc... (muito legal)
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder<Usuario>(
              future: future,
              builder:
                  (BuildContext context, AsyncSnapshot<Usuario> snapshot) {
                    Usuario user = snapshot.data;
                    return user != null ? _header(user) : Container();
                  },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text("Favoritos"),
              subtitle: Text("mais informações..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Ajuda"),
              subtitle: Text("mais informações..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                _onClickLogout(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onClickLogout(BuildContext context) {
    // limpa dados das prefs do usuário
    Usuario.clear();
    // fecha o menu lateral e volta para a página de login
    pop(context);
    push(context, LoginPage(), replace: true);
  }
}
