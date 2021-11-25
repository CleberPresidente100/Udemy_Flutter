import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Lista de APIs Públicas
// https://github.com/public-apis/public-apis#currency-exchange
//
// API de Conversão de Moedas utilizada neste projeto
// https://github.com/fawazahmed0/currency-api#readme

const linkApiCurrenceExchange =
    'https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/eur.json';

void main() async {
  runApp(
    MaterialApp(
      home: Home(),
      theme: ThemeData(
          hintColor: Colors.amber,
          primaryColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
            hintStyle: TextStyle(color: Colors.amber),
          )),
    ),
  );
}

Future<Map> getListaMoedas() async {
  http.Response response = await http.get(Uri.parse(linkApiCurrenceExchange));
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double dolar = 0;
  double real = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text("Conversor de Moedas"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getListaMoedas(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Container(
                color: Colors.deepPurple,
                child: Center(
                  child: Text(
                    "Carregando Dados . . .",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            default:
              if (snapshot.hasError) {
                return Container(
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      "Erro ao Carregar os Dados . . .",
                      style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              else {
                dolar = snapshot.data!['eur']['usd'];
                real = snapshot.data!['eur']['brl'];
                //return Container(color: Colors.green);
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.monetization_on, size: 150.0, color: Colors.amber),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Reais',
                          labelStyle: TextStyle(color: Colors.amber),
                          border: OutlineInputBorder(),
                          prefixText: 'R\$ ',
                        ),
                        style:  TextStyle(color: Colors.amber, fontSize: 25.0),
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Dolares',
                          labelStyle: TextStyle(color: Colors.amber),
                          border: OutlineInputBorder(),
                          prefixText: 'US\$ ',
                        ),
                        style:  TextStyle(color: Colors.amber, fontSize: 25.0),
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Euros',
                          labelStyle: TextStyle(color: Colors.amber),
                          border: OutlineInputBorder(),
                          prefixText: 'EU\$ ',
                        ),
                        style:  TextStyle(color: Colors.amber, fontSize: 25.0),
                      ),
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
