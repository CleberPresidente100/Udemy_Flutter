import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          bottom: 50.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(Icons.person_outline, size: 120.0, color: Colors.deepPurple),
            TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green),
              decoration: InputDecoration(
                labelText: 'Peso (kg)',
                labelStyle: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green),
              decoration: InputDecoration(
                labelText: 'Altura (cm)',
                labelStyle: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Container(
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Calcular',
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
                ),
              ),
            ),
            Text(
              'Info',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blueAccent, fontSize: 25.0),
            ),
          ],
        ),
      ),
    );
  }
}
