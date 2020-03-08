import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


const url_cotacao = "https://api.hgbrasil.com/finance/quotations?format=json&key=626259f1";

void main() async {



  runApp(MaterialApp(
    home: Home(),
  ));
}

Future<Map> _receberCotacoes() async {
  http.Response resposta = await http.get(url_cotacao);
  return json.decode(resposta.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final realControler = TextEditingController();
  final euroControler = TextEditingController();
  final dolarControler = TextEditingController();

  double dolar;
  double euro;

  void _alterarReal(String valor){

    if(valor.isEmpty){
      _limparCampos();
      return;
    }

    double real = double.parse(valor);
    euroControler.text = (real/euro).toStringAsFixed(2);
    dolarControler.text = (real/dolar).toStringAsFixed(2);
  }

  void _alterarEuro(String valor){

    if(valor.isEmpty){
      _limparCampos();
      return;
    }

    double real = double.parse(valor) * euro;
    realControler.text = (real).toStringAsFixed(2);
    dolarControler.text = (real/dolar).toStringAsFixed(2);
  }

  void _alterarDolar(String valor){

    if(valor.isEmpty){
      _limparCampos();
      return;
    }

    double real = double.parse(valor) * dolar;
    euroControler.text = (real/euro).toStringAsFixed(2);
    realControler.text = (real).toStringAsFixed(2);
  }

  void _limparCampos(){
    realControler.text = "";
    euroControler.text = "";
    dolarControler.text = "";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: _receberCotacoes(),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando...",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 40,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if(snapshot.hasError){
                return Center(
                  child: Text(
                    "Erro ao Carregar Dados ...",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 40,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }
              else{
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(
                        Icons.monetization_on,
                        size: 150,
                        color: Colors.amber,
                      ),

                      contruirCampoMoeda("Reais", "R\$", Colors.amber, realControler, _alterarReal),
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child:
                          contruirCampoMoeda("Dólares", "US\$", Colors.green, dolarControler, _alterarDolar),
                      ),
                      contruirCampoMoeda("Euros", "€", Colors.deepPurple, euroControler, _alterarEuro),
                    ],
                  ),
                );
              }

          }

        },
      ),
    );
  }
}

Widget contruirCampoMoeda(String nome_moeda, String simbolo_moeda, Color cor_moeda, TextEditingController controlador, Function f){
  return TextField(
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30,
      color: cor_moeda,
    ),
    decoration: InputDecoration(
      labelText: "$nome_moeda",
      labelStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: cor_moeda,
      ),
      border: OutlineInputBorder(),
      prefixText: "$simbolo_moeda ",
    ),
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    controller: controlador,
    onChanged: f,
  );
}


