
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


void main(){
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final String tarefa = "title";
  final String concluida = "concluido";

  final _controleNovaTarefa = TextEditingController();

  List _toDoList = [];

  Map<String, dynamic> _lastRemoved;
  int _lastRemovedPos;


  @override
  void initState() {
    super.initState();

    _lerArquivo().then((dados){
      setState(() {
        _toDoList = json.decode(dados);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),

      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controleNovaTarefa,
                    decoration: InputDecoration(
                      labelText: "Nova Tarefa",
                      labelStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ),


                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: RaisedButton(
                    color: Colors.blueAccent,

                    child: Text("Add",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    onPressed: _adicionarNaLista,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,

              child: ListView.builder(
                padding: EdgeInsets.only(top: 10),
                itemCount: _toDoList.length,
                itemBuilder: _itemDaLista,
              ),

            ),
          ),

        ],
      ),
    );
  }

  Widget _itemDaLista(context, index){
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      direction: DismissDirection.startToEnd,

      onDismissed: (direction){
        setState(() {
          _lastRemoved = Map.from(_toDoList[index]);
          _lastRemovedPos = index;
          _toDoList.removeAt(index);
          _salvarNoArquivo();

          final snack = SnackBar(
            duration: Duration(seconds: 5),
            content: Text("Tarefa \"${_lastRemoved[tarefa]}\" removida !"),

            action: SnackBarAction(
              label: "Desfazer",
              onPressed: (){
                setState(() {
                  _toDoList.insert(_lastRemovedPos, _lastRemoved);
                });
                _salvarNoArquivo();
              },
            ),

          );

          Scaffold.of(context).showSnackBar(snack);
        });
      },

      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-1, 0),
          child: Icon(Icons.delete, color: Colors.white,),
        ),
      ),

      child: CheckboxListTile(
        onChanged: (checked){
          setState(() {
            _toDoList[index][concluida] = checked;
          });
          _salvarNoArquivo();
        },

        title: Text(_toDoList[index][tarefa]),
        value: _toDoList[index][concluida],
        secondary: CircleAvatar(
          child: Icon(
            _toDoList[index][concluida] ? Icons.check : Icons.error
          ),
        ),
      ),
    );
  }


  void _adicionarNaLista(){
    Map<String, dynamic> novaTarefa = Map();
    novaTarefa[tarefa] = _controleNovaTarefa.text;

    novaTarefa[concluida] = false;
    _toDoList.add(novaTarefa);
    _salvarNoArquivo();

    setState(() {
      _controleNovaTarefa.text = "";
    });
  }

  Future<File> _abrirArquivo() async {
    try{
      final diretorio = await getApplicationDocumentsDirectory();
      return File("${diretorio.path}/lista.json");
    }catch(erro){
      return null;
    }
  }

  Future<File> _salvarNoArquivo() async {
    String dados = json.encode(_toDoList);

    try{
      final file = await _abrirArquivo();
      return file.writeAsString(dados);
    }catch(erro){
      return null;
    }
  }

  Future<String> _lerArquivo() async {
    try{
      final file = await _abrirArquivo();
      return file.readAsString();
    }catch(erro){
      return null;
    }
  }

  Future<Null> _refresh() async{
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _toDoList.sort((a,b){
        if(a[concluida] && !b[concluida]) return 1;
        else if(!a[concluida] && b[concluida]) return -1;
        else return 0;
      });
    });

    _salvarNoArquivo();

    return Null;
  }
}


