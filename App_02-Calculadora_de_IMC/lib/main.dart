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

  String textoInfromativo = 'Informe os seus Dados.';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  void apagarCampos(){
    pesoController.text = '';
    alturaController.text = '';
    setState(() {
      textoInfromativo = 'Informe os seus Dados.';
      _formKey = GlobalKey<FormState>();
    });
  }


  double? validarTextoDigitado(String? dado){

    try{
      if(dado != null){
        return double.tryParse(dado);
      }
    }
    catch (exception){
      return null;
    }

    return null;
  }


  void calcularImc(){
    double peso = double.parse(pesoController.text);
    double altura = double.parse(alturaController.text) / 100;

    double imc = peso / (altura * altura);

    setState(() {

      if(imc < 18.6){
        textoInfromativo = 'Abaixo do Peso. IMC = ${imc.toStringAsPrecision(3)}';
      }
      else if(imc >= 18.6 && imc < 24.9){
        textoInfromativo = 'Peso Ideal. IMC = ${imc.toStringAsPrecision(3)}';
      }
      else if(imc >= 24.9 && imc < 29.9){
        textoInfromativo = 'Levemente Acima do Peso. IMC = ${imc.toStringAsPrecision(3)}';
      }
      else if(imc >= 29.9 && imc < 34.9){
        textoInfromativo = 'Obesidade Grau I. IMC = ${imc.toStringAsPrecision(3)}';
      }
      else if(imc >= 34.9 && imc < 39.9){
        textoInfromativo = 'Obesidade Grau II. IMC = ${imc.toStringAsPrecision(3)}';
      }
      else if(imc >= 40){
        textoInfromativo = 'Obesidade Grau III. IMC = ${imc.toStringAsPrecision(3)}';
      }
    });
  }

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
            onPressed: apagarCampos,
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.deepPurple),
              TextFormField(
                controller: pesoController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green),
                decoration: InputDecoration(
                  labelText: 'Peso (kg)',
                  labelStyle: TextStyle(color: Colors.green, fontSize: 25.0),
                ),
                validator: (value){
                  if (validarTextoDigitado(value) == null){
                    return "Peso Inválido";
                  }
                },
              ),
              TextFormField(
                controller: alturaController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green),
                decoration: InputDecoration(
                  labelText: 'Altura (cm)',
                  labelStyle: TextStyle(color: Colors.green, fontSize: 25.0),
                ),
                validator: (value){
                  if (validarTextoDigitado(value) == null){
                    return "Altura Inválida";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        calcularImc();
                      }
                    },
                    child: Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
                  ),
                ),
              ),
              Text(
                textoInfromativo,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueAccent, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
