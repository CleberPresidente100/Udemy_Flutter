import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _controlador_altura = TextEditingController();
  TextEditingController _controlador_peso = TextEditingController();

  GlobalKey<FormState> _estado_formulario = GlobalKey<FormState>();

  String _texto_informativo = "Informe seus Dados.";

  void _limpar_campos(){
    _controlador_altura.text = "";
    _controlador_peso.text = "";

    setState(() {
      _texto_informativo = "Informe seus Dados.";
      _estado_formulario = GlobalKey<FormState>();
    });
  }

  void _calcular_imc(){
    double peso = double.parse(_controlador_peso.text);
    double altura = double.parse(_controlador_altura.text) / 100; // Converter a Altura para Metros
    double imc = peso / (altura * altura);

    setState(() {
      if(imc < 18.6){
        _texto_informativo = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      }
      else if(imc < 24.9){
        _texto_informativo = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      }
      else if(imc < 29.9){
        _texto_informativo = "Levemente Acima do Peso (${imc.toStringAsPrecision(3)})";
      }
      else if(imc < 34.9){
        _texto_informativo = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      }
      else if(imc < 39.9){
        _texto_informativo = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      }
      else{
        _texto_informativo = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _limpar_campos,
              ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 50),
        child: Form(
          key: _estado_formulario,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person_outline,
                  size: 130,
                  color: Colors.green,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (Kg)",
                    labelStyle: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 30,
                  ),
                  controller: _controlador_peso,
                  validator: (value){
                    if(value.isEmpty){
                      return "Insira o seu Peso !";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top:10, bottom: 10),
                  child:
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 30,
                    ),
                    controller: _controlador_altura,
                    validator: (value){
                      if(value.isEmpty){
                        return "Insira a sua Altura !";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:30, bottom: 30),
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      onPressed: (){
                        if(_estado_formulario.currentState.validate()){
                          _calcular_imc();
                        }
                      },
                      color: Colors.green,
                      child: Text(
                        "Calcular",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  "$_texto_informativo",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
