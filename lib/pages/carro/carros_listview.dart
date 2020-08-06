import 'dart:async';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_page.dart';
import 'package:carros/pages/carro/carros_bloc.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';

class CarrosListView extends StatefulWidget {
  String tipo;

  // construtor para saber que tipo de carro será exibido
  CarrosListView(this.tipo);

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

//--------------------------------------

class _CarrosListViewState extends State<CarrosListView>
    with AutomaticKeepAliveClientMixin<CarrosListView> {
  // para salvar o estado da tab

  final _bloc = CarrosBloc();
  List<Carro> carros;

  //--------------------------------------

  // forma alternativa para obter as variáveis da classe sem usar widget.
  String get tipo => widget.tipo;

  //--------------------------------------

  @override
  bool get wantKeepAlive => true; // para salvar o estado da tab

  //--------------------------------------

  @override
  void initState() {
    super.initState();

    // lista de carros
    _bloc.fetch(tipo); //poderia ser diretamente widget.tipo
  }

  //--------------------------------------

  @override
  Widget build(BuildContext context) {
    super.build(context); // para salvar o estado da tab

    return StreamBuilder(
      // tem como função converter um Future para Widget
      // fica aguardando retornar para mostrar um widget (não dá pra usar await aqui pois Future não é widget)
      stream: _bloc.stream,
      // forma de enviar a modificação a ser feita
      builder: (BuildContext context, AsyncSnapshot<List<Carro>> snapshot) {
        // se houve algum erro na obtenção dos dados, exiba uma mensagem vermelha e centralizada
        if (snapshot.hasError) {
          return TextError("Não foi possível buscar os carros");
        }

        // se não tiver dados na primeira vez que entrar, mostre uma barra circular de progresso
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Carro> carros = snapshot.data;
        return _ListView(carros);
      },
    );
  }

  //--------------------------------------

  Container _ListView(List<Carro> carros) {
    return Container(
      padding: EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: carros.length,
        itemBuilder: (context, index) {
          Carro c = carros[index];
          return Card(
            color: Colors.grey[100],
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // joga todos pra esquerda
                children: <Widget>[
                  Center(
                    // pra deixar a foto centralizada
                    child: Image.network(
                      c.urlFoto,
                      width: 250,
                    ),
                  ),
                  Text(
                    c.nome,
                    maxLines: 1,
                    // quero mostrar em apenas uma linha
                    overflow: TextOverflow.ellipsis,
                    // exibe ... quando não couber
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    "Descrição...",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('DETALHES'),
                        onPressed: () => _onClickCarro(c),
                      ),
                      FlatButton(
                        child: const Text('SHARE'),
                        onPressed: () {
                          /* ... */
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  //--------------------------------------

  _onClickCarro(Carro c) {
    push(context, CarroPage(c));
  }

  //--------------------------------------

  @override
  void dispose() {
    super.dispose();

    // fechando o streamController (sempre é necessário)
    _bloc.dispose();
  }

/* exemplo de como foi feito anteriormente...

  * class _CarrosListViewState extends State<CarrosListView> with AutomaticKeepAliveClientMixin<CarrosListView> { // para salvar o estado da tab
  List<Carro> carros;

  @override
  bool get wantKeepAlive => true; // para salvar o estado da tab

  @override
  void initState() { // usar para carregar os dados aqui e não no build
    super.initState();

    // ler dados para exibição
    _loadData();
  }

  Future<void> _loadData() async {
    // obtém a lista de carros do web service
    List<Carro> carros = await CarrosApi.getCarros(widget.tipo);

    // atualiza a lista de carros e redesenha tela
    setState(() {
      this.carros = carros;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // para salvar o estado da tab

    if (carros == null) { // se estiver nulo (primeira vez), mostre o circular progress indicator
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return _ListView(carros);
  }
  * */
}
