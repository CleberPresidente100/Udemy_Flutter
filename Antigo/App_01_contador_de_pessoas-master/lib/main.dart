import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: 'Contador de Pessoas',
      home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _contador = 0;

  String _info_text;

  void _altera_contador(int valor)
  {
    setState(() {
      _contador += valor;

      if(_contador < 0){
        _info_text = "Como isto é Possível !?";
      }
      else if(_contador > 20){
        _info_text = "Lotado !";
      }
      else{
        _info_text = "Pode Entrar.";
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          //"images/Imagem_Teste.png",
          "images/teste.jpg",
          fit: BoxFit.cover,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Pessoas: $_contador',
              style: TextStyle(
                  color: Colors.blueAccent, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 80, 10, 80),
                  child: FlatButton(
                    child: Text(
                      "+1",
                      style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          fontSize: 40),
                    ),
                    onPressed: () {
                      _altera_contador(1);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 80, 10, 80),
                  child: FlatButton(
                    child: Text(
                      "-1",
                      style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          fontSize: 40),
                    ),
                    onPressed: () {
                      _altera_contador(-1);
                    },
                  ),
                ),
              ],
            ),
            Text(
              "$_info_text",
              style: TextStyle(
                  color: Colors.deepPurpleAccent,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 30),
            )
          ],
        )
      ],
    );
  }
}
