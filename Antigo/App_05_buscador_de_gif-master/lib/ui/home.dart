
import 'package:buscador_de_gif/ui/gif_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _search;
  int _offset = 0;

  Future<Map>_getGIFs() async {
    http.Response response;

    if(_search == null || _search.isEmpty){
      response = await http.get('https://api.giphy.com/v1/gifs/trending?api_key=mjixgh4t0cSawts8m2uPLTb6Bw0AShes&limit=25&rating=G');
    }
    else{
      response = await http.get('https://api.giphy.com/v1/gifs/search?api_key=mjixgh4t0cSawts8m2uPLTb6Bw0AShes&q=$_search&limit=25&offset=$_offset&rating=G&lang=pt');
    }

    return json.decode(response.body);

  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        //title: Image.network('https://developers.giphy.com/branch/master/static/header-logo-8974b8ae658f704a5b48a2d039b8ad93.gif'),
        happtitle: Image.asset('images/App_Gif_Header.gif'),
        //title: Image.asset('images/original.gif'),
        centerTitle: true,
      ),

      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18),

              decoration: InputDecoration(
                labelText: "Pesquise Aqui",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),

              onSubmitted: (text){
                setState(() {
                  _search = text;
                  _offset = 0;
                });
              },
            ),
          ),

          Expanded(
            child: FutureBuilder(
              future: _getGIFs(),
              builder: (context, snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Container(
                        width: 200,
                        height: 200,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      );
                    break;

                  default:
                    if(snapshot.hasError)return Container();
                    else return _createGIFTable(context, snapshot);

                }
              },
            ),
          ),
          
        ],
      ),
    );
  }


  int _getItemCount(List data){
    if(_search == null || _search.isEmpty)
      return data.length;
    else
      return data.length + 1;
  }


  Widget _createGIFTable(BuildContext context, AsyncSnapshot snapshot){
    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: _getItemCount(snapshot.data["data"]),

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),

      itemBuilder: (context, index){
        if(_search == null || _search.isEmpty || index < snapshot.data["data"].length){
          return GestureDetector(
            /*
            child: Image.network(snapshot.data["data"][index]["images"]["fixed_height"]["url"],
              height: 300,
              fit: BoxFit.cover,
            ),
            */
            child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: snapshot.data["data"][index]["images"]["fixed_height"]["url"],
                height: 300,
                fit: BoxFit.cover,

            ),

            onTap: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => GifPage(snapshot.data["data"][index]))
              );
            },

            onLongPress: (){
              Share.share(snapshot.data["data"][index]["images"]["fixed_height"]["url"]);
            },
          );
        }
        else{
          return Container(
            child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add, color: Colors.white, size: 70,),
                  Text("Carregar Mais ...",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ],
              ),
              onTap: (){
                setState(() {
                  _offset += 25;
                });
              },
            ),
          );
        }

      },

    );
  }
}
