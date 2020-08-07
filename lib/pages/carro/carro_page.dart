import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/loripsum_api.dart';
import 'package:carros/widgets/text.dart';
import 'package:flutter/material.dart';

class CarroPage extends StatefulWidget {
  Carro carro;

  //--------------------------------------

  CarroPage(this.carro);

  //--------------------------------------

  @override
  _CarroPageState createState() => _CarroPageState();
}

//--------------------------------------

class _CarroPageState extends State<CarroPage> {
  final _bloc = LoripsumBloc();

  //--------------------------------------

  @override
  void initState() {
    super.initState();

    // lista de carros
    _bloc.fetch(); //poderia ser diretamente widget.tipo
  }

  //--------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carro.nome),
        actions: [
          IconButton(
            icon: Icon(Icons.place),
            onPressed: _onClickMapa,
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: _onClickVideo,
          ),
          PopupMenuButton<String>(
            onSelected: (String value) => _onClickPopupMenu(value),
            // poderia ser só assim: onSelected: _onClickPopupMenu
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: "Editar",
                  child: Text("Editar"),
                ),
                PopupMenuItem(
                  value: "Deletar",
                  child: Text("Deletar"),
                ),
                PopupMenuItem(
                  value: "Share",
                  child: Text("Share"),
                ),
              ];
            },
          ),
        ],
      ),
      body: _body(),
    );
  }

  //--------------------------------------

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      alignment: Alignment.topCenter,
      child: ListView(
        children: [
          Image.network(widget.carro.urlFoto),
          _bloco1(),
          Divider(), // uma linha divisória (pode mudar a cor)
          _bloco2(),
        ],
      ),
    );
  }

  //--------------------------------------

  Row _bloco1() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // dessa eu não sabia!!
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(widget.carro.nome, fontSize: 20, bold: true),
                // função criada em widgets para facilitar
                text(widget.carro.tipo),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 40,
                  ),
                  onPressed: _onClickFavorito,
                ),
                IconButton(
                  icon: Icon(
                    Icons.share,
                    size: 40,
                  ),
                  onPressed: _onClickShare,
                ),
              ],
            )
          ],
        );
  }

  //--------------------------------------

  _bloco2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12,),
        text(widget.carro.descricao, fontSize: 16, bold: true),
        SizedBox(height: 12,),
        StreamBuilder<String>(
            stream: _bloc.stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator(),);
                }
                return text(snapshot.data, fontSize: 16);
            }
        )
      ],
    );
  }

  //--------------------------------------

  void _onClickMapa() {}

  //--------------------------------------

  void _onClickVideo() {}

  //--------------------------------------

  _onClickPopupMenu(String value) {
    switch (value) {
      case "Editar":
        print("Editar....!!!");
        break;
      case "Deletar":
        print("Deletar....!!!");
        break;
      case "Share":
        print("Share....!!!");
        break;
    }
  }

  //--------------------------------------

  void _onClickFavorito() {
    print("Favorito....!!!");
  }

  //--------------------------------------

  void _onClickShare() {
    print("Share....!!!");
  }

  //--------------------------------------

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _bloc.dispose();
  }
}
